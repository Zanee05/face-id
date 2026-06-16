@extends('layouts.app')

@section('content')
<div class="container py-2">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
        <div>
            <h4 class="mb-1">Sesi Absensi (Dosen)</h4>
            <p class="text-muted mb-0 small">Kelola sesi absensi per mata kuliah dan pantau status sesi aktif.</p>
        </div>
        <a href="{{ route('dosen.sessions.create') }}" class="btn btn-primary">+ Buat Sesi</a>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th>Tanggal & Jam</th>
                    <th>Kelas</th>
                    <th>Mata Kuliah</th>
                    <th>Metode</th>
                    <th>Status</th>
                    <th class="text-end">Aksi</th>
                </tr>
                </thead>
                <tbody>
                @forelse($sessions as $s)
                    <tr>
                        <td>
                            <div class="fw-semibold">{{ $s->session_date->format('d M Y') }}</div>
                            <div class="text-muted small">{{ $s->start_time }} - {{ $s->end_time }}</div>
                        </td>
                        <td>{{ optional($s->kelas)->nama_kelas }}</td>
                        <td>{{ optional($s->mataKuliah)->nama_mk }}</td>
                        <td>
                            @php
                                $methodBadgeClass = match($s->method) {
                                    'faceid' => 'bg-info text-dark',
                                    'barcode' => 'bg-primary',
                                    'manual' => 'bg-warning text-dark',
                                    default => 'bg-secondary',
                                };
                            @endphp
                            <span class="badge {{ $methodBadgeClass }}">{{ strtoupper($s->method) }}</span>
                        </td>
                        <td>
                            @if($s->is_active)
                                <span class="badge bg-success">Aktif</span>
                            @else
                                <span class="badge bg-secondary">Ditutup</span>
                            @endif
                        </td>
                        <td class="text-end">
                            <a class="btn btn-sm btn-outline-primary" href="{{ route('dosen.sessions.show', $s) }}">Detail</a>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="6" class="text-center">Belum ada sesi absensi.</td></tr>
                @endforelse
                </tbody>
            </table>
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mt-3">
                <small class="text-muted">
                    Menampilkan {{ $sessions->firstItem() ?? 0 }} - {{ $sessions->lastItem() ?? 0 }}
                    dari {{ $sessions->total() }} sesi
                </small>
                {{ $sessions->links('pagination::bootstrap-4') }}
            </div>
        </div>
    </div>
</div>
@endsection

