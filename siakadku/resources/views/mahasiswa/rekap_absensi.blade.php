@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Rekap Absensi Mahasiswa</h4>

    <div class="card shadow-sm">
        <div class="card-body table-responsive">
            <table class="table table-striped align-middle">
                <thead>
                    <tr>
                        <th>Mata Kuliah</th>
                        <th>Total Pertemuan</th>
                        <th>Hadir</th>
                        <th>Telat</th>
                        <th>Alpha</th>
                        <th>Persentase</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($rekap as $item)
                        @php $isLow = $item->persentase_kehadiran < 75; @endphp
                        <tr>
                            <td>{{ optional($item->mataKuliah)->nama_mk ?? '-' }}</td>
                            <td>{{ (int) $item->total_pertemuan }}</td>
                            <td>{{ (int) $item->total_hadir }}</td>
                            <td>{{ (int) $item->total_telat }}</td>
                            <td>{{ (int) $item->total_alpha }}</td>
                            <td class="{{ $isLow ? 'text-danger fw-bold' : 'text-success fw-semibold' }}">
                                {{ number_format($item->persentase_kehadiran, 2) }}%
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="6" class="text-center">Belum ada data absensi.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection

