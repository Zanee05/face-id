@extends('layouts.app')

@section('content')
<h4 class="fw-bold mb-3">Kelola Mata Kuliah</h4>

<div class="d-flex gap-3 align-items-start">

    {{-- Form Tambah (kiri, lebar tetap) --}}
    <div style="width:280px;flex-shrink:0;">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white py-2">
                <h6 class="mb-0 fw-bold"><i class="bi bi-book-fill me-1"></i> Tambah Mata Kuliah</h6>
            </div>
            <div class="card-body p-3">
                <div id="formAlert" style="display:none;" class="alert py-2 small mb-3"></div>
                <form id="quickAddForm" novalidate>
                    @csrf
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Kode MK <span class="text-danger">*</span></label>
                        <input type="text" name="kode_mk" class="form-control form-control-sm" placeholder="Contoh: F4E6" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Nama Mata Kuliah <span class="text-danger">*</span></label>
                        <input type="text" name="nama_mk" class="form-control form-control-sm" placeholder="Nama mata kuliah" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">SKS <span class="text-danger">*</span></label> 
                        <select name="sks" class="form-select form-select-sm" required>
                            <option value="">-- Pilih SKS --</option>
                            @for($s = 1; $s <= 6; $s++)
                                <option value="{{ $s }}">{{ $s }} SKS</option>
                            @endfor
                        </select>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold mb-1">Dosen Pengampu <span class="text-danger">*</span></label>
                        <select name="dosen_id" class="form-select form-select-sm" required>
                            <option value="">-- Pilih Dosen --</option>
                            @foreach(\App\Models\Dosen::orderBy('nama')->get() as $d)
                                <option value="{{ $d->id }}">{{ $d->nama }}</option>
                            @endforeach
                        </select>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-sm w-100" id="btnSubmit">
                        <i class="bi bi-plus-circle me-1"></i> Simpan
                    </button>
                </form>
                <div class="text-center mt-2">
                    <a href="{{ route('admin.mata-kuliah.create') }}" class="text-muted small">
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
                                <th>Kode</th>
                                <th>Nama</th>
                                <th>SKS</th>
                                <th>Dosen</th>
                                <th class="text-end pe-4">Aksi</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            @forelse($mataKuliah as $i => $mk)
                                <tr id="row-{{ $mk->id }}">
                                    <td class="ps-4 text-secondary">{{ $mataKuliah->firstItem() + $i }}</td>
                                    <td><code>{{ $mk->kode_mk }}</code></td>
                                    <td class="fw-semibold">{{ $mk->nama_mk }}</td>
                                    <td><span class="badge bg-secondary bg-opacity-10 text-secondary">{{ $mk->sks }} SKS</span></td>
                                    <td class="text-secondary small">{{ optional($mk->dosen)->nama ?? '-' }}</td>
                                    <td class="text-end pe-4">
                                        <a href="{{ route('admin.mata-kuliah.edit', $mk) }}" class="btn btn-sm btn-outline-primary me-1">Edit</a>
                                        <form action="{{ route('admin.mata-kuliah.destroy', $mk) }}" method="POST" class="d-inline"
                                              onsubmit="return confirm('Hapus mata kuliah {{ $mk->nama_mk }}?')">
                                            @csrf @method('DELETE')
                                            <button class="btn btn-sm btn-outline-danger">Hapus</button>
                                        </form>
                                    </td>
                                </tr>
                            @empty
                                <tr id="emptyRow">
                                    <td colspan="6" class="text-center py-5 text-secondary">Belum ada data mata kuliah.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($mataKuliah->hasPages())
                    <div class="border-top px-4 py-3">{{ $mataKuliah->links() }}</div>
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
let   counter = {{ $mataKuliah->total() }};

form.addEventListener('submit', async (e) => {
    e.preventDefault(); clearErrors();
    btn.disabled = true;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Menyimpan...';
    try {
        const res  = await fetch('{{ route('admin.mata-kuliah.store') }}', {
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
        const mk=data.mataKuliah; counter++;
        document.getElementById('emptyRow')?.remove();
        const tr=document.createElement('tr'); tr.id=`row-${mk.id}`;
        tr.innerHTML=`
            <td class="ps-4 text-secondary">${counter}</td>
            <td><code>${esc(mk.kode_mk)}</code></td>
            <td class="fw-semibold">${esc(mk.nama_mk)}</td>
            <td><span class="badge bg-secondary bg-opacity-10 text-secondary">${esc(mk.sks)} SKS</span></td>
            <td class="text-secondary small">${esc(mk.dosen)}</td>
            <td class="text-end pe-4">
                <a href="${mk.edit_url}" class="btn btn-sm btn-outline-primary me-1">Edit</a>
                <form action="${mk.delete_url}" method="POST" class="d-inline" onsubmit="return confirm('Hapus mata kuliah ${esc(mk.nama_mk)}?')">
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
