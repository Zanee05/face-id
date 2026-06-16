@extends('layouts.app')

@section('content')
<h4 class="fw-bold mb-3">Kelola Jadwal</h4>

<div class="d-flex gap-3 align-items-start">

    {{-- Form Tambah (kiri, lebar tetap) --}}
    <div style="width:280px;flex-shrink:0;">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white py-2">
                <h6 class="mb-0 fw-bold"><i class="bi bi-calendar3-week-fill me-1"></i> Tambah Jadwal</h6>
            </div>
            <div class="card-body p-3">
                <div id="formAlert" style="display:none;" class="alert py-2 small mb-3"></div>
                <form id="quickAddForm" novalidate>
                    @csrf
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Kelas <span class="text-danger">*</span></label>
                        <select name="kelas_id" class="form-select form-select-sm" required>
                            <option value="">-- Pilih Kelas --</option>
                            @foreach(\App\Models\Kelas::orderBy('nama_kelas')->get() as $k)
                                <option value="{{ $k->id }}">{{ $k->nama_kelas }}</option>
                            @endforeach
                        </select>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Mata Kuliah <span class="text-danger">*</span></label>
                        <select name="mata_kuliah_id" class="form-select form-select-sm" required>
                            <option value="">-- Pilih Mata Kuliah --</option>
                            @foreach(\App\Models\MataKuliah::orderBy('nama_mk')->get() as $mk)
                                <option value="{{ $mk->id }}">{{ $mk->nama_mk }}</option>
                            @endforeach
                        </select>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Hari <span class="text-danger">*</span></label>
                        <select name="hari" class="form-select form-select-sm" required>
                            <option value="">-- Pilih Hari --</option>
                            @foreach(['senin','selasa','rabu','kamis','jumat','sabtu'] as $h)
                                <option value="{{ $h }}">{{ ucfirst($h) }}</option>
                            @endforeach
                        </select>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Jam Mulai <span class="text-danger">*</span></label>
                        <input type="time" name="jam_mulai" class="form-control form-control-sm" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Jam Selesai <span class="text-danger">*</span></label>
                        <input type="time" name="jam_selesai" class="form-control form-control-sm" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold mb-1">Ruangan</label>
                        <input type="text" name="ruangan" class="form-control form-control-sm" placeholder="Opsional">
                        <div class="invalid-feedback small"></div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-sm w-100" id="btnSubmit">
                        <i class="bi bi-plus-circle me-1"></i> Simpan
                    </button>
                </form>
                <div class="text-center mt-2">
                    <a href="{{ route('admin.jadwal.create') }}" class="text-muted small">
                        <i class="bi bi-arrow-up-right-square me-1"></i>Form lengkap
                    </a>
                </div>
            </div>
        </div>
    </div>

    {{-- Tabel Data (kanan, mengisi sisa lebar) --}}
    <div class="flex-fill" style="min-width:0;">
        <div class="card shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">#</th>
                                <th>Kelas</th>
                                <th>Mata Kuliah</th>
                                <th>Dosen</th>
                                <th>Hari</th>
                                <th>Jam</th>
                                <th>Ruangan</th>
                                <th class="text-end pe-4">Aksi</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            @forelse($jadwal as $i => $j)
                                <tr id="row-{{ $j->id }}">
                                    <td class="ps-4 text-secondary">{{ $jadwal->firstItem() + $i }}</td>
                                    <td><span class="badge bg-primary bg-opacity-10 text-primary fw-semibold">{{ optional($j->kelas)->nama_kelas }}</span></td>
                                    <td class="fw-semibold">{{ optional($j->mataKuliah)->nama_mk }}</td>
                                    <td class="text-secondary small">{{ optional(optional($j->mataKuliah)->dosen)->nama ?? '-' }}</td>
                                    <td>{{ ucfirst($j->hari) }}</td>
                                    <td class="text-secondary small">{{ $j->jam_mulai }} - {{ $j->jam_selesai }}</td>
                                    <td class="text-secondary small">{{ $j->ruangan ?? optional($j->kelas)->ruang_kelas ?? '-' }}</td>
                                    <td class="text-end pe-4">
                                        <a href="{{ route('admin.jadwal.edit', $j) }}" class="btn btn-sm btn-outline-primary me-1">Edit</a>
                                        <form action="{{ route('admin.jadwal.destroy', $j) }}" method="POST" class="d-inline"
                                              onsubmit="return confirm('Hapus jadwal ini?')">
                                            @csrf @method('DELETE')
                                            <button class="btn btn-sm btn-outline-danger">Hapus</button>
                                        </form>
                                    </td>
                                </tr>
                            @empty
                                <tr id="emptyRow">
                                    <td colspan="8" class="text-center py-5 text-secondary">Belum ada data jadwal.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($jadwal->hasPages())
                    <div class="border-top px-4 py-3">{{ $jadwal->links() }}</div>
                @endif
            </div>
        </div>
    </div>

</div>

<script>
const form    = document.getElementById('quickAddForm');
const alert_  = document.getElementById('formAlert');
const btn     = document.getElementById('btnSubmit');
const tbody   = document.getElementById('tableBody');
let   counter = {{ $jadwal->total() }};

form.addEventListener('submit', async (e) => {
    e.preventDefault(); clearErrors();
    btn.disabled = true;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Menyimpan...';
    try {
        const res  = await fetch('{{ route('admin.jadwal.store') }}', {
            method:'POST',
            headers:{'X-CSRF-TOKEN':csrf(),'Accept':'application/json','X-Requested-With':'XMLHttpRequest'},
            body: new FormData(form),
        });
        const data = await res.json();
        if (!res.ok) {
            if (data.errors) {
                Object.entries(data.errors).forEach(([f,msgs])=>{
                    const el=form.querySelector(`[name="${f}"]`);
                    if(el){el.classList.add('is-invalid');const fb=el.nextElementSibling;if(fb)fb.textContent=msgs[0];}
                });
                showAlert('Periksa kembali isian form.','danger');
            } else showAlert(data.message||'Terjadi kesalahan.','danger');
            return;
        }
        showAlert(data.message,'success'); form.reset();
        const j=data.jadwal; counter++;
        document.getElementById('emptyRow')?.remove();
        const tr=document.createElement('tr'); tr.id=`row-${j.id}`;
        tr.innerHTML=`
            <td class="ps-4 text-secondary">${counter}</td>
            <td><span class="badge bg-primary bg-opacity-10 text-primary fw-semibold">${esc(j.kelas)}</span></td>
            <td class="fw-semibold">${esc(j.mata_kuliah)}</td>
            <td class="text-secondary small">${esc(j.dosen)}</td>
            <td>${esc(j.hari)}</td>
            <td class="text-secondary small">${esc(j.jam)}</td>
            <td class="text-secondary small">${esc(j.ruangan)}</td>
            <td class="text-end pe-4">
                <a href="${j.edit_url}" class="btn btn-sm btn-outline-primary me-1">Edit</a>
                <form action="${j.delete_url}" method="POST" class="d-inline" onsubmit="return confirm('Hapus jadwal ini?')">
                    <input type="hidden" name="_token" value="${csrf()}">
                    <input type="hidden" name="_method" value="DELETE">
                    <button class="btn btn-sm btn-outline-danger">Hapus</button>
                </form>
            </td>`;
        tr.style.background='#eff6ff'; tbody.appendChild(tr);
        setTimeout(()=>{tr.style.transition='background 1s';tr.style.background='';},100);
        tr.scrollIntoView({behavior:'smooth',block:'nearest'});
    } catch(err){ showAlert('Gagal menghubungi server.','danger'); }
    finally{ btn.disabled=false; btn.innerHTML='<i class="bi bi-plus-circle me-1"></i> Simpan'; }
});
function showAlert(msg,type){ alert_.className=`alert alert-${type} py-2 small mb-3`; alert_.textContent=msg; alert_.style.display='block'; setTimeout(()=>{alert_.style.display='none';},4000); }
function clearErrors(){ form.querySelectorAll('.is-invalid').forEach(el=>el.classList.remove('is-invalid')); form.querySelectorAll('.invalid-feedback').forEach(el=>el.textContent=''); }
function csrf(){ return document.querySelector('[name=_token]').value; }
function esc(s){ if(!s)return'-'; return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
</script>
@endsection
