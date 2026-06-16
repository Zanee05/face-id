@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Tambah Kelas</h4>
    <div class="card shadow-sm"><div class="card-body">
        <form method="POST" action="{{ route('admin.kelas.store') }}">
            @csrf
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Nama Kelas</label>
                    <input class="form-control @error('nama_kelas') is-invalid @enderror" name="nama_kelas" value="{{ old('nama_kelas') }}" required>
                    @error('nama_kelas')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="col-md-6">
                    <label class="form-label">Ruang Kelas</label>
                    <input class="form-control @error('ruang_kelas') is-invalid @enderror" name="ruang_kelas" value="{{ old('ruang_kelas') }}" placeholder="Contoh: Gd A - 203">
                    @error('ruang_kelas')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
            </div>
            <button class="btn btn-primary mt-3">Simpan</button>
        </form>
    </div></div>
</div>
@endsection

