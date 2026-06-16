@extends('layouts.app')

@section('content')
<div class="container">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
        <h4 class="mb-0">Rekap Harian Absensi</h4>
        <a
            href="{{ route('dosen.absensi.rekap.export', ['tanggal' => $tanggal]) }}"
            class="btn btn-success"
        >
            Export Excel
        </a>
    </div>

    <div class="card shadow-sm mb-3">
        <div class="card-body">
            <form method="GET" action="{{ route('dosen.absensi.rekap') }}" class="row g-2 align-items-end">
                <div class="col-sm-4 col-md-3">
                    <label class="form-label mb-1">Tanggal</label>
                    <input type="date" class="form-control" name="tanggal" value="{{ $tanggal }}">
                </div>
                <div class="col-sm-4 col-md-3">
                    <button class="btn btn-primary" type="submit">Tampilkan</button>
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
                        <th>Jam</th>
                        <th>Hadir</th>
                        <th>Telat</th>
                        <th>Izin</th>
                        <th>Sakit</th>
                        <th>Alpha</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($sessions as $session)
                        @php $rekap = $session->rekap ?? collect(); @endphp
                        <tr>
                            <td>{{ optional($session->kelas)->nama_kelas }}</td>
                            <td>{{ optional($session->mataKuliah)->nama_mk }}</td>
                            <td>{{ $session->start_time }} - {{ $session->end_time }}</td>
                            <td>{{ (int) ($rekap['hadir'] ?? 0) }}</td>
                            <td>{{ (int) ($rekap['telat'] ?? 0) }}</td>
                            <td>{{ (int) ($rekap['izin'] ?? 0) }}</td>
                            <td>{{ (int) ($rekap['sakit'] ?? 0) }}</td>
                            <td>{{ (int) ($rekap['tidak_hadir'] ?? 0) }}</td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="8" class="text-center">Belum ada sesi pada tanggal ini.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection

