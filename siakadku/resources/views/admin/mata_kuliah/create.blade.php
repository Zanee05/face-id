@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Tambah Mata Kuliah</h4>
    <div class="card shadow-sm"><div class="card-body">
        <form method="POST" action="{{ route('admin.mata-kuliah.store') }}">
            @csrf
            <div class="row g-3">
                <div class="col-md-4"><label class="form-label">Kode MK</label><input class="form-control @error('kode_mk') is-invalid @enderror" name="kode_mk" value="{{ old('kode_mk') }}" required>@error('kode_mk')<div class="invalid-feedback">{{ $message }}</div>@enderror</div>
                <div class="col-md-4"><label class="form-label">Nama MK</label><input class="form-control @error('nama_mk') is-invalid @enderror" name="nama_mk" value="{{ old('nama_mk') }}" required>@error('nama_mk')<div class="invalid-feedback">{{ $message }}</div>@enderror</div>
                <div class="col-md-2"><label class="form-label">SKS</label><input type="number" min="1" max="6" class="form-control @error('sks') is-invalid @enderror" name="sks" value="{{ old('sks', 2) }}" required>@error('sks')<div class="invalid-feedback">{{ $message }}</div>@enderror</div>
                <div class="col-md-6">
                    <label class="form-label">Dosen Pengampu</label>
                    <select class="form-select @error('dosen_id') is-invalid @enderror" name="dosen_id" required>
                        <option value="">-- Pilih dosen --</option>
                        @foreach($dosen as $d)<option value="{{ $d->id }}">{{ $d->nama }} ({{ $d->nidn }})</option>@endforeach
                    </select>
                    @error('dosen_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
            </div>
            <button class="btn btn-primary mt-3">Simpan</button>
        </form>
    </div></div>
</div>
@endsection

