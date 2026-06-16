@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Dashboard Admin</h4>

    <div class="row g-3 mb-4">
        <div class="col-md-3"><div class="card shadow-sm"><div class="card-body"><small>Total Mahasiswa</small><h3>{{ $totalMahasiswa }}</h3></div></div></div>
        <div class="col-md-3"><div class="card shadow-sm"><div class="card-body"><small>Total Dosen</small><h3>{{ $totalDosen }}</h3></div></div></div>
        <div class="col-md-3"><div class="card shadow-sm"><div class="card-body"><small>Total Kelas</small><h3>{{ $totalKelas }}</h3></div></div></div>
        <div class="col-md-3"><div class="card shadow-sm"><div class="card-body"><small>Absensi Hari Ini</small><h3>{{ $totalAbsensiHariIni }}</h3></div></div></div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-12">
            <div class="card border-0 bg-light">
                <!-- <div class="card-body d-flex flex-wrap gap-2">
                    <a href="{{ route('admin.kelas.index') }}" class="btn btn-outline-primary btn-sm">Kelola Ruang/Kelas</a>
                    <a href="{{ route('admin.mata-kuliah.index') }}" class="btn btn-outline-primary btn-sm">Kelola Mata Kuliah</a>
                    <a href="{{ route('admin.jadwal.index') }}" class="btn btn-outline-primary btn-sm">Kelola Jadwal</a>
                </div> -->
            </div>
        </div>
        <div class="col-lg-7">
            <div class="card shadow-sm h-100">
                <div class="card-body">
                    <h6>Grafik Absensi Bulanan</h6>
                    <canvas id="adminAbsensiChart" height="120"></canvas>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="card shadow-sm h-100">
                <div class="card-body">
                    <h6>Status Face ID Mahasiswa</h6>
                    <p class="mb-1">Sudah Daftar: <b>{{ (int)($faceStatus->sudah_daftar ?? 0) }}</b></p>
                    <p class="mb-3">Belum Daftar: <b>{{ (int)($faceStatus->belum_daftar ?? 0) }}</b></p>

                    {{-- Tombol Normalisasi Embedding --}}
                    <form action="{{ route('admin.face-data.normalize') }}" method="POST" class="mb-2"
                          onsubmit="return confirm('Normalisasi semua data wajah? Proses ini aman dan meningkatkan akurasi Face ID.')">
                        @csrf
                        <button class="btn btn-primary btn-sm w-100" type="submit">
                            🔧 Normalisasi Semua Data Wajah
                        </button>
                    </form>
                    <p class="text-muted small mb-3">Jalankan ini sekali jika confidence Face ID rendah.</p>

                    <form action="{{ route('admin.face-data.reset', auth()->user()) }}" method="POST">
                        @csrf
                        <button class="btn btn-outline-danger btn-sm" type="submit">Reset Face ID Saya</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h6>Monitoring Absensi Real-time (Polling 8 detik)</h6>
                    <div class="table-responsive">
                        <table class="table table-sm" id="live-absensi-table">
                            <thead><tr><th>Mahasiswa</th><th>Mata Kuliah</th><th>Status</th><th>Jam</th></tr></thead>
                            <tbody>
                            @foreach($latestAbsensi as $item)
                                <tr>
                                    <td>{{ optional($item->mahasiswa)->nama }}</td>
                                    <td>{{ optional($item->mataKuliah)->nama_mk }}</td>
                                    <td>{{ strtoupper($item->status) }}</td>
                                    <td>{{ $item->jam_masuk }}</td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h6>Log Face ID Terbaru</h6>
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead><tr><th>User</th><th>Status</th><th>Confidence</th><th>Waktu</th></tr></thead>
                            <tbody>
                            @foreach($latestFaceLogs as $log)
                                <tr>
                                    <td>{{ optional($log->user)->name }}</td>
                                    <td>{!! $log->status === 'success' ? '<span class="badge bg-success">Berhasil</span>' : '<span class="badge bg-danger">Gagal</span>' !!}</td>
                                    <td>{{ $log->confidence !== null ? $log->confidence . '%' : '-' }}</td>
                                    <td>{{ $log->created_at }}</td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm mt-3">
        <div class="card-body">
            <h6>Log Aktivitas Sistem</h6>
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead><tr><th>User</th><th>Tipe</th><th>Deskripsi</th><th>Waktu</th></tr></thead>
                    <tbody>
                    @foreach($activityLogs as $log)
                        <tr>
                            <td>{{ optional($log->user)->name ?? '-' }}</td>
                            <td>{{ $log->activity_type }}</td>
                            <td>{{ $log->description }}</td>
                            <td>{{ $log->created_at }}</td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="card shadow-sm mt-3">
        <div class="card-body">
            <h6>Manajemen Face ID Mahasiswa</h6>
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead><tr><th>Nama</th><th>Email</th><th>Status Face ID</th><th>Aksi</th></tr></thead>
                    <tbody>
                    @foreach($faceUsers as $u)
                        <tr>
                            <td>{{ $u->name }}</td>
                            <td>{{ $u->email }}</td>
                            <td>
                                @if($u->faceData)
                                    <span class="badge bg-success">Sudah Daftar</span>
                                @else
                                    <span class="badge bg-secondary">Belum Daftar</span>
                                @endif
                            </td>
                            <td>
                                <form action="{{ route('admin.face-data.reset', $u) }}" method="POST">
                                    @csrf
                                    <button class="btn btn-sm btn-outline-danger" type="submit">Reset Face ID</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
new Chart(document.getElementById('adminAbsensiChart'), {
    type: 'line',
    data: {
        labels: @json($rekapBulanan->pluck('bulan')),
        datasets: [{ label: 'Jumlah Absensi', data: @json($rekapBulanan->pluck('total')), borderColor: '#0d6efd', fill: false }]
    }
});

async function refreshLiveAbsensi() {
    const res = await fetch('{{ route('admin.monitoring.absensi') }}?json=1');
    const data = await res.json();
    const tbody = document.querySelector('#live-absensi-table tbody');
    tbody.innerHTML = data.map(item => `
        <tr>
            <td>${item.mahasiswa ?? '-'}</td>
            <td>${item.mata_kuliah ?? '-'}</td>
            <td>${(item.status ?? '').toUpperCase()}</td>
            <td>${item.jam_masuk ?? '-'}</td>
        </tr>
    `).join('');
}
setInterval(refreshLiveAbsensi, 8000);
</script>
@endsection

