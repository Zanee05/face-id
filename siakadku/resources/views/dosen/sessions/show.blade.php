@extends('layouts.app')

@section('content')
<div class="container">
    <div class="d-flex align-items-center justify-content-between mb-3">
        <h4 class="mb-0">Detail Sesi Absensi</h4>
        <a href="{{ route('dosen.sessions.index') }}" class="btn btn-sm btn-outline-secondary">← Kembali</a>
    </div>

    {{-- ─── Info Sesi ─────────────────────────────────────────────── --}}
    <div class="card shadow-sm mb-3">
        <div class="card-body">
            <div class="row g-2">
                <div class="col-md-6">
                    <p class="mb-1"><b>Kelas:</b> {{ optional($session->kelas)->nama_kelas }}</p>
                    <p class="mb-1"><b>Mata Kuliah:</b> {{ optional($session->mataKuliah)->nama_mk }}</p>
                    <p class="mb-1"><b>Metode:</b>
                        <span class="badge bg-{{ $session->method === 'faceid' ? 'primary' : ($session->method === 'barcode' ? 'success' : 'secondary') }}">
                            {{ strtoupper($session->method) }}
                        </span>
                    </p>
                    <p class="mb-1"><b>Tanggal:</b> {{ $session->session_date->format('d M Y') }}</p>
                    <p class="mb-1"><b>Waktu:</b> {{ $session->start_time }} – {{ $session->end_time }}</p>
                    <p class="mb-0"><b>Status:</b>
                        @if($session->is_active)
                            <span class="badge bg-success">Aktif</span>
                        @else
                            <span class="badge bg-danger">Ditutup</span>
                        @endif
                    </p>
                </div>
                <div class="col-md-6 d-flex align-items-center gap-2 flex-wrap">
                    @if($session->is_active)
                        <form method="POST" action="{{ route('dosen.sessions.close', $session) }}">
                            @csrf
                            <button class="btn btn-danger btn-sm"
                                onclick="return confirm('Tutup sesi ini? Mahasiswa tidak bisa lagi absen.')">
                                ✕ Tutup Sesi
                            </button>
                        </form>
                    @endif
                    @if($session->method === 'faceid' && $session->is_active)
                        <a href="{{ route('dosen.sessions.kiosk', $session) }}"
                            class="btn btn-primary btn-sm">
                            📷 Buka Kiosk Face ID
                        </a>
                    @endif
                </div>
            </div>
        </div>
    </div>

    {{-- ─── BARCODE / QR CODE ─────────────────────────────────────── --}}
    @if($session->method === 'barcode')
    <div class="card shadow-sm mb-3 border-success">
        <div class="card-header bg-success text-white fw-bold d-flex justify-content-between align-items-center">
            <span>📱 QR Code Absensi Barcode</span>
            <button class="btn btn-sm btn-light" onclick="refreshQR()" title="Refresh jika pindah jaringan/IP berubah">
                🔄 Refresh QR
            </button>
        </div>
        <div class="card-body">
            <div class="row g-3 align-items-start">

                {{-- QR Code Display --}}
                <div class="col-md-5 text-center">
                    <div id="qrcode" class="d-inline-block p-3 bg-white rounded border mb-2"
                        style="min-width:200px; min-height:200px; position:relative;">
                        <div id="qr_loading" class="text-muted small p-3">Memuat QR...</div>
                    </div>
                    <br>
                    <small class="text-muted d-block mb-1" id="qr_ip_info">Mendeteksi IP jaringan...</small>
                    <small class="text-success d-none mb-2" id="qr_ready_info">✅ QR siap — minta mahasiswa scan</small>
                    <div class="d-flex gap-2 justify-content-center flex-wrap mt-2">
                        <button class="btn btn-sm btn-outline-primary" onclick="printQR()">
                            🖨️ Print QR
                        </button>
                        <button class="btn btn-sm btn-outline-success" onclick="fullscreenQR()">
                            ⛶ Fullscreen
                        </button>
                    </div>
                </div>

                {{-- Info --}}
                <div class="col-md-7">
                    <div class="alert alert-info py-2 small mb-3">
                        <b>Cara pakai:</b> Dosen tampilkan QR di layar → Mahasiswa scan dengan HP →
                        Otomatis diarahkan ke halaman absensi.<br>
                        <b>Pindah jaringan?</b> Klik tombol <b>🔄 Refresh QR</b> untuk generate ulang dengan IP terbaru.
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold mb-1">Link Absensi</label>
                        <div class="input-group">
                            <input type="text" class="form-control form-control-sm bg-light"
                                id="barcode_url_display" readonly
                                value="{{ $barcodePublicUrl }}">
                            <button class="btn btn-sm btn-outline-secondary" onclick="copyLink()">
                                📋 Copy
                            </button>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold mb-1">Token Barcode</label>
                        <code class="d-block p-2 bg-light rounded border" style="letter-spacing:2px; font-size:1.1rem;">
                            {{ $session->barcode_token }}
                        </code>
                    </div>

                    <div class="row g-2 text-center mt-1">
                        <div class="col-4">
                            <div class="p-2 bg-light rounded border">
                                <div class="fw-bold fs-5">{{ $session->absensi->whereIn('status', ['hadir'])->count() }}</div>
                                <small class="text-muted">Hadir</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="p-2 bg-light rounded border">
                                <div class="fw-bold fs-5">{{ $session->absensi->where('status', 'telat')->count() }}</div>
                                <small class="text-muted">Telat</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="p-2 bg-light rounded border">
                                <div class="fw-bold fs-5">{{ $session->absensi->count() }}</div>
                                <small class="text-muted">Total</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    @endif

    {{-- ─── Absensi Manual ────────────────────────────────────────── --}}
    @if($session->method === 'manual' && $session->is_active)
        <div class="card shadow-sm mb-3">
            <div class="card-header fw-bold">✏️ Absensi Manual</div>
            <div class="card-body">
                <h6 class="mb-2">1. Centang mahasiswa yang hadir</h6>
                <p class="text-muted small mb-3">
                    Hanya yang dicentang yang disimpan sebagai <b>Hadir</b>.
                    Yang tidak dicentang bisa diatur statusnya di bagian bawah.
                </p>
                @if($mahasiswaKandidat->isEmpty())
                    <div class="alert alert-warning mb-0">
                        Belum ada mahasiswa yang bisa ditampilkan.
                        @if(\Illuminate\Support\Facades\Schema::hasTable('mahasiswa_mata_kuliah'))
                            Pastikan mahasiswa sudah menyimpan pilihan mata kuliah ini.
                        @else
                            Pastikan data mahasiswa & kelas sudah benar.
                        @endif
                    </div>
                @else
                    <form method="POST" action="{{ route('dosen.sessions.manual-hadir', $session) }}">
                        @csrf
                        <div class="table-responsive">
                            <table class="table table-sm align-middle">
                                <thead>
                                    <tr>
                                        <th style="width:48px;">Hadir</th>
                                        <th>Nama</th>
                                        <th>NIM</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($mahasiswaKandidat as $m)
                                        @php $isHadir = optional($absensiByMahasiswa->get($m->id))->status === 'hadir'; @endphp
                                        <tr>
                                            <td class="text-center">
                                                <input class="form-check-input" type="checkbox"
                                                    name="hadir[]" value="{{ $m->id }}"
                                                    {{ $isHadir ? 'checked' : '' }}>
                                            </td>
                                            <td>{{ $m->nama }}</td>
                                            <td>{{ $m->nim }}</td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <button type="submit" class="btn btn-primary mt-2">Simpan Kehadiran</button>
                    </form>
                @endif
            </div>
        </div>

        @if(!$mahasiswaKandidat->isEmpty())
        <div class="card shadow-sm mb-3">
            <div class="card-header fw-bold">📋 Atur Status Mahasiswa Lainnya</div>
            <div class="card-body">
                <h6 class="mb-2">2. Yang belum hadir — pilih status</h6>
                @if($mahasiswaBukanHadir->isEmpty())
                    <div class="alert alert-success mb-0 py-2">Semua mahasiswa sudah tercatat sebagai Hadir.</div>
                @else
                    <div class="table-responsive">
                        <table class="table table-sm align-middle">
                            <thead>
                                <tr>
                                    <th>Nama</th>
                                    <th>NIM</th>
                                    <th>Status</th>
                                    <th style="min-width:280px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($mahasiswaBukanHadir as $m)
                                    @php
                                        $st = optional($absensiByMahasiswa->get($m->id))->status;
                                        $stLabel = $st ? ucfirst(str_replace(['_', 'tidak hadir'], [' ', 'Alpha'], $st)) : '—';
                                    @endphp
                                    <tr>
                                        <td>{{ $m->nama }}</td>
                                        <td>{{ $m->nim }}</td>
                                        <td>{{ $stLabel }}</td>
                                        <td class="d-flex flex-wrap gap-1">
                                            @foreach(['izin' => 'secondary', 'sakit' => 'warning', 'tidak_hadir' => 'danger', 'telat' => 'primary'] as $val => $color)
                                            <form method="POST" action="{{ route('dosen.sessions.manual-status', $session) }}" class="d-inline">
                                                @csrf
                                                <input type="hidden" name="mahasiswa_id" value="{{ $m->id }}">
                                                <input type="hidden" name="status" value="{{ $val }}">
                                                <button class="btn btn-sm btn-outline-{{ $color }}">
                                                    {{ ucfirst($val === 'tidak_hadir' ? 'Alpha' : $val) }}
                                                </button>
                                            </form>
                                            @endforeach
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                @endif
            </div>
        </div>
        @endif
    @endif

    {{-- ─── Daftar Absensi ─────────────────────────────────────────── --}}
    <div class="card shadow-sm">
        <div class="card-header fw-bold">
            📊 Daftar Mahasiswa yang Sudah Absen
            <span class="badge bg-primary ms-1">{{ $session->absensi->count() }}</span>
        </div>
        <div class="card-body table-responsive p-0">
            <table class="table table-sm mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3">#</th>
                        <th>Nama</th>
                        <th>NIM</th>
                        <th>Status</th>
                        <th>Jam Masuk</th>
                        <th>Metode</th>
                        <th>Confidence</th>
                    </tr>
                </thead>
                <tbody>
                @forelse($session->absensi as $i => $item)
                    <tr>
                        <td class="ps-3">{{ $i + 1 }}</td>
                        <td>{{ optional($item->mahasiswa)->nama }}</td>
                        <td>{{ optional($item->mahasiswa)->nim }}</td>
                        <td>
                            @php
                                $badge = match($item->status) {
                                    'hadir'       => 'success',
                                    'telat'       => 'warning',
                                    'alpha','tidak_hadir' => 'danger',
                                    'izin'        => 'info',
                                    'sakit'       => 'secondary',
                                    default       => 'light',
                                };
                            @endphp
                            <span class="badge bg-{{ $badge }}">{{ strtoupper($item->status) }}</span>
                        </td>
                        <td>{{ $item->jam_masuk ?? '-' }}</td>
                        <td>{{ strtoupper($item->metode ?? '-') }}</td>
                        <td>
                            @if($item->confidence)
                                {{ number_format($item->confidence, 1) }}%
                            @else
                                -
                            @endif
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="7" class="text-center text-muted py-3">Belum ada peserta absen.</td>
                    </tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>

{{-- ─── Modal Fullscreen QR ─────────────────────────────────────────── --}}
@if($session->method === 'barcode')
<div id="qrFullscreenModal" style="
    display:none; position:fixed; inset:0; z-index:9999;
    background:rgba(0,0,0,0.92); align-items:center; justify-content:center;
    flex-direction:column; text-align:center;">
    <div id="qrFullscreenBox" class="bg-white rounded p-4 d-inline-block mb-3"></div>
    <p class="text-white mb-1 fw-bold fs-5">{{ optional($session->mataKuliah)->nama_mk }}</p>
    <p class="text-white-50 mb-1 small">{{ optional($session->kelas)->nama_kelas }}</p>
    <p class="text-white mb-1 small" id="qrFullscreenUrl" style="font-size:11px; word-break:break-all; max-width:400px; opacity:.7;"></p>
    <p class="text-white mb-3 small">Token: <code class="text-warning" style="letter-spacing:2px;">{{ $session->barcode_token }}</code></p>
    <button class="btn btn-light" onclick="closeFullscreen()">✕ Tutup</button>
</div>
@endif

{{-- ─── Script QR ───────────────────────────────────────────────────── --}}
@if($session->method === 'barcode')
@php
    $jsScanPath   = route('mahasiswa.sessions.scan', ['session' => $session->id, 'token' => $session->barcode_token], false);
    $jsRefreshUrl = route('dosen.sessions.show', $session);
    $jsMk         = optional($session->mataKuliah)->nama_mk ?? '-';
    $jsKelas      = optional($session->kelas)->nama_kelas ?? '-';
    $jsToken      = $session->barcode_token;
    $jsTgl        = $session->session_date->format('d M Y');
    $jsJam        = $session->start_time . ' - ' . $session->end_time;
@endphp
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
<script>
const BARCODE_PATH     = @json($jsScanPath);
const SERVER_URL       = @json($barcodePublicUrl);
const REFRESH_ENDPOINT = @json($jsRefreshUrl);

const qrcodeEl    = document.getElementById('qrcode');
const urlDisplay  = document.getElementById('barcode_url_display');
const ipInfo      = document.getElementById('qr_ip_info');
const readyInfo   = document.getElementById('qr_ready_info');

let activeUrl             = SERVER_URL;
let currentQRInstance     = null;
let currentQRFullInstance = null;

// ── Render QR ─────────────────────────────────────────────────────
function renderQR(fullUrl) {
    activeUrl = fullUrl;
    urlDisplay.value = fullUrl;

    // Tampilkan IP yang aktif
    try {
        const u = new URL(fullUrl);
        ipInfo.textContent = '🌐 IP aktif: ' + u.hostname + (u.port ? ':' + u.port : '');
        ipInfo.className = 'text-primary d-block mb-1 small fw-semibold';
        readyInfo.classList.remove('d-none');
    } catch(e) {}

    // Hapus QR lama
    qrcodeEl.innerHTML = '';
    currentQRInstance = new QRCode(qrcodeEl, {
        text        : fullUrl,
        width       : 200,
        height      : 200,
        colorDark   : '#000000',
        colorLight  : '#ffffff',
        correctLevel: QRCode.CorrectLevel.H,
    });
}

// ── Init — pakai URL dari server langsung ─────────────────────────
renderQR(SERVER_URL);

// ── Refresh QR — fetch ulang dari server untuk IP terbaru ─────────
function refreshQR() {
    ipInfo.textContent = '🔄 Mendeteksi ulang IP...';
    ipInfo.className = 'text-warning d-block mb-1 small';
    readyInfo.classList.add('d-none');

    fetch(window.location.href, {
        headers: { 'X-Requested-With': 'XMLHttpRequest', 'Accept': 'application/json' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.barcode_url) {
            renderQR(data.barcode_url);
        } else {
            // Fallback: reload halaman
            window.location.reload();
        }
    })
    .catch(() => {
        // Fallback: reload halaman
        window.location.reload();
    });
}

// ── Copy link ─────────────────────────────────────────────────────
function copyLink() {
    navigator.clipboard.writeText(activeUrl)
        .then(() => alert('Link berhasil dicopy!\n\n' + activeUrl))
        .catch(() => {
            urlDisplay.select();
            document.execCommand('copy');
        });
}

// ── Print QR ──────────────────────────────────────────────────────
function printQR() {
    const mk    = @json($jsMk);
    const kelas = @json($jsKelas);
    const token = @json($jsToken);
    const tgl   = @json($jsTgl);
    const jam   = @json($jsJam);
    const url   = activeUrl;

    const win = window.open('', '_blank', 'width=500,height=650');
    win.document.write(`
        <!DOCTYPE html><html><head><title>QR Absensi</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"><\/script>
        <style>
            body { font-family: sans-serif; text-align: center; padding: 30px; }
            h2 { font-size: 20px; margin-bottom: 4px; }
            p { margin: 4px 0; font-size: 14px; color: #555; }
            #qr { display: inline-block; margin: 16px 0; border: 2px solid #000; padding: 10px; border-radius: 8px; }
            .token { font-size: 22px; font-weight: bold; letter-spacing: 4px; color: #1d4ed8; margin: 8px 0; }
            .footer { font-size: 11px; color: #aaa; margin-top: 12px; }
        </style></head><body>
        <h2>${mk}</h2>
        <p>Kelas: ${kelas} &nbsp;|&nbsp; ${tgl} &nbsp;|&nbsp; ${jam}</p>
        <div id="qr"></div>
        <p class="token">${token}</p>
        <p style="font-size:12px; color:#777;">Scan QR atau buka link berikut</p>
        <p class="footer">${url}</p>
        <script>
            new QRCode(document.getElementById('qr'), {
                text: "${url}", width: 220, height: 220,
                colorDark: '#000000', colorLight: '#ffffff',
                correctLevel: QRCode.CorrectLevel.H
            });
            setTimeout(() => { window.print(); }, 800);
        <\/script>
        </body></html>
    `);
    win.document.close();
}

// ── Fullscreen QR ─────────────────────────────────────────────────
function fullscreenQR() {
    const modal = document.getElementById('qrFullscreenModal');
    const box   = document.getElementById('qrFullscreenBox');
    const urlEl = document.getElementById('qrFullscreenUrl');

    box.innerHTML = '';
    if (urlEl) urlEl.textContent = activeUrl;

    currentQRFullInstance = new QRCode(box, {
        text        : activeUrl,
        width       : 300,
        height      : 300,
        colorDark   : '#000000',
        colorLight  : '#ffffff',
        correctLevel: QRCode.CorrectLevel.H,
    });

    modal.style.display = 'flex';
}

function closeFullscreen() {
    document.getElementById('qrFullscreenModal').style.display = 'none';
    if (currentQRFullInstance) {
        document.getElementById('qrFullscreenBox').innerHTML = '';
        currentQRFullInstance = null;
    }
}

document.addEventListener('keydown', e => { if (e.key === 'Escape') closeFullscreen(); });
</script>
@endif
@endsection