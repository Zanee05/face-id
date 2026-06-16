@extends('layouts.app')

@section('content')
<div class="container">
    <h4 class="mb-3">Edit Jadwal</h4>
    <div class="card shadow-sm"><div class="card-body">
        <form method="POST" action="{{ route('admin.jadwal.update', $jadwal) }}">
            @csrf @method('PUT')
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Kelas</label>
                    <select class="form-select @error('kelas_id') is-invalid @enderror" name="kelas_id" required>
                        @foreach($kelas as $k)<option value="{{ $k->id }}" {{ (int) old('kelas_id', $jadwal->kelas_id) === (int) $k->id ? 'selected' : '' }}>{{ $k->nama_kelas }}</option>@endforeach
                    </select>
                    @error('kelas_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="col-md-4">
                    <label class="form-label">Mata Kuliah</label>
                    <select class="form-select @error('mata_kuliah_id') is-invalid @enderror" name="mata_kuliah_id" required>
                        @foreach($mataKuliah as $mk)<option value="{{ $mk->id }}" {{ (int) old('mata_kuliah_id', $jadwal->mata_kuliah_id) === (int) $mk->id ? 'selected' : '' }}>{{ $mk->nama_mk }} - {{ optional($mk->dosen)->nama }}</option>@endforeach
                    </select>
                    @error('mata_kuliah_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="col-md-4">
                    <label class="form-label">Hari</label>
                    <select class="form-select @error('hari') is-invalid @enderror" name="hari" required>
                        @foreach(['senin','selasa','rabu','kamis','jumat','sabtu'] as $h)<option value="{{ $h }}" {{ old('hari', $jadwal->hari) === $h ? 'selected' : '' }}>{{ ucfirst($h) }}</option>@endforeach
                    </select>
                    @error('hari')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="col-md-3"><label class="form-label">Jam Mulai</label><input type="time" name="jam_mulai" value="{{ old('jam_mulai', \Illuminate\Support\Str::substr($jadwal->jam_mulai,0,5)) }}" class="form-control @error('jam_mulai') is-invalid @enderror" required>@error('jam_mulai')<div class="invalid-feedback">{{ $message }}</div>@enderror</div>
                <div class="col-md-3"><label class="form-label">Jam Selesai</label><input type="time" name="jam_selesai" value="{{ old('jam_selesai', \Illuminate\Support\Str::substr($jadwal->jam_selesai,0,5)) }}" class="form-control @error('jam_selesai') is-invalid @enderror" required>@error('jam_selesai')<div class="invalid-feedback">{{ $message }}</div>@enderror</div>
                <div class="col-md-6"><label class="form-label">Ruangan</label><input name="ruangan" value="{{ old('ruangan', $jadwal->ruangan) }}" class="form-control @error('ruangan') is-invalid @enderror">@error('ruangan')<div class="invalid-feedback">{{ $message }}</div>@enderror</div>
            </div>
            <button class="btn btn-primary mt-3">Update</button>
        </form>
    </div></div>
</div>
@endsection

