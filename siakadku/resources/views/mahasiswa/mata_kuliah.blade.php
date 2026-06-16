@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Susun Mata Kuliah</h4>

    @if(!empty($profileMissing) && $profileMissing)
        <div class="alert alert-warning">
            Profil mahasiswa akun ini belum terhubung. Anda belum bisa menyimpan susunan mata kuliah.
            Silakan hubungi admin untuk melengkapi data mahasiswa.
        </div>
    @endif
    @if(isset($pivotReady) && !$pivotReady)
        <div class="alert alert-warning">
            Tabel relasi mahasiswa-mata kuliah belum tersedia di database.
            Minta admin menjalankan migration agar fitur ini aktif.
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body">
            <p class="text-muted mb-3">Pilih mata kuliah yang Anda ambil. Daftar nama di absensi akan mengikuti pilihan ini.</p>
            <form method="POST" action="{{ route('mahasiswa.mata-kuliah.update') }}">
                @csrf
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th style="width: 90px;">Ambil</th>
                                <th>Kode</th>
                                <th>Mata Kuliah</th>
                                <th>Dosen</th>
                                <th>SKS</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($mataKuliah as $mk)
                                <tr>
                                    <td>
                                        <input
                                            class="form-check-input"
                                            type="checkbox"
                                            name="mata_kuliah_ids[]"
                                            value="{{ $mk->id }}"
                                            {{ (!empty($profileMissing) && $profileMissing) || (isset($pivotReady) && !$pivotReady) ? 'disabled' : '' }}
                                            {{ in_array($mk->id, $selected, true) ? 'checked' : '' }}
                                        >
                                    </td>
                                    <td>{{ $mk->kode_mk }}</td>
                                    <td>{{ $mk->nama_mk }}</td>
                                    <td>{{ optional($mk->dosen)->nama ?? '-' }}</td>
                                    <td>{{ $mk->sks }}</td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="5" class="text-center">Belum ada mata kuliah tersedia.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                <button class="btn btn-primary" {{ (!empty($profileMissing) && $profileMissing) || (isset($pivotReady) && !$pivotReady) ? 'disabled' : '' }}>Simpan Susunan</button>
            </form>
        </div>
    </div>
</div>
@endsection
