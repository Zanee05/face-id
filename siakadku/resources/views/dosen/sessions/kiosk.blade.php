@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Kiosk Face ID - {{ optional($session->mataKuliah)->nama_mk }} ({{ optional($session->kelas)->nama_kelas }})</h4>
    <div id="msg" class="alert alert-info">Memuat model Face API...</div>
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="row g-3">
                <div class="col-lg-8">
                    {{-- Pilih Kamera --}}
                    <div class="mb-2">
                        <label for="cameraSelect" class="form-label small mb-1">Pilih Kamera:</label>
                        <select id="cameraSelect" class="form-select form-select-sm" style="max-width: 320px;">
                            <option value="">Mendeteksi kamera...</option>
                        </select>
                    </div>

                    <div class="position-relative d-inline-block">
                        <video id="video" width="520" autoplay muted playsinline class="rounded border"></video>
                        <canvas id="overlay" class="position-absolute top-0 start-0" style="pointer-events:none;"></canvas>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="border rounded p-3 h-100">
                        <h6 class="mb-2">Sudah Hadir</h6>
                        <ul id="list-hadir" class="mb-3 ps-3 small"></ul>
                        <h6 class="mb-2">Belum Hadir</h6>
                        <ul id="list-belum" class="mb-0 ps-3 small"></ul>
                    </div>
                </div>
            </div>
            <div class="mt-3">
                <a class="btn btn-outline-secondary" href="{{ route('dosen.sessions.show', $session) }}">Kembali</a>
            </div>
        </div>
    </div>
</div>

<script>
// ─── Elemen ───────────────────────────────────────────────────────────────────
const video        = document.getElementById('video');
const overlay      = document.getElementById('overlay');
const overlayCtx   = overlay.getContext('2d');
const msg          = document.getElementById('msg');
const cameraSelect = document.getElementById('cameraSelect');
const csrf         = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

// ─── Konstanta ────────────────────────────────────────────────────────────────
const SCAN_INTERVAL_MS       = 1000;
const RECOGNIZE_COOLDOWN_MS  = 4000;
const LABEL_STALE_MS         = 5000;
const AUTO_SUBMIT_CONFIDENCE = 80;
const ALERT_COOLDOWN_MS      = 2000;

// ─── State ────────────────────────────────────────────────────────────────────
let isProcessing     = false;
let currentStream    = null;
let availableCameras = [];
let lastAlertMsg     = '';
let lastAlertTime    = 0;
const trackedFaces   = [];

// ─── Liveness State (Kiosk) ───────────────────────────────────────────────────
// Di kiosk, liveness dicek per wajah yang terdeteksi.
// Setiap trackedFace punya counter kedipan sendiri.
//
// Nilai EAR tipikal:
//   Mata terbuka : 0.25 – 0.40
//   Mata kedip   : 0.10 – 0.22
//
// Threshold dinaikkan ke 0.28 agar lebih mudah terdeteksi
const EAR_THRESHOLD_KIOSK  = 0.28;
const EAR_CONSEC_MIN_KIOSK  = 1;   // 1 frame cukup — loop liveness berjalan cepat
const BLINKS_REQUIRED_KIOSK = 1;   // cukup 1 kedipan di kiosk

// ─── Data Mahasiswa ───────────────────────────────────────────────────────────
const hadirListEl       = document.getElementById('list-hadir');
const belumListEl       = document.getElementById('list-belum');
const allMahasiswaNames = @json($mahasiswaKandidat->pluck('nama')->values());
const hadirNames        = new Set(@json($hadirNames));

// ─── Offscreen Canvas (kunci fix DroidCam) ────────────────────────────────────
// face-api TIDAK bisa baca pixel langsung dari DroidCam virtual camera.
// Solusi: copy frame video ke canvas dulu via drawImage(), baru deteksi dari canvas.
const offscreen    = document.createElement('canvas');
const offscreenCtx = offscreen.getContext('2d');

const requiredModelFiles = [
    'tiny_face_detector_model-weights_manifest.json',
    'tiny_face_detector_model-shard1',
    'face_landmark_68_model-weights_manifest.json',
    'face_landmark_68_model-shard1',
    'face_recognition_model-weights_manifest.json',
    'face_recognition_model-shard1',
    'face_recognition_model-shard2'
];

// ─── Load face-api.js ─────────────────────────────────────────────────────────
function loadScript(src) {
    return new Promise((resolve, reject) => {
        if (document.querySelector(`script[src="${src}"]`) && window.faceapi) { resolve(); return; }
        const s = document.createElement('script');
        s.src = src; s.async = true;
        s.onload = resolve;
        s.onerror = () => reject(new Error(`Gagal memuat ${src}`));
        document.head.appendChild(s);
    });
}

async function ensureFaceApiLoaded() {
    if (window.faceapi) return;
    for (const src of [
        '{{ asset('js/face-api.min.js') }}',
        'https://cdn.jsdelivr.net/npm/face-api.js',
        'https://unpkg.com/face-api.js'
    ]) {
        try { await loadScript(src); if (window.faceapi) return; } catch (e) {}
    }
    throw new Error('Library face-api.js tidak tersedia.');
}

// ─── Kamera ───────────────────────────────────────────────────────────────────
async function enumerateCameras() {
    // Minta izin dulu agar label kamera muncul
    const tmp = await navigator.mediaDevices.getUserMedia({ video: true });
    tmp.getTracks().forEach(t => t.stop());

    const devices = await navigator.mediaDevices.enumerateDevices();
    availableCameras = devices.filter(d => d.kind === 'videoinput');

    cameraSelect.innerHTML = '';
    availableCameras.forEach((cam, i) => {
        const opt = document.createElement('option');
        opt.value = cam.deviceId;
        opt.text  = cam.label || `Kamera ${i + 1}`;
        cameraSelect.appendChild(opt);
    });

    // Auto-pilih DroidCam / external jika ada
    const ext = availableCameras.find(c => /droid|usb|external|webcam/i.test(c.label));
    if (ext) cameraSelect.value = ext.deviceId;
}

async function startCamera(deviceId) {
    if (currentStream) {
        currentStream.getTracks().forEach(t => t.stop());
        currentStream = null;
    }

    // 640x480 paling kompatibel dengan DroidCam, coba dulu
    const configs = [
        { video: { deviceId: deviceId ? { exact: deviceId } : undefined, width: { ideal: 640 }, height: { ideal: 480 } } },
        { video: { deviceId: deviceId ? { exact: deviceId } : undefined, width: { ideal: 1280 }, height: { ideal: 720 } } },
        { video: { deviceId: deviceId ? { exact: deviceId } : undefined } },
    ];

    let lastErr = null;
    for (const cfg of configs) {
        try {
            const stream = await navigator.mediaDevices.getUserMedia(cfg);
            video.srcObject = stream;

            // Tunggu metadata + play
            await new Promise((res, rej) => {
                const t = setTimeout(() => rej(new Error('Timeout metadata')), 8000);
                video.onloadedmetadata = () => { clearTimeout(t); video.play().then(res).catch(rej); };
            });

            // Tunggu frame pertama benar-benar ada (bukan hitam/hijau)
            await waitForRealFrame();

            if (video.videoWidth > 0 && video.videoHeight > 0) {
                currentStream = stream;
                syncOverlay();
                console.log(`[Kamera OK] ${video.videoWidth}x${video.videoHeight}`);
                return;
            }
            stream.getTracks().forEach(t => t.stop());
        } catch (e) {
            lastErr = e;
            console.warn('[startCamera] gagal:', e.message);
            if (currentStream) { currentStream.getTracks().forEach(t => t.stop()); currentStream = null; }
        }
    }
    throw lastErr || new Error('Semua konfigurasi kamera gagal.');
}

// Tunggu sampai pixel video bukan hitam/hijau solid
function waitForRealFrame() {
    return new Promise(resolve => {
        let tries = 0;
        const check = () => {
            tries++;
            if (video.videoWidth > 0 && video.videoHeight > 0) {
                offscreen.width  = video.videoWidth;
                offscreen.height = video.videoHeight;
                offscreenCtx.drawImage(video, 0, 0);
                const px = offscreenCtx.getImageData(
                    Math.floor(video.videoWidth / 2),
                    Math.floor(video.videoHeight / 2),
                    1, 1
                ).data;
                const isBlack = px[0] < 10 && px[1] < 10 && px[2] < 10;
                const isGreen = px[0] < 10 && px[1] > 80  && px[2] < 10;
                if (!isBlack && !isGreen) { resolve(); return; }
            }
            if (tries < 40) setTimeout(check, 100); // max 4 detik
            else resolve();
        };
        setTimeout(check, 300);
    });
}

// Sinkronkan ukuran overlay dengan ukuran tampilan video
function syncOverlay() {
    overlay.width  = video.videoWidth;
    overlay.height = video.videoHeight;
    overlay.style.width  = video.offsetWidth  + 'px';
    overlay.style.height = video.offsetHeight + 'px';
}

// ─── Ambil Frame ke Offscreen Canvas ─────────────────────────────────────────
function grabFrame() {
    const w = video.videoWidth;
    const h = video.videoHeight;
    if (!w || !h || video.readyState < 2) return null;
    offscreen.width  = w;
    offscreen.height = h;
    offscreenCtx.drawImage(video, 0, 0, w, h);
    return offscreen;
}

// ─── Render Daftar Hadir ──────────────────────────────────────────────────────
function renderPresenceList() {
    const sortedHadir = Array.from(hadirNames).sort((a, b) => a.localeCompare(b));
    const sortedBelum = allMahasiswaNames.filter(n => !hadirNames.has(n)).sort((a, b) => a.localeCompare(b));

    hadirListEl.innerHTML = sortedHadir.length
        ? sortedHadir.map(n => `<li>${n}</li>`).join('')
        : '<li class="text-muted">Belum ada</li>';

    belumListEl.innerHTML = sortedBelum.length
        ? sortedBelum.map(n => `<li>${n}</li>`).join('')
        : '<li class="text-success">Semua mahasiswa sudah hadir</li>';
}

// ─── Gambar Kotak Wajah ───────────────────────────────────────────────────────
function drawFaces(detections) {
    // Koordinat deteksi dari offscreen (ukuran asli video),
    // perlu di-scale ke ukuran tampilan overlay (CSS px)
    const scaleX = overlay.width  / (offscreen.width  || overlay.width);
    const scaleY = overlay.height / (offscreen.height || overlay.height);

    overlayCtx.clearRect(0, 0, overlay.width, overlay.height);

    for (const item of detections) {
        const b  = item.detection.box;
        const x  = b.x      * scaleX;
        const y  = b.y      * scaleY;
        const bw = b.width  * scaleX;
        const bh = b.height * scaleY;

        overlayCtx.strokeStyle = '#00ff66';
        overlayCtx.lineWidth   = 3;
        overlayCtx.strokeRect(x, y, bw, bh);

        const label = item.label || '';
        if (!label) continue;

        const fs  = 15;
        const pad = 6;
        overlayCtx.font = `bold ${fs}px Arial`;
        const tw  = overlayCtx.measureText(label).width;
        const lx  = x;
        const ly  = Math.max(y - fs - pad * 2, 2);

        overlayCtx.fillStyle = 'rgba(0,0,0,0.75)';
        overlayCtx.fillRect(lx, ly, tw + pad * 2, fs + pad);
        overlayCtx.fillStyle = '#fff';
        overlayCtx.fillText(label, lx + pad, ly + fs);
    }
}

// ─── Tracked Faces ────────────────────────────────────────────────────────────
function normalizeL2(vec) {
    let ss = 0;
    for (const v of vec) ss += v * v;
    const mag = Math.sqrt(ss);
    return mag === 0 ? vec : vec.map(v => v / mag);
}

function descriptorDistance(a, b) {
    if (!a || !b || a.length !== b.length) return Infinity;
    const na = normalizeL2(a), nb = normalizeL2(b);
    let s = 0;
    for (let i = 0; i < na.length; i++) { const d = na[i] - nb[i]; s += d * d; }
    return Math.sqrt(s);
}

function getOrCreateTrackedFace(desc) {
    let best = null, bestDist = Infinity;
    for (const f of trackedFaces) {
        const d = descriptorDistance(Array.from(desc), f.descriptor);
        if (d < bestDist) { bestDist = d; best = f; }
    }
    if (best && bestDist <= 0.42) {
        best.descriptor = Array.from(desc);
        return best;
    }
    const face = {
        descriptor        : Array.from(desc),
        lastRecognizedName: '',
        lastRecognizedAt  : 0,
        lastAttemptAt     : 0,
        // Liveness state per wajah
        blinkCount        : 0,
        earConsecFrames   : 0,
        livenessVerified  : false,
    };
    trackedFaces.push(face);
    if (trackedFaces.length > 50) trackedFaces.shift();
    return face;
}

// ─── Liveness per wajah (kiosk) ───────────────────────────────────────────────
function calcEAR(eye) {
    const dist = (a, b) => Math.sqrt((a.x - b.x) ** 2 + (a.y - b.y) ** 2);
    const v1 = dist(eye[1], eye[5]);
    const v2 = dist(eye[2], eye[4]);
    const h  = dist(eye[0], eye[3]);
    if (h < 1e-6) return 0.3; // hindari division by zero
    return (v1 + v2) / (2.0 * h);
}

function processLivenessKiosk(trackedFace, landmarks) {
    if (trackedFace.livenessVerified) return true;
    const pts = landmarks.positions;
    const ear = (calcEAR(pts.slice(36, 42)) + calcEAR(pts.slice(42, 48))) / 2.0;

    if (ear < EAR_THRESHOLD_KIOSK) {
        trackedFace.earConsecFrames++;
    } else {
        if (trackedFace.earConsecFrames >= EAR_CONSEC_MIN_KIOSK) {
            trackedFace.blinkCount++;
            if (trackedFace.blinkCount >= BLINKS_REQUIRED_KIOSK) {
                trackedFace.livenessVerified = true;
            }
        }
        trackedFace.earConsecFrames = 0;
    }
    return trackedFace.livenessVerified;
}

// ─── Snapshot ─────────────────────────────────────────────────────────────────
function captureSnapshot() {
    if (!offscreen.width || !offscreen.height) return null;
    return offscreen.toDataURL('image/jpeg', 0.85);
}

// ─── Beep ─────────────────────────────────────────────────────────────────────
function playSuccessBeep() {
    try {
        const ac  = new (window.AudioContext || window.webkitAudioContext)();
        const osc = ac.createOscillator();
        const g   = ac.createGain();
        osc.type = 'sine';
        osc.frequency.setValueAtTime(880, ac.currentTime);
        g.gain.setValueAtTime(0.12, ac.currentTime);
        osc.connect(g); g.connect(ac.destination);
        osc.start(); osc.stop(ac.currentTime + 0.15);
    } catch (e) {}
}

// ─── Identifikasi ke Server ───────────────────────────────────────────────────
function extractName(message) {
    if (!message) return '';
    let m = message.match(/Absensi berhasil untuk\s+(.+)$/i);
    if (m) return m[1].trim();
    m = message.match(/^(.+)\s+sudah tercatat pada sesi ini\./i);
    if (m) return m[1].trim();
    return '';
}

async function identifyFace(descriptor, trackedFace, snapshot) {
    const res  = await fetch('{{ route('dosen.sessions.identify-face', $session) }}', {
        method : 'POST',
        headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-TOKEN': csrf },
        body   : JSON.stringify({ embedding: Array.from(descriptor), snapshot_base64: snapshot })
    });
    const data    = await res.json();
    const message = data.message || 'Proses selesai';
    const name    = data.recognized_name || extractName(message);

    trackedFace.lastAttemptAt = Date.now();

    if (name && (res.ok || data.confidence >= AUTO_SUBMIT_CONFIDENCE)) {
        trackedFace.lastRecognizedName = name;
        trackedFace.lastRecognizedAt   = Date.now();
        hadirNames.add(name);
        renderPresenceList();
    }

    if (res.ok && data.confidence >= AUTO_SUBMIT_CONFIDENCE) playSuccessBeep();

    // Tampilkan pesan + confidence aktual agar mudah dimonitor
    const confText = data.confidence != null ? ` [${data.confidence}%]` : '';
    const distText = data.distance   != null ? ` dist:${data.distance}` : '';
    const fullMsg  = message + confText + distText;

    const now = Date.now();
    if (fullMsg !== lastAlertMsg || now - lastAlertTime > ALERT_COOLDOWN_MS) {
        msg.className   = res.ok ? 'alert alert-success' : 'alert alert-warning';
        msg.textContent = fullMsg;
        lastAlertMsg  = fullMsg;
        lastAlertTime = now;
    }
}

// ─── Loop Liveness Kiosk (80ms — lebih cepat dari autoScan 1000ms) ───────────
// Dipisah agar kedipan ~150ms tidak terlewat oleh interval 1000ms autoScan.
// Loop ini hanya deteksi landmark untuk EAR — tidak butuh descriptor.
let kioskLivenessRunning = false;

// Cache trackedFace terakhir yang terdeteksi untuk diupdate liveness-nya
let lastDetectedFaceForLiveness = null;

async function startKioskLivenessLoop() {
    if (kioskLivenessRunning) return;
    kioskLivenessRunning = true;

    while (kioskLivenessRunning) {
        if (window.faceapi && video.srcObject && video.readyState >= 2) {
            try {
                const frame = grabFrame();
                if (frame) {
                    // Deteksi landmark saja (tanpa descriptor — lebih cepat)
                    const dets = await faceapi
                        .detectAllFaces(frame, new faceapi.TinyFaceDetectorOptions({
                            inputSize     : 160,
                            scoreThreshold: 0.3
                        }))
                        .withFaceLandmarks();

                    for (const det of dets) {
                        // Cari trackedFace yang posisinya paling dekat dengan deteksi ini
                        // berdasarkan posisi bounding box (bukan descriptor)
                        const box = det.detection.box;
                        const cx  = box.x + box.width  / 2;
                        const cy  = box.y + box.height / 2;

                        // Update liveness untuk semua trackedFace yang belum verified
                        // (di kiosk biasanya hanya 1 orang di depan kamera)
                        for (const tf of trackedFaces) {
                            if (!tf.livenessVerified) {
                                processLivenessKiosk(tf, det.landmarks);
                            }
                        }
                    }
                }
            } catch (e) { /* abaikan error sementara */ }
        }
        await new Promise(r => setTimeout(r, 80));
    }
}

// ─── Auto Scan Loop ───────────────────────────────────────────────────────────
function startAutoScan() {
    setInterval(async () => {
        if (isProcessing) return;

        const frame = grabFrame();
        if (!frame) return;

        isProcessing = true;
        try {
            const detections = await faceapi
                .detectAllFaces(frame, new faceapi.TinyFaceDetectorOptions({
                    inputSize     : 416,
                    scoreThreshold: 0.35
                }))
                .withFaceLandmarks()
                .withFaceDescriptors();

            const now = Date.now();

            if (!detections.length) { drawFaces([]); return; }

            // Gambar kotak semua wajah
            drawFaces(detections.map(det => {
                const tf     = getOrCreateTrackedFace(det.descriptor);
                const isLive = tf.livenessVerified;
                return {
                    detection: det.detection,
                    label: (now - tf.lastRecognizedAt < LABEL_STALE_MS)
                        ? tf.lastRecognizedName
                        : (isLive ? '' : '👁️ Kedip...')
                };
            }));

            // Kirim ke server hanya jika liveness terverifikasi dan belum cooldown
            for (const det of detections) {
                const tf = getOrCreateTrackedFace(det.descriptor);
                if (now - tf.lastAttemptAt < RECOGNIZE_COOLDOWN_MS) continue;

                if (!tf.livenessVerified) {
                    const now2 = Date.now();
                    if (now2 - lastAlertTime > ALERT_COOLDOWN_MS) {
                        msg.className   = 'alert alert-info';
                        msg.textContent = '👁️ Kedipkan mata untuk verifikasi liveness...';
                        lastAlertMsg  = '👁️ Kedipkan mata untuk verifikasi liveness...';
                        lastAlertTime = now2;
                    }
                    continue;
                }

                await identifyFace(det.descriptor, tf, captureSnapshot());
            }
        } catch (err) {
            console.error('[AutoScan]', err);
        } finally {
            isProcessing = false;
        }
    }, SCAN_INTERVAL_MS);
}

// ─── Boot ─────────────────────────────────────────────────────────────────────
(async () => {
    try {
        renderPresenceList();

        await ensureFaceApiLoaded();

        // Cek kelengkapan model
        const missing = [];
        for (const f of requiredModelFiles) {
            const r = await fetch(`/face-api-models/${f}`, { cache: 'no-store' });
            if (!r.ok) missing.push(f);
        }
        if (missing.length) throw new Error(`Model tidak lengkap: ${missing.join(', ')}`);

        await faceapi.nets.tinyFaceDetector.loadFromUri('/face-api-models');
        await faceapi.nets.faceLandmark68Net.loadFromUri('/face-api-models');
        await faceapi.nets.faceRecognitionNet.loadFromUri('/face-api-models');

        msg.textContent = 'Mendeteksi kamera...';
        await enumerateCameras();

        const deviceId = cameraSelect.value || availableCameras[0]?.deviceId;
        await startCamera(deviceId);

        msg.className   = 'alert alert-success';
        msg.textContent = 'Kamera siap. Arahkan wajah ke kamera.';

        startAutoScan();
        startKioskLivenessLoop(); // loop liveness cepat (80ms) berjalan paralel

        window.addEventListener('resize', syncOverlay);

    } catch (err) {
        msg.className   = 'alert alert-danger';
        msg.textContent = `Gagal: ${err?.message || 'unknown error'}`;
        console.error('[Boot]', err);
    }
})();

// ─── Ganti Kamera ─────────────────────────────────────────────────────────────
cameraSelect.addEventListener('change', async () => {
    const deviceId = cameraSelect.value;
    if (!deviceId) return;
    try {
        msg.className   = 'alert alert-info';
        msg.textContent = 'Mengganti kamera...';
        await startCamera(deviceId);
        msg.className   = 'alert alert-success';
        msg.textContent = 'Kamera berhasil diganti. Arahkan wajah ke kamera.';
    } catch (err) {
        msg.className   = 'alert alert-danger';
        msg.textContent = 'Gagal mengganti kamera: ' + err.message;
    }
});
</script>
@endsection
