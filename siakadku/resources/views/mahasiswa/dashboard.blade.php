@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Dashboard Mahasiswa</h4>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <small>Status Absensi Hari Ini</small>
                    <h5 class="mt-2">
                        {{ $absensiHariIni ? 'Sudah Absen (' . strtoupper($absensiHariIni->status) . ')' : 'Belum Absen' }}
                    </h5>
                    <p class="mb-0 text-muted">{{ $absensiHariIni ? 'Jam: ' . $absensiHariIni->jam_masuk : 'Silakan lakukan absensi Face ID.' }}</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <small>Status Face ID</small>
                    <h5 class="mt-2">{{ $sudahDaftarWajah ? 'Sudah Terdaftar' : 'Belum Terdaftar' }}</h5>
                    <a href="{{ route('mahasiswa.absensi.index') }}" class="btn btn-sm btn-primary">Buka Kamera Face ID</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <small>Notifikasi</small>
                    <p class="mb-1">{{ !$sudahDaftarWajah ? 'Wajah belum terdaftar.' : 'Sistem siap digunakan.' }}</p>
                    <p class="mb-0">{{ $absensiHariIni ? 'Absensi hari ini sudah tercatat.' : 'Belum ada absensi hari ini.' }}</p>
                    <a href="{{ route('mahasiswa.absensi.rekap') }}" class="btn btn-sm btn-outline-primary mt-2">Lihat Rekap Absensi</a>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <h6>Riwayat Absensi</h6>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead><tr><th>Tanggal</th><th>Mata Kuliah</th><th>Status</th><th>Metode</th><th>Confidence</th></tr></thead>
                    <tbody>
                    @forelse($riwayat as $row)
                        <tr>
                            <td>{{ $row->tanggal }}</td>
                            <td>{{ optional($row->mataKuliah)->nama_mk }}</td>
                            <td>{{ strtoupper($row->status) }}</td>
                            <td>{{ strtoupper($row->metode) }}</td>
                            <td>{{ $row->confidence ? $row->confidence . '%' : '-' }}</td>
                        </tr>
                    @empty
                        <tr><td colspan="5" class="text-center">Belum ada riwayat absensi.</td></tr>
                    @endforelse
                    </tbody>
                </table>
                {{ $riwayat->links() }}
            </div>
        </div>
    </div>

    <div class="card shadow-sm mt-3">
        <div class="card-body">
            <h6 class="mb-3">Jadwal &amp; mata kuliah</h6>

            @if(isset($punyaPilihanMk) && !$punyaPilihanMk)
                <div class="alert alert-light border mb-0">
                    Belum ada mata kuliah yang dipilih. Buka menu <b>Susun Mata Kuliah</b> untuk memilih MK terlebih dahulu.
                </div>
            @else
                <h6 class="text-primary small text-uppercase mb-2">Mata kuliah yang Anda pilih</h6>
                <p class="text-muted small mb-2">Daftar ini mengikuti penyimpanan di menu <b>Susun Mata Kuliah</b>.</p>
                <div class="table-responsive mb-4">
                    <table class="table table-sm table-striped mb-0">
                        <thead>
                            <tr>
                                <th>Kode</th>
                                <th>Mata kuliah</th>
                                <th>Dosen</th>
                                <th>SKS</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($mataKuliahDipilih as $mk)
                                <tr>
                                    <td>{{ $mk->kode_mk }}</td>
                                    <td>{{ $mk->nama_mk }}</td>
                                    <td>{{ optional($mk->dosen)->nama ?? '-' }}</td>
                                    <td>{{ $mk->sks }}</td>
                                </tr>
                            @empty
                                <tr><td colspan="4" class="text-center text-muted">Belum ada data.</td></tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>

                <h6 class="text-primary small text-uppercase mb-2">Jadwal mingguan (hari &amp; jam)</h6>
                <p class="text-muted small mb-2">
                    Informasi hari, jam, dan ruangan diisi oleh <b>admin</b> di <b>Kelola Jadwal</b> untuk kelas Anda dan mata kuliah yang sama dengan pilihan Anda.
                </p>
                @if(isset($jadwalKosongPadahalPilihMk) && $jadwalKosongPadahalPilihMk)
                    <div class="alert alert-info py-2 small mb-3">
                        Belum ada jadwal detail (hari/jam) di sistem untuk kombinasi kelas + mata kuliah Anda. Minta admin melengkapi di <b>Admin → Kelola Jadwal</b>.
                    </div>
                @endif
                <div class="table-responsive">
                    <table class="table table-sm mb-0">
                        <thead><tr><th>Hari</th><th>Jam</th><th>Mata Kuliah</th><th>Dosen</th><th>Ruangan</th></tr></thead>
                        <tbody>
                        @forelse($jadwalKelas as $j)
                            <tr>
                                <td>{{ ucfirst($j->hari) }}</td>
                                <td>{{ $j->jam_mulai }} - {{ $j->jam_selesai }}</td>
                                <td>{{ optional($j->mataKuliah)->nama_mk }}</td>
                                <td>{{ optional(optional($j->mataKuliah)->dosen)->nama ?? '-' }}</td>
                                <td>{{ $j->ruangan ?? '-' }}</td>
                            </tr>
                        @empty
                            <tr><td colspan="5" class="text-center text-muted">Belum ada jadwal mingguan dari admin.</td></tr>
                        @endforelse
                        </tbody>
                    </table>
                </div>
            @endif
        </div>
    </div>
</div>
@endsection

