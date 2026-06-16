@extends('layouts.app')

@section('content')
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">Monitoring Absensi Live</h4>
        <small class="text-muted">Auto-refresh setiap 30 detik</small>
    </div>

    <div class="card shadow-sm mb-3">
        <div class="card-body">
            <form method="GET" action="{{ route('admin.monitoring.absensi') }}" class="row g-2 align-items-end">
                <div class="col-md-4">
                    <label class="form-label mb-1">Filter Kelas</label>
                    <select class="form-select" name="kelas_id">
                        <option value="">Semua Kelas</option>
                        @foreach($kelasList as $kelas)
                            <option value="{{ $kelas->id }}" {{ (string) $kelasId === (string) $kelas->id ? 'selected' : '' }}>
                                {{ $kelas->nama_kelas }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label mb-1">Filter Mata Kuliah</label>
                    <select class="form-select" name="mata_kuliah_id">
                        <option value="">Semua Mata Kuliah</option>
                        @foreach($mataKuliahList as $mk)
                            <option value="{{ $mk->id }}" {{ (string) $mataKuliahId === (string) $mk->id ? 'selected' : '' }}>
                                {{ $mk->nama_mk }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-4 d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Terapkan Filter</button>
                    <a href="{{ route('admin.monitoring.absensi') }}" class="btn btn-outline-secondary">Reset</a>
                </div>
            </form>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body table-responsive">
            <table class="table table-striped align-middle">
                <thead>
                    <tr>
                        <th>Kelas</th>
                        <th>Mata Kuliah</th>
                        <th>Jam Sesi</th>
                        <th>Target</th>
                        <th>Sudah Absen</th>
                        <th>Belum Absen</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($sessions as $session)
                        <tr>
                            <td>{{ $session['kelas'] ?? '-' }}</td>
                            <td>{{ $session['mata_kuliah'] ?? '-' }}</td>
                            <td>{{ $session['jam'] ?? '-' }}</td>
                            <td>{{ $session['target_mahasiswa'] }}</td>
                            <td><span class="badge bg-success">{{ $session['sudah_absen'] }}</span></td>
                            <td><span class="badge bg-danger">{{ $session['belum_absen'] }}</span></td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="6" class="text-center">Tidak ada sesi aktif hari ini.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
setInterval(() => {
    const url = new URL(window.location.href);
    window.location.href = url.toString();
}, 30000);
</script>
@endsection

