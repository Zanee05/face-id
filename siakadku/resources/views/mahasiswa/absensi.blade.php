@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Registrasi Face ID Mahasiswa</h4>
    <div id="alertBox"></div>

    <div class="row g-3">
        {{-- Kamera --}}
        <div class="col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body p-2">
                    <div style="position:relative;">
                        <video id="video" width="100%" autoplay muted playsinline
                            style="border-radius:10px; display:block;"></video>
                        <canvas id="overlay" style="position:absolute;top:0;left:0;border-radius:10px;pointer-events:none;"></canvas>
                    </div>

                    {{-- Indikator Kualitas Real-time --}}
                    <div id="qualityBar" class="mt-2 px-1" style="display:none;">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <small class="text-muted fw-semibold">Kualitas Frame</small>
                            <small id="qualityLabel" class="fw-bold text-secondary">—</small>
                        </div>
                        <div class="d-flex gap-2">
                            <div class="flex-fill">
                                <div class="d-flex justify-content-between" style="font-size:10px;">
                                    <span class="text-muted">💡 Cahaya</span>
                                    <span id="brightnessVal">—</span>
                                </div>
                                <div class="progress" style="height:5px;">
                                    <div id="brightnessBar" class="progress-bar" style="width:0%;"></div>
                                </div>
                            </div>
                            <div class="flex-fill">
                                <div class="d-flex justify-content-between" style="font-size:10px;">
                                    <span class="text-muted">🔍 Ketajaman</span>
                                    <span id="sharpnessVal">—</span>
                                </div>
                                <div class="progress" style="height:5px;">
                                    <div id="sharpnessBar" class="progress-bar" style="width:0%;"></div>
                                </div>
                            </div>
                            <div class="flex-fill">
                                <div class="d-flex justify-content-between" style="font-size:10px;">
                                    <span class="text-muted">👤 Ukuran</span>
                                    <span id="faceVal">—</span>
                                </div>
                                <div class="progress" style="height:5px;">
                                    <div id="faceBar" class="progress-bar" style="width:0%;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        {{-- Panel Kontrol --}}
        <div class="col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body">

                    {{-- Status Face ID --}}
                    <div class="alert {{ $faceData ? 'alert-success' : 'alert-warning' }} py-2">
                        <b>Status Face ID:</b>
                        {{ $faceData ? 'Sudah terdaftar' : 'Belum terdaftar' }}
                        @if($faceData)
                            <br><small>Terakhir update: {{ $faceData->updated_at->format('d M Y H:i') }}</small>
                        @endif
                    </div>

                    {{-- Panduan Angle --}}
                    <div class="mb-3">
                        <p class="text-muted small mb-2">
                            Ambil <b>5 foto</b> dari angle berbeda agar Face ID lebih akurat.
                            Ikuti panduan posisi kepala di bawah:
                        </p>
                        <div class="d-flex flex-wrap gap-2" id="angleGuides">
                            @php
                                $angles = [
                                    ['id' => 0, 'label' => 'Depan',  'icon' => '😐'],
                                    ['id' => 1, 'label' => 'Kiri',   'icon' => '👈'],
                                    ['id' => 2, 'label' => 'Kanan',  'icon' => '👉'],
                                    ['id' => 3, 'label' => 'Atas',   'icon' => '☝️'],
                                    ['id' => 4, 'label' => 'Bawah',  'icon' => '👇'],
                                ];
                            @endphp
                            @foreach($angles as $angle)
                                <div class="text-center" style="width: 60px;">
                                    <div id="badge-{{ $angle['id'] }}"
                                        style="width:52px;height:52px;border-radius:50%;border:2px dashed #ccc;
                                               display:flex;align-items:center;justify-content:center;
                                               font-size:22px;background:#f8f9fa;margin:0 auto 4px;">
                                        {{ $angle['icon'] }}
                                    </div>
                                    <small class="text-muted" style="font-size:11px;">{{ $angle['label'] }}</small>
                                </div>
                            @endforeach
                        </div>
                    </div>

                    {{-- Liveness Detection Status --}}
                    <div id="livenessWrap" class="mb-3" style="display:none;">
                        <div class="alert py-2 mb-1 alert-warning" id="livenessAlert" style="font-size:0.875rem;">
                            <span id="livenessIcon">👁️</span>
                            <span id="livenessText">Kedipkan mata 2x untuk verifikasi liveness...</span>
                        </div>
                        <div class="d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center gap-2">
                                <div class="d-flex gap-1" id="blinkDots">
                                    <span class="badge bg-secondary rounded-circle" id="blink0" style="width:14px;height:14px;"></span>
                                    <span class="badge bg-secondary rounded-circle" id="blink1" style="width:14px;height:14px;"></span>
                                </div>
                                <small class="text-muted" style="font-size:10px;">Kedip 2x untuk konfirmasi wajah asli</small>
                            </div>
                            {{-- Debug EAR — membantu melihat nilai aktual --}}
                            <small id="earDebug" class="fw-bold" style="font-size:10px;font-family:monospace;">EAR: —</small>
                        </div>
                    </div>

                    {{-- Progress --}}
                    <div class="mb-3" id="progressWrap" style="display:none;">
                        <div class="d-flex justify-content-between mb-1">
                            <small class="text-muted">Progress foto</small>
                            <small id="progressLabel" class="fw-bold">0 / 5</small>
                        </div>
                        <div class="progress" style="height:8px;">
                            <div id="progressBar" class="progress-bar bg-primary"
                                style="width:0%; transition:width .4s ease;"></div>
                        </div>
                    </div>

                    {{-- Instruksi Angle Aktif --}}
                    <div id="instruksiAngle" class="alert alert-info py-2 small mb-3" style="display:none;">
                        Arahkan wajah <b id="angleAktifLabel">ke depan</b>.
                        <span id="autoCaptureTip" style="display:none;">
                            Foto akan diambil otomatis saat kondisi siap ✅
                        </span>
                    </div>

                    {{-- Countdown Auto-Capture --}}
                    <div id="countdownWrap" class="text-center mb-3" style="display:none;">
                        <div id="countdownCircle"
                             style="width:64px;height:64px;border-radius:50%;
                                    background:linear-gradient(135deg,#2563eb,#0ea5e9);
                                    display:inline-flex;align-items:center;justify-content:center;
                                    color:#fff;font-size:1.8rem;font-weight:800;
                                    box-shadow:0 0 0 4px rgba(37,99,235,0.2);
                                    transition:transform .1s;">
                            <span id="countdownNum">3</span>
                        </div>
                        <div class="text-muted small mt-1">Foto otomatis dalam...</div>
                    </div>

                    {{-- Tombol --}}
                    <div class="d-grid gap-2">
                        <button id="btnMulai" class="btn btn-primary">
                            📸 Mulai Registrasi Wajah (5 Foto)
                        </button>
                        <button id="btnAmbil" class="btn btn-success" style="display:none;" disabled>
                            📷 Ambil Foto Angle <span id="angleBtnLabel">1</span>/5
                        </button>
                        <button id="btnUlang" class="btn btn-outline-secondary btn-sm" style="display:none;">
                            🔄 Ulangi dari Awal
                        </button>
                    </div>

                    {{-- Thumbnail Preview --}}
                    <div class="d-flex flex-wrap gap-1 mt-3" id="thumbnailWrap"></div>

                </div>
            </div>
        </div>
    </div>
</div>

<canvas id="snapCanvas" style="display:none;"></canvas>
{{-- Canvas kecil untuk analisis kualitas pixel --}}
<canvas id="qualityCanvas" width="64" height="64" style="display:none;"></canvas>

<script>
// ─── Elemen DOM ───────────────────────────────────────────────────────────────
const video         = document.getElementById('video');
const overlay       = document.getElementById('overlay');
const alertBox      = document.getElementById('alertBox');
const progressBar   = document.getElementById('progressBar');
const progressLabel = document.getElementById('progressLabel');
const progressWrap  = document.getElementById('progressWrap');
const instruksi     = document.getElementById('instruksiAngle');
const angleLabel    = document.getElementById('angleAktifLabel');
const btnMulai      = document.getElementById('btnMulai');
const btnAmbil      = document.getElementById('btnAmbil');
const btnUlang      = document.getElementById('btnUlang');
const angleBtnLbl   = document.getElementById('angleBtnLabel');
const snapCanvas    = document.getElementById('snapCanvas');
const thumbWrap     = document.getElementById('thumbnailWrap');
const qualityCanvas = document.getElementById('qualityCanvas');
const qualityCtx    = qualityCanvas.getContext('2d');

// ─── Elemen Liveness & Quality ────────────────────────────────────────────────
const livenessWrap  = document.getElementById('livenessWrap');
const livenessAlert = document.getElementById('livenessAlert');
const livenessIcon  = document.getElementById('livenessIcon');
const livenessText  = document.getElementById('livenessText');
const qualityBarEl  = document.getElementById('qualityBar');
const qualityLabel  = document.getElementById('qualityLabel');
const brightnessBar = document.getElementById('brightnessBar');
const brightnessVal = document.getElementById('brightnessVal');
const sharpnessBar  = document.getElementById('sharpnessBar');
const sharpnessVal  = document.getElementById('sharpnessVal');
const faceBar       = document.getElementById('faceBar');
const faceVal       = document.getElementById('faceVal');
const csrfToken    = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

const ANGLE_LABELS = ['depan', 'ke kiri', 'ke kanan', 'ke atas', 'ke bawah'];
const ANGLE_NAMES  = ['Depan', 'Kiri', 'Kanan', 'Atas', 'Bawah'];

let embeddings     = [];
let currentAngle   = 0;
let isProcessing   = false;
let currentStream  = null;

// ─── State Liveness Detection ─────────────────────────────────────────────────
// Menggunakan Eye Aspect Ratio (EAR) dari 68 landmark wajah
// EAR < threshold → mata tertutup (kedip)
//
// Nilai EAR tipikal:
//   Mata terbuka normal : 0.25 – 0.40
//   Mata setengah tutup : 0.18 – 0.25
//   Mata tertutup penuh : 0.10 – 0.18
//
// Dinaikkan ke 0.28 agar lebih mudah terdeteksi di kamera laptop/HP
const EAR_THRESHOLD   = 0.28;  // di bawah ini = mata tertutup
const EAR_CONSEC_MIN  = 1;     // cukup 1 frame untuk 1 kedipan (lebih responsif)
const BLINKS_REQUIRED = 2;     // jumlah kedipan yang dibutuhkan

let livenessVerified  = false;
let blinkCount        = 0;
let earConsecFrames   = 0;
let livenessActive    = false;
let lastEarValue      = 0;     // untuk debug display

// ─── State Quality Check ──────────────────────────────────────────────────────
const QUALITY_MIN_BRIGHTNESS = 40;   // 0-255, terlalu gelap
const QUALITY_MAX_BRIGHTNESS = 220;  // 0-255, terlalu terang
const QUALITY_MIN_SHARPNESS  = 15;   // variance Laplacian, terlalu blur
const QUALITY_MIN_FACE_RATIO = 0.10; // wajah minimal 10% lebar frame

// ─── State Auto-Capture ───────────────────────────────────────────────────────
// Foto diambil otomatis saat: liveness ✅ + kualitas ✅ + countdown selesai
const AUTO_CAPTURE_DELAY_MS  = 3000; // 3 detik countdown sebelum foto
let autoCaptureTimer         = null;
let autoCaptureCountdown     = null;
let autoCaptureActive        = false; // true saat sedang registrasi
let isCapturing              = false; // mencegah double-capture

// ─── Utility ──────────────────────────────────────────────────────────────────

function showAlert(msg, type = 'info') {
    alertBox.innerHTML = `<div class="alert alert-${type} mt-2">${msg}</div>`;
}

function clearAlert() { alertBox.innerHTML = ''; }

function loadScript(src) {
    return new Promise((resolve, reject) => {
        if (document.querySelector(`script[src="${src}"]`) && window.faceapi) { resolve(); return; }
        const s = document.createElement('script');
        s.src = src; s.async = true;
        s.onload = resolve; s.onerror = () => reject(new Error(`Gagal muat: ${src}`));
        document.head.appendChild(s);
    });
}

async function ensureFaceApi() {
    if (window.faceapi) return;
    const srcs = [
        '{{ asset('js/face-api.min.js') }}',
        'https://cdn.jsdelivr.net/npm/face-api.js',
        'https://unpkg.com/face-api.js'
    ];
    for (const src of srcs) {
        try { await loadScript(src); if (window.faceapi) return; } catch(e) {}
    }
    throw new Error('Library face-api.js tidak ditemukan.');
}

async function setupCamera() {
    await ensureFaceApi();

    const modelPath = '/face-api-models';
    await faceapi.nets.tinyFaceDetector.loadFromUri(modelPath);
    await faceapi.nets.faceLandmark68Net.loadFromUri(modelPath);
    await faceapi.nets.faceRecognitionNet.loadFromUri(modelPath);

    // Cari deviceId kamera built-in, lalu start
    const builtInDeviceId = await findBuiltInCamera();
    await startCamera(builtInDeviceId);

    video.addEventListener('loadedmetadata', () => {
        overlay.width  = video.videoWidth;
        overlay.height = video.videoHeight;
    });
}

/**
 * Cari kamera built-in dengan cara:
 * 1. Minta izin dulu agar label kamera muncul
 * 2. Filter kamera yang labelnya BUKAN DroidCam / USB / external
 * 3. Jika tidak ada yang cocok, pakai kamera pertama (fallback)
 */
async function findBuiltInCamera() {
    try {
        // Minta izin dulu agar label kamera terisi, lalu TUNGGU sampai benar-benar dilepas
        const tmp = await navigator.mediaDevices.getUserMedia({ video: true });
        tmp.getTracks().forEach(t => {
            t.stop();
            t.enabled = false;
        });

        // Tunggu 800ms agar OS benar-benar melepas kamera sebelum enumerate
        await new Promise(r => setTimeout(r, 800));

        const devices = await navigator.mediaDevices.enumerateDevices();
        const cameras = devices.filter(d => d.kind === 'videoinput');

        if (cameras.length === 0) return null;

        // Kata kunci kamera external/virtual yang harus dihindari
        const externalKeywords = [
            'droid', 'usb', 'external', 'virtual', 'obs',
            'manycam', 'snap', 'iriun', 'epoccam', 'ivcam',
            'vcam', 'xsplit', 'streamlabs'
        ];

        // Cari kamera yang TIDAK mengandung kata kunci external
        const builtIn = cameras.find(cam => {
            const label = cam.label.toLowerCase();
            return !externalKeywords.some(kw => label.includes(kw));
        });

        if (builtIn) {
            console.log(`[Kamera] Pakai built-in: "${builtIn.label}"`);
            return builtIn.deviceId;
        }

        // Fallback: pakai kamera pertama jika semua terdeteksi sebagai external
        console.warn('[Kamera] Tidak ada built-in ditemukan, pakai kamera pertama:', cameras[0].label);
        return cameras[0].deviceId;

    } catch (err) {
        console.error('[Kamera] Gagal enumerate:', err);
        return null; // browser akan pilih default
    }
}

async function startCamera(deviceId = null) {
    try {
        if (currentStream) {
            currentStream.getTracks().forEach(track => {
                track.stop();
                track.enabled = false;
            });
            currentStream = null;
            // Tunggu OS melepas kamera
            await new Promise(r => setTimeout(r, 500));
        }

        // Jika ada deviceId spesifik, pakai itu. Jika tidak, pakai default browser.
        const constraints = deviceId
            ? { video: { deviceId: { exact: deviceId }, width: { ideal: 1280 }, height: { ideal: 720 } } }
            : { video: { width: { ideal: 1280 }, height: { ideal: 720 } } };

        // Retry sampai 3x jika "Device in use"
        let lastErr = null;
        for (let attempt = 1; attempt <= 3; attempt++) {
            try {
                currentStream = await navigator.mediaDevices.getUserMedia(constraints);
                break; // berhasil
            } catch (err) {
                lastErr = err;
                const isInUse = err.name === 'NotReadableError' || err.message.toLowerCase().includes('in use');
                if (isInUse && attempt < 3) {
                    console.warn(`[Kamera] Device in use, retry ${attempt}/3 dalam 1 detik...`);
                    await new Promise(r => setTimeout(r, 1000));
                } else {
                    throw err;
                }
            }
        }

        video.srcObject = currentStream;

        await new Promise((resolve, reject) => {
            video.onloadedmetadata = () => {
                video.play().then(resolve).catch(reject);
            };
            setTimeout(() => reject(new Error('Timeout kamera')), 8000);
        });

        // Sinkronkan overlay
        overlay.width  = video.videoWidth;
        overlay.height = video.videoHeight;
        overlay.style.width  = video.offsetWidth  + 'px';
        overlay.style.height = video.offsetHeight + 'px';

        console.log(`Kamera device aktif: ${video.videoWidth}x${video.videoHeight}`);

    } catch (err) {
        console.error('Error starting camera:', err);
        showAlert('❌ Gagal mengakses kamera: ' + err.message, 'danger');
        throw err;
    }
}

// ─── Offscreen Canvas (fix DroidCam) ─────────────────────────────────────────

const offscreenCanvas = document.createElement('canvas');
const offscreenCtx    = offscreenCanvas.getContext('2d');

function getVideoFrame() {
    const w = video.videoWidth;
    const h = video.videoHeight;
    if (!w || !h) return null;
    offscreenCanvas.width  = w;
    offscreenCanvas.height = h;
    offscreenCtx.drawImage(video, 0, 0, w, h);
    return offscreenCanvas;
}

// ─── LIVENESS DETECTION (Eye Aspect Ratio) ────────────────────────────────────
function calcEAR(eye) {
    // Hindari division by zero jika landmark terlalu dekat
    const dist = (a, b) => Math.sqrt((a.x - b.x) ** 2 + (a.y - b.y) ** 2);
    const v1 = dist(eye[1], eye[5]);
    const v2 = dist(eye[2], eye[4]);
    const h  = dist(eye[0], eye[3]);
    if (h < 1e-6) return 0.3;
    return (v1 + v2) / (2.0 * h);
}

function processLiveness(landmarks) {
    if (!livenessActive || livenessVerified) return;

    const pts      = landmarks.positions;
    const earLeft  = calcEAR(pts.slice(36, 42));
    const earRight = calcEAR(pts.slice(42, 48));
    const ear      = (earLeft + earRight) / 2.0;
    lastEarValue   = ear;

    // Update debug EAR di UI
    const earDisplay = document.getElementById('earDebug');
    if (earDisplay) {
        earDisplay.textContent = `EAR: ${ear.toFixed(3)}`;
        earDisplay.style.color = ear < EAR_THRESHOLD ? '#dc2626' : '#16a34a';
    }

    if (ear < EAR_THRESHOLD) {
        earConsecFrames++;
    } else {
        // Mata kembali terbuka setelah tertutup → 1 kedipan
        if (earConsecFrames >= EAR_CONSEC_MIN) {
            blinkCount++;
            updateBlinkUI(blinkCount);
            if (blinkCount >= BLINKS_REQUIRED) {
                livenessVerified = true;
                livenessAlert.className  = 'alert py-2 mb-1 alert-success';
                livenessIcon.textContent = '✅';
                livenessText.textContent = 'Liveness terverifikasi! Foto akan diambil otomatis...';
                btnAmbil.disabled = false;
            }
        }
        earConsecFrames = 0;
    }
}

function updateBlinkUI(count) {
    for (let i = 0; i < BLINKS_REQUIRED; i++) {
        const dot = document.getElementById(`blink${i}`);
        if (!dot) continue;
        dot.className    = i < count ? 'badge bg-success rounded-circle' : 'badge bg-secondary rounded-circle';
        dot.style.width  = '14px';
        dot.style.height = '14px';
    }
    livenessText.textContent = `Kedipan terdeteksi: ${count}/${BLINKS_REQUIRED}`;
}

function startLiveness() {
    livenessVerified = false; blinkCount = 0; earConsecFrames = 0; livenessActive = true;
    livenessWrap.style.display  = 'block';
    livenessAlert.className     = 'alert py-2 mb-1 alert-warning';
    livenessIcon.textContent    = '👁️';
    livenessText.textContent    = 'Kedipkan mata 2x untuk verifikasi liveness...';
    updateBlinkUI(0);
    btnAmbil.disabled = true;
}

function resetLiveness() {
    livenessVerified = false; blinkCount = 0; earConsecFrames = 0; livenessActive = false;
    livenessWrap.style.display = 'none';
    btnAmbil.disabled = false;
}

// ─── QUALITY CHECK ────────────────────────────────────────────────────────────
function analyzeFrameQuality(faceBox) {
    const w = video.videoWidth, h = video.videoHeight;
    if (!w || !h) return null;

    qualityCanvas.width = 64; qualityCanvas.height = 64;
    qualityCtx.drawImage(video, 0, 0, 64, 64);
    const imgData = qualityCtx.getImageData(0, 0, 64, 64).data;

    // Brightness
    let totalB = 0;
    const gray = [];
    for (let i = 0; i < imgData.length; i += 4) {
        const g = 0.299*imgData[i] + 0.587*imgData[i+1] + 0.114*imgData[i+2];
        gray.push(g); totalB += g;
    }
    const brightness = totalB / gray.length;

    // Sharpness (Laplacian variance)
    let lapSum = 0, lapSumSq = 0, lapCount = 0;
    for (let y = 1; y < 63; y++) {
        for (let x = 1; x < 63; x++) {
            const idx = y*64 + x;
            const lap = -gray[idx-65]-gray[idx-64]-gray[idx-63]
                        -gray[idx-1] +8*gray[idx] -gray[idx+1]
                        -gray[idx+63]-gray[idx+64]-gray[idx+65];
            lapSum += lap; lapSumSq += lap*lap; lapCount++;
        }
    }
    const lapMean  = lapSum / lapCount;
    const sharpness = Math.sqrt(lapSumSq/lapCount - lapMean*lapMean);

    const faceRatio = faceBox ? (faceBox.width / w) : 0;
    return { brightness, sharpness, faceRatio };
}

function updateQualityUI(quality) {
    if (!quality) return false;
    qualityBarEl.style.display = 'block';
    const { brightness, sharpness, faceRatio } = quality;

    const bOk = brightness >= QUALITY_MIN_BRIGHTNESS && brightness <= QUALITY_MAX_BRIGHTNESS;
    brightnessBar.style.width = Math.min(100, Math.round(brightness/255*100)) + '%';
    brightnessBar.className   = 'progress-bar ' + (bOk ? 'bg-success' : 'bg-danger');
    brightnessVal.textContent = bOk ? '✓' : (brightness < QUALITY_MIN_BRIGHTNESS ? 'Gelap' : 'Terang');

    const sOk = sharpness >= QUALITY_MIN_SHARPNESS;
    sharpnessBar.style.width = Math.min(100, Math.round(sharpness/50*100)) + '%';
    sharpnessBar.className   = 'progress-bar ' + (sOk ? 'bg-success' : 'bg-warning');
    sharpnessVal.textContent = sOk ? '✓' : 'Blur';

    const fOk = faceRatio >= QUALITY_MIN_FACE_RATIO;
    faceBar.style.width = Math.min(100, Math.round(faceRatio*200)) + '%';
    faceBar.className   = 'progress-bar ' + (fOk ? 'bg-success' : 'bg-warning');
    faceVal.textContent = fOk ? '✓' : 'Jauh';

    const allOk = bOk && sOk && fOk;
    qualityLabel.textContent = allOk ? '✅ Baik' : '⚠️ Kurang';
    qualityLabel.className   = 'fw-bold ' + (allOk ? 'text-success' : 'text-warning');
    return allOk;
}

function checkQualityBeforeCapture(quality) {
    if (!quality) return { ok: false, reason: 'Tidak bisa membaca frame kamera.' };
    const { brightness, sharpness, faceRatio } = quality;
    if (brightness < QUALITY_MIN_BRIGHTNESS)
        return { ok: false, reason: '⚠️ Pencahayaan terlalu gelap. Pindah ke tempat yang lebih terang.' };
    if (brightness > QUALITY_MAX_BRIGHTNESS)
        return { ok: false, reason: '⚠️ Pencahayaan terlalu terang. Hindari cahaya langsung ke kamera.' };
    if (sharpness < QUALITY_MIN_SHARPNESS)
        return { ok: false, reason: '⚠️ Gambar terlalu blur. Pastikan kamera fokus dan tidak bergerak.' };
    if (faceRatio < QUALITY_MIN_FACE_RATIO)
        return { ok: false, reason: '⚠️ Wajah terlalu jauh. Dekatkan wajah ke kamera.' };
    return { ok: true, reason: '' };
}

// ─── AUTO-CAPTURE ─────────────────────────────────────────────────────────────
const countdownWrap = document.getElementById('countdownWrap');
const countdownNum  = document.getElementById('countdownNum');
const autoCaptureTip = document.getElementById('autoCaptureTip');

/**
 * Mulai countdown 3 detik lalu ambil foto otomatis.
 * Dibatalkan jika kondisi tidak lagi terpenuhi.
 */
function startAutoCapture() {
    if (autoCaptureTimer || isCapturing) return; // sudah berjalan

    let remaining = 3;
    countdownWrap.style.display = 'block';
    countdownNum.textContent    = remaining;

    autoCaptureCountdown = setInterval(() => {
        remaining--;
        countdownNum.textContent = remaining;
        // Animasi pulse
        countdownNum.parentElement.style.transform = 'scale(1.15)';
        setTimeout(() => { countdownNum.parentElement.style.transform = 'scale(1)'; }, 150);

        if (remaining <= 0) {
            clearInterval(autoCaptureCountdown);
            autoCaptureCountdown = null;
        }
    }, 1000);

    autoCaptureTimer = setTimeout(async () => {
        autoCaptureTimer = null;
        countdownWrap.style.display = 'none';
        if (!autoCaptureActive || isCapturing) return;
        await doCapture();
    }, AUTO_CAPTURE_DELAY_MS);
}

/**
 * Batalkan countdown jika kondisi tidak lagi terpenuhi
 * (wajah hilang, kualitas turun, atau liveness hilang)
 */
function cancelAutoCapture() {
    if (autoCaptureTimer) {
        clearTimeout(autoCaptureTimer);
        autoCaptureTimer = null;
    }
    if (autoCaptureCountdown) {
        clearInterval(autoCaptureCountdown);
        autoCaptureCountdown = null;
    }
    countdownWrap.style.display = 'none';
}

/**
 * Logika utama capture — dipanggil baik dari auto maupun tombol manual
 */
async function doCapture() {
    if (isCapturing || isProcessing) return;
    isCapturing  = true;
    isProcessing = true;

    // Sembunyikan tombol sementara
    btnAmbil.disabled    = true;
    btnAmbil.textContent = '⏳ Memproses...';

    try {
        const frame = getVideoFrame();
        if (!frame) throw new Error('Frame tidak tersedia.');

        const det = await faceapi
            .detectSingleFace(frame, new faceapi.TinyFaceDetectorOptions({ inputSize: 416, scoreThreshold: 0.4 }))
            .withFaceLandmarks()
            .withFaceDescriptor();

        if (!det) throw new Error('Wajah tidak terdeteksi saat pengambilan foto.');

        const quality = analyzeFrameQuality(det.detection.box);
        const qCheck  = checkQualityBeforeCapture(quality);
        if (!qCheck.ok) throw new Error(qCheck.reason);

        const emb = Array.from(det.descriptor);

        // Flash effect
        overlay.style.background = 'rgba(255,255,255,0.6)';
        setTimeout(() => { overlay.style.background = ''; }, 150);

        // Reset liveness untuk foto berikutnya
        if (currentAngle < 4) {
            resetLiveness();
            startLiveness();
        }

        embeddings.push(emb);
        addThumbnail(currentAngle);
        updateBadge(currentAngle, true);
        currentAngle++;

        progressBar.style.width   = (currentAngle / 5 * 100) + '%';
        progressLabel.textContent = `${currentAngle} / 5`;

        if (currentAngle < 5) {
            setUICapturing(currentAngle);
            showAlert(`✅ Foto ${currentAngle}/5 berhasil. Sekarang arahkan wajah <b>${ANGLE_LABELS[currentAngle]}</b>.`, 'success');
            btnAmbil.disabled  = false;
            btnAmbil.innerHTML = `📷 Ambil Manual Angle <span id="angleBtnLabel">${currentAngle + 1}</span>/5`;
        } else {
            btnAmbil.style.display = 'none';
            autoCaptureActive      = false;
            showAlert('✅ Semua 5 foto diambil. Sedang menyimpan ke server...', 'info');
            const avgEmbedding = averageEmbeddings(embeddings);
            await submitEmbedding(avgEmbedding);
        }

    } catch (err) {
        showAlert(err.message || 'Terjadi error saat mengambil foto.', 'warning');
        btnAmbil.disabled  = false;
        btnAmbil.innerHTML = `📷 Ambil Manual Angle <span id="angleBtnLabel">${currentAngle + 1}</span>/5`;
    } finally {
        isCapturing  = false;
        isProcessing = false;
    }
}

// ─── Live Overlay Deteksi Wajah ───────────────────────────────────────────────
// Loop ini hanya untuk RENDER kotak wajah di overlay (visual).
// Liveness diproses di loop terpisah yang lebih cepat (livenessLoop).
async function drawLiveDetection() {
    if (!window.faceapi || !video.srcObject) { requestAnimationFrame(drawLiveDetection); return; }

    const frame = getVideoFrame();
    const detection = frame
        ? await faceapi
            .detectSingleFace(frame, new faceapi.TinyFaceDetectorOptions({ inputSize: 320, scoreThreshold: 0.4 }))
            .withFaceLandmarks()
        : null;

    const ctx = overlay.getContext('2d');
    ctx.clearRect(0, 0, overlay.width, overlay.height);

    if (detection) {
        const scaleX = overlay.width  / video.videoWidth;
        const scaleY = overlay.height / video.videoHeight;
        const box    = detection.detection.box;

        ctx.strokeStyle = livenessVerified ? '#16a34a' : '#2563eb';
        ctx.lineWidth   = 3;
        ctx.strokeRect(box.x * scaleX, box.y * scaleY, box.width * scaleX, box.height * scaleY);

        ctx.fillStyle = ctx.strokeStyle;
        ctx.font      = '13px sans-serif';
        const label   = livenessVerified ? 'Wajah asli ✓' : 'Wajah terdeteksi';
        ctx.fillText(label, box.x * scaleX, (box.y * scaleY) - 8);

        // Update quality indicator
        const quality   = analyzeFrameQuality(box);
        const qualityOk = updateQualityUI(quality);

        // Trigger auto-capture
        if (autoCaptureActive && livenessVerified && qualityOk && !isCapturing) {
            startAutoCapture();
        } else if (autoCaptureActive && (!livenessVerified || !qualityOk)) {
            cancelAutoCapture();
        }
    } else {
        qualityBarEl.style.display = 'none';
        if (autoCaptureActive) cancelAutoCapture();
    }

    requestAnimationFrame(drawLiveDetection);
}

// ─── Loop Liveness Terpisah (lebih cepat, 80ms interval) ─────────────────────
// Dipisah dari drawLiveDetection agar tidak terpengaruh lambatnya faceapi.detect.
// 80ms = ~12 fps, cukup untuk menangkap kedipan mata (~150ms).
let livenessLoopRunning = false;

async function startLivenessLoop() {
    if (livenessLoopRunning) return;
    livenessLoopRunning = true;

    while (livenessLoopRunning) {
        if (livenessActive && !livenessVerified && window.faceapi && video.srcObject) {
            try {
                const frame = getVideoFrame();
                if (frame) {
                    const det = await faceapi
                        .detectSingleFace(frame, new faceapi.TinyFaceDetectorOptions({ inputSize: 160, scoreThreshold: 0.3 }))
                        .withFaceLandmarks();
                    if (det && det.landmarks) {
                        processLiveness(det.landmarks);
                    }
                }
            } catch (e) { /* abaikan error sementara */ }
        }
        // Tunggu 80ms sebelum frame berikutnya
        await new Promise(r => setTimeout(r, 80));
    }
}

function stopLivenessLoop() {
    livenessLoopRunning = false;
}

// ─── Capture Satu Embedding ───────────────────────────────────────────────────

async function captureOneEmbedding() {
    // Validasi kualitas frame sebelum capture
    const frame = getVideoFrame();
    if (!frame) return null;

    // Cek deteksi wajah dulu untuk mendapat bounding box
    const det = await faceapi
        .detectSingleFace(frame, new faceapi.TinyFaceDetectorOptions({ inputSize: 416, scoreThreshold: 0.4 }))
        .withFaceLandmarks()
        .withFaceDescriptor();

    if (!det) return null;

    // Validasi kualitas
    const quality = analyzeFrameQuality(det.detection.box);
    const qCheck  = checkQualityBeforeCapture(quality);
    if (!qCheck.ok) {
        throw new Error(qCheck.reason);
    }

    return Array.from(det.descriptor);
}

// ─── Thumbnail Preview ────────────────────────────────────────────────────────

function addThumbnail(index) {
    snapCanvas.width  = video.videoWidth;
    snapCanvas.height = video.videoHeight;
    const ctx = snapCanvas.getContext('2d');
    ctx.drawImage(video, 0, 0);

    const img = document.createElement('img');
    img.src   = snapCanvas.toDataURL('image/jpeg', 0.6);
    img.style = 'width:56px;height:56px;object-fit:cover;border-radius:6px;border:2px solid #16a34a;';
    img.title = `Foto ${index + 1} — ${ANGLE_NAMES[index]}`;
    thumbWrap.appendChild(img);
}

// ─── Update Badge Angle ───────────────────────────────────────────────────────

function updateBadge(index, done = false) {
    const badge = document.getElementById(`badge-${index}`);
    if (!badge) return;
    badge.style.border      = done ? '2px solid #16a34a' : '2px solid #2563eb';
    badge.style.background  = done ? '#dcfce7' : '#eff6ff';
}

function resetBadges() {
    for (let i = 0; i < 5; i++) {
        const badge = document.getElementById(`badge-${i}`);
        if (!badge) continue;
        badge.style.border     = '2px dashed #ccc';
        badge.style.background = '#f8f9fa';
    }
}

// ─── Average Embeddings ───────────────────────────────────────────────────────

function normalizeEmbedding(embedding) {
    // Normalisasi L2: membuat vektor menjadi unit vector
    let sumSquares = 0;
    for (let i = 0; i < embedding.length; i++) {
        sumSquares += embedding[i] * embedding[i];
    }
    const magnitude = Math.sqrt(sumSquares);
    
    if (magnitude === 0) return embedding;
    
    return embedding.map(v => v / magnitude);
}

function averageEmbeddings(embList) {
    const len = embList[0].length;
    const avg = new Array(len).fill(0);
    
    // Normalisasi setiap embedding sebelum di-average
    const normalizedList = embList.map(emb => normalizeEmbedding(emb));
    
    // Hitung rata-rata
    for (const emb of normalizedList) {
        for (let i = 0; i < len; i++) avg[i] += emb[i];
    }
    
    const averaged = avg.map(v => v / normalizedList.length);
    
    // Normalisasi hasil akhir
    return normalizeEmbedding(averaged);
}

// ─── UI State ─────────────────────────────────────────────────────────────────

function setUICapturing(angle) {
    instruksi.style.display = 'block';
    progressWrap.style.display = 'block';
    angleLabel.textContent  = ANGLE_LABELS[angle];
    angleBtnLbl.textContent = angle + 1;

    progressBar.style.width   = (angle / 5 * 100) + '%';
    progressLabel.textContent = `${angle} / 5`;

    updateBadge(angle, false);
}

function resetUI() {
    embeddings   = [];
    currentAngle = 0;
    thumbWrap.innerHTML = '';
    resetBadges();
    progressBar.style.width   = '0%';
    progressLabel.textContent = '0 / 5';
    progressWrap.style.display  = 'none';
    instruksi.style.display     = 'none';
    btnMulai.style.display      = '';
    btnAmbil.style.display      = 'none';
    btnUlang.style.display      = 'none';
    qualityBarEl.style.display  = 'none';
    autoCaptureActive           = false;
    isCapturing                 = false;
    cancelAutoCapture();
    resetLiveness();
    clearAlert();
}

// ─── Event: Mulai ─────────────────────────────────────────────────────────────

btnMulai.addEventListener('click', () => {
    embeddings   = [];
    currentAngle = 0;
    thumbWrap.innerHTML = '';
    resetBadges();

    btnMulai.style.display = 'none';
    btnAmbil.style.display = '';
    btnUlang.style.display = '';
    autoCaptureActive      = true;
    setUICapturing(0);
    clearAlert();

    // Tampilkan tip auto-capture
    if (autoCaptureTip) autoCaptureTip.style.display = 'inline';

    // Mulai liveness detection
    startLiveness();
    showAlert('👁️ Kedipkan mata 2x. Foto akan diambil <b>otomatis</b> saat kondisi siap.', 'info');
});

// ─── Event: Ambil Foto ────────────────────────────────────────────────────────

// ─── Event: Ambil Foto (Manual Fallback) ─────────────────────────────────────
// Tombol ini hanya sebagai fallback jika auto-capture tidak berjalan.
// Logika utama ada di doCapture().
btnAmbil.addEventListener('click', async () => {
    cancelAutoCapture(); // batalkan countdown jika ada
    await doCapture();
});

// ─── Event: Ulangi ────────────────────────────────────────────────────────────

btnUlang.addEventListener('click', resetUI);

// ─── Submit ke Server ─────────────────────────────────────────────────────────

async function submitEmbedding(embedding) {
    try {
        const res = await fetch('{{ route('mahasiswa.absensi.register-face') }}', {
            method : 'POST',
            headers: {
                'Content-Type' : 'application/json',
                'X-CSRF-TOKEN' : csrfToken,
                'Accept'       : 'application/json'
            },
            body: JSON.stringify({ embedding })
        });

        const data = await res.json();

        if (res.ok) {
            showAlert('🎉 <b>Face ID berhasil disimpan!</b> Data wajah dari 5 angle telah dirata-rata dan disimpan.', 'success');
            btnUlang.style.display = '';
            btnMulai.style.display = 'none';
        } else {
            showAlert('Gagal menyimpan: ' + (data.message ?? 'Error tidak diketahui'), 'danger');
            resetUI();
        }

    } catch (err) {
        showAlert('Gagal menghubungi server: ' + err.message, 'danger');
        resetUI();
    }
}

// ─── Init ─────────────────────────────────────────────────────────────────────

setupCamera()
    .then(() => {
        showAlert('✅ Kamera siap. Klik tombol <b>Mulai Registrasi</b> untuk memulai.', 'info');
        drawLiveDetection();
        startLivenessLoop(); // loop liveness berjalan terus di background
    })
    .catch(err => {
        showAlert('❌ Gagal mengakses kamera/model: ' + err.message, 'danger');
        btnMulai.disabled = true;
    });
</script>
@endsection