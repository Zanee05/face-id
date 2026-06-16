@extends('layouts.app')

@section('content')
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">Rekap Absensi Mahasiswa</h4>
        <a href="{{ route('dosen.absensi.rekap') }}" class="btn btn-outline-primary btn-sm">Buka Rekap Harian + Export</a>
    </div>
    <div class="card shadow-sm">
        <div class="card-body table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Tanggal</th>
                        <th>Mahasiswa</th>
                        <th>Mata Kuliah</th>
                        <th>Status</th>
                        <th>Jam Masuk</th>
                        <th>Snapshot</th>
                        <th>Verifikasi Dosen</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($absensi as $item)
                        <tr>
                            <td>{{ $item->tanggal }}</td>
                            <td>{{ optional($item->mahasiswa)->nama }}</td>
                            <td>{{ optional($item->mataKuliah)->nama_mk }}</td>
                            <td><span class="badge bg-success">{{ $item->status }}</span></td>
                            <td>{{ $item->jam_masuk }}</td>
                            <td>
                                @if($item->snapshot_path)
                                    <a href="{{ asset($item->snapshot_path) }}" target="_blank" rel="noopener">
                                        <img src="{{ asset($item->snapshot_path) }}" alt="Snapshot" style="width: 72px; height: 54px; object-fit: cover; border-radius: 6px; border: 1px solid #ddd;">
                                    </a>
                                @else
                                    <span class="text-muted">-</span>
                                @endif
                            </td>
                            <td>
                                <span class="badge bg-secondary">{{ $item->verification_status }}</span>
                                <form action="{{ route('dosen.absensi.verify', $item) }}" method="POST" class="mt-2 d-flex gap-2">
                                    @csrf
                                    <button class="btn btn-sm btn-outline-success" name="decision" value="approved" type="submit">Approve</button>
                                    <button class="btn btn-sm btn-outline-danger" name="decision" value="rejected" type="submit">Reject</button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="7" class="text-center">Belum ada data absensi.</td></tr>
                    @endforelse
                </tbody>
            </table>
            {{ $absensi->links() }}
        </div>
    </div>
</div>
@endsection
