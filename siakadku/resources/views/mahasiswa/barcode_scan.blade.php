<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIAKAD – Absensi Barcode</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --siakad-blue: #2563eb;
            --siakad-bg: #f8fafc;
            --siakad-text-muted: #64748b;
            --siakad-text-dark: #1e293b;
            --siakad-border: #e2e8f0;
        }

        body { 
            background-color: var(--siakad-bg); 
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; 
            color: var(--siakad-text-dark);
        }

        /* Navbar Style */
        .navbar-custom {
            background: white;
            border-bottom: 1px solid var(--siakad-border);
            padding: 0.75rem 2rem;
        }
        .navbar-brand-text {
            font-weight: 800;
            font-size: 1.25rem;
            color: #000;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .brand-logo {
            background: var(--siakad-blue);
            color: white;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 1rem;
        }

        /* Container & Card */
        .main-container {
            max-width: 900px;
            margin-top: 2.5rem;
        }
        .card-siakad {
            background: white;
            border: 1px solid var(--siakad-border);
            border-radius: 0.75rem;
            padding: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .page-subtitle {
            color: var(--siakad-text-muted);
            font-size: 0.95rem;
            margin-bottom: 2rem;
        }

        /* Form Elements */
        .form-label {
            font-weight: 500;
            font-size: 0.9rem;
            color: var(--siakad-text-dark);
        }
        .form-control {
            background-color: #fcfcfc;
            border: 1px solid var(--siakad-border);
            border-radius: 0.5rem;
            padding: 0.6rem 1rem;
        }
        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            border-color: var(--siakad-blue);
        }

        /* Info Table (Session Details) */
        .info-box {
            background: #f8fafc;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 0.4rem 0;
            font-size: 0.9rem;
        }
        .info-label { color: var(--siakad-text-muted); }
        .info-value { font-weight: 600; }

        /* Button */
        .btn-siakad {
            background-color: var(--siakad-blue);
            color: white;
            border: none;
            border-radius: 0.5rem;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s;
        }
        .btn-siakad:hover {
            background-color: #1d4ed8;
            color: white;
            transform: translateY(-1px);
        }

        /* Success Alert (Like the image) */
        .alert-siakad-success {
            background-color: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-custom">
        <div class="container-fluid">
            <div class="navbar-brand-text">
                <div class="brand-logo">S</div> SIAKAD
            </div>
            <div class="d-flex align-items-center gap-3">
                <small class="text-muted d-none d-md-block">Dashboard</small>
                <small class="text-muted d-none d-md-block">Rekap Absensi</small>
                <div class="ms-3 d-flex align-items-center">
                    <div class="brand-logo" style="width: 28px; height: 28px; font-size: 0.8rem; background: #6366f1;">A</div>
                    <span class="ms-2 fw-semibold small">User Mahasiswa</span>
                </div>
            </div>
        </div>
    </nav>

    <div class="container main-container">
        
        @if(session('success'))
        <div class="alert-siakad-success">
            {{ session('success') }}
        </div>
        @endif

        <h2 class="page-title">Absensi Barcode</h2>
        <p class="page-subtitle">Silakan isi token dan verifikasi email Anda untuk mencatat kehadiran sesi ini.</p>

        <div class="card-siakad">
            @if($sessionData)
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="info-box h-100">
                        <div class="info-item">
                            <span class="info-label">Mata Kuliah</span>
                            <span class="info-value">{{ optional($sessionData->mataKuliah)->nama_mk }}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Dosen</span>
                            <span class="info-value">Nama Dosen, S.Kom., M.Kom</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-box h-100">
                        <div class="info-item">
                            <span class="info-label">Waktu</span>
                            <span class="info-value">{{ $sessionData->start_time }} - {{ $sessionData->end_time }}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Status</span>
                            <span class="badge bg-success">Aktif</span>
                        </div>
                    </div>
                </div>
            </div>

            <form method="POST" action="{{ route('mahasiswa.sessions.submit') }}">
                @csrf
                <input type="hidden" name="session" value="{{ $scanParams['session'] }}">
                
                <div class="mb-3">
                    <label class="form-label">Token Sesi</label>
                    <input type="text" name="token" class="form-control text-uppercase" 
                           placeholder="Masukan Token" 
                           value="{{ $scanParams['token'] ?? '' }}"
                           {{ !empty($scanParams['token']) ? 'readonly' : 'required' }}>
                </div>

                <div class="mb-4">
                    <label class="form-label">Email Mahasiswa</label>
                    <input type="email" name="email" class="form-control" 
                           placeholder="Email Terdaftar" required>
                </div>

                <button type="submit" class="btn-siakad">Simpan Absensi</button>
            </form>
            @else
            <div class="text-center py-4">
                <p class="text-danger">Sesi tidak ditemukan atau token tidak valid.</p>
            </div>
            @endif
        </div>
    </div>

</body>
</html>