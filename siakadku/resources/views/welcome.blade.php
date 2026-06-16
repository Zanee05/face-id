<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'SIAKAD') }}</title>

    <script src="{{ asset('js/app.js') }}" defer></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg app-navbar sticky-top">
        <div class="container">
            <a class="navbar-brand app-brand d-flex align-items-center gap-2" href="{{ url('/') }}">
                <span class="d-inline-flex align-items-center justify-content-center rounded-3 text-white" style="width: 34px; height: 34px; background: linear-gradient(135deg, #1d4ed8 0%, #0ea5e9 100%);">
                    <span style="font-weight: 800;">S</span>
                </span>
                <span>{{ config('app.name', 'SIAKAD') }}</span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#welcomeNav" aria-controls="welcomeNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="welcomeNav">
                <div class="ms-auto d-flex gap-2 align-items-lg-center py-3 py-lg-0">
                    @auth
                        <a class="btn btn-primary btn-sm px-3" href="{{ url('/home') }}">Masuk Dashboard</a>
                    @else
                        @if (Route::has('login'))
                            <a class="btn btn-outline-primary btn-sm px-3" href="{{ route('login') }}">Login</a>
                        @endif
                        @if (Route::has('register'))
                            <a class="btn btn-primary btn-sm px-3" href="{{ route('register') }}">Register</a>
                        @endif
                    @endauth
                </div>
            </div>
        </div>
    </nav>

    <main class="app-main">
        <div class="container">
            <div class="row align-items-center g-4 g-lg-5">
                <div class="col-lg-6">
                    <div class="d-inline-flex align-items-center gap-2 px-3 py-2 rounded-pill border bg-white" style="border-color: rgba(2, 6, 23, 0.10) !important;">
                        <span class="badge bg-primary">Face ID</span>
                        <span class="small text-muted">Absensi cepat & lebih aman</span>
                    </div>

                    <h1 class="mt-3 mb-3" style="font-weight: 800; letter-spacing: -0.03em;">
                        Sistem Informasi Akademik <span class="text-primary">modern</span> untuk kampus
                    </h1>
                    <p class="text-muted mb-4" style="font-size: 1.05rem;">
                        Kelola user, kelas, mata kuliah, jadwal, dan absensi Face ID dalam satu aplikasi yang rapi, ringan, dan mudah digunakan.
                    </p>

                    <div class="d-flex flex-wrap gap-2">
                        @auth
                            <a class="btn btn-primary px-4 py-2" href="{{ url('/home') }}">Buka Dashboard</a>
                        @else
                            @if (Route::has('login'))
                                <a class="btn btn-primary px-4 py-2" href="{{ route('login') }}">Login</a>
                            @endif
                            <a class="btn btn-outline-primary px-4 py-2" href="#fitur">Lihat Fitur</a>
                        @endauth
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4 p-lg-5">
                            <div class="row g-3" id="fitur">
                                <div class="col-12">
                                    <div class="p-3 rounded-4" style="background: rgba(37, 99, 235, 0.08); border: 1px solid rgba(37, 99, 235, 0.16);">
                                        <div class="fw-semibold">Absensi Face ID</div>
                                        <div class="text-muted small">Registrasi wajah dan pencatatan kehadiran dengan confidence.</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-3 rounded-4 border bg-white" style="border-color: rgba(2, 6, 23, 0.10) !important;">
                                        <div class="fw-semibold">Manajemen Jadwal</div>
                                        <div class="text-muted small">Atur jadwal per kelas dan mata kuliah.</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-3 rounded-4 border bg-white" style="border-color: rgba(2, 6, 23, 0.10) !important;">
                                        <div class="fw-semibold">Dashboard Ringkas</div>
                                        <div class="text-muted small">Statistik dan monitoring untuk admin/dosen/mahasiswa.</div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="p-3 rounded-4 border bg-white" style="border-color: rgba(2, 6, 23, 0.10) !important;">
                                        <div class="fw-semibold">UI Konsisten</div>
                                        <div class="text-muted small">Typography, spacing, dan komponen rapi untuk semua halaman.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-5 pt-3 text-center text-muted small">
                &copy; {{ date('Y') }} {{ config('app.name', 'SIAKAD') }}
            </div>
        </div>
    </main>
</body>
</html>
