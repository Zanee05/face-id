@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Dashboard Dosen</h4>

    <div class="row g-3 mb-4">
        <div class="col-md-4"><div class="card shadow-sm"><div class="card-body"><small>Mahasiswa Diampu</small><h4>{{ $totalMahasiswaKelas }}</h4></div></div></div>
        <div class="col-md-4"><div class="card shadow-sm"><div class="card-body"><small>Hadir Hari Ini</small><h4>{{ $hadirHariIni }}</h4></div></div></div>
        <div class="col-md-4"><div class="card shadow-sm"><div class="card-body"><small>Persentase Kehadiran</small><h4>{{ $persentase }}%</h4></div></div></div>
    </div>

    <div class="card shadow-sm mb-3">
        <div class="card-body">
            <h6>Monitoring Absensi Kelas</h6>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead><tr><th>Tanggal</th><th>Mahasiswa</th><th>Mata Kuliah</th><th>Status</th><th>Confidence</th></tr></thead>
                    <tbody>
                    @forelse($absensiKelas as $item)
                        <tr>
                            <td>{{ $item->tanggal }}</td>
                            <td>{{ optional($item->mahasiswa)->nama }}</td>
                            <td>{{ optional($item->mataKuliah)->nama_mk }}</td>
                            <td>{{ strtoupper($item->status) }}</td>
                            <td>{{ $item->confidence ? $item->confidence . '%' : '-' }}</td>
                        </tr>
                    @empty
                        <tr><td colspan="5" class="text-center">Belum ada data.</td></tr>
                    @endforelse
                    </tbody>
                </table>
                {{ $absensiKelas->links() }}
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <h6>Log Face ID Mahasiswa</h6>
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead><tr><th>Nama</th><th>Status</th><th>Distance</th><th>Confidence</th><th>Waktu</th></tr></thead>
                    <tbody>
                    @foreach($faceLogs as $log)
                        <tr>
                            <td>{{ optional($log->user)->name }}</td>
                            <td>{{ $log->status }}</td>
                            <td>{{ $log->distance ?? '-' }}</td>
                            <td>{{ $log->confidence ? $log->confidence . '%' : '-' }}</td>
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
            <h6>Jadwal Mengajar</h6>
            @if(empty($dosen))
                <div class="alert alert-warning mb-3">Profil dosen untuk akun ini belum terhubung. Hubungi admin agar user dosen memiliki data dosen.</div>
            @elseif(isset($punyaMataKuliah) && !$punyaMataKuliah)
                <div class="alert alert-warning mb-3">Belum ada mata kuliah yang diampu oleh Anda. Minta admin mengatur <b>dosen pengampu</b> di <b>Kelola Mata Kuliah</b> untuk MK yang Anda ajarkan.</div>
            @else
                <p class="text-muted small mb-2">Daftar di bawah diambil dari <b>Kelola Jadwal</b> untuk mata kuliah yang pengampunya adalah Anda.</p>
            @endif
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead><tr><th>Hari</th><th>Jam</th><th>Kelas</th><th>Mata Kuliah</th><th>Ruangan</th></tr></thead>
                    <tbody>
                    @forelse($jadwalMengajar as $j)
                        <tr>
                            <td>{{ ucfirst($j->hari) }}</td>
                            <td>{{ $j->jam_mulai }} - {{ $j->jam_selesai }}</td>
                            <td>{{ optional($j->kelas)->nama_kelas }}</td>
                            <td>{{ optional($j->mataKuliah)->nama_mk }}</td>
                            <td>{{ $j->ruangan ?? '-' }}</td>
                        </tr>
                    @empty
                        <tr><td colspan="5" class="text-center text-muted">
                            @if(!empty($dosen) && !empty($punyaMataKuliah))
                                Belum ada baris jadwal. Minta admin menambahkan jadwal di <b>Kelola Jadwal</b> untuk kelas dan mata kuliah yang Anda ampu.
                            @else
                                Belum ada jadwal mengajar.
                            @endif
                        </td></tr>
                    @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection

