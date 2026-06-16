@extends('layouts.app')

@section('content')
<h4 class="fw-bold mb-3">Manajemen User</h4>

{{-- Tab Role --}}
<div class="card shadow-sm mb-0 border-bottom-0" style="border-radius:0.9rem 0.9rem 0 0;">
    <div class="card-body pb-0 pt-3 px-3">
        <ul class="nav nav-tabs border-0" id="roleTabs">
            @foreach(['mahasiswa' => 'Mahasiswa', 'dosen' => 'Dosen', 'admin' => 'Admin'] as $roleKey => $roleLabel)
                <li class="nav-item">
                    <a class="nav-link fw-semibold px-4 {{ $role === $roleKey ? 'active' : '' }}"
                        href="{{ route('admin.users.index', ['role' => $roleKey]) }}">
                        {{ $roleLabel }}
                        <span class="badge ms-1 {{ $role === $roleKey ? 'bg-primary' : 'bg-secondary bg-opacity-25 text-secondary' }}"
                              id="badge-{{ $roleKey }}">{{ $counts[$roleKey] }}</span>
                    </a>
                </li>
            @endforeach
        </ul>
    </div>
</div>

<div class="d-flex gap-3 align-items-start mt-0 pt-0"
     style="background:#fff;border-radius:0 0 0.9rem 0.9rem;border:1px solid rgba(0,0,0,.125);border-top:none;padding:16px;">

    {{-- Form Tambah (kiri, lebar tetap) --}}
    <div style="width:280px;flex-shrink:0;">
        <div class="card shadow-sm border">
            <div class="card-header bg-primary text-white py-2">
                <h6 class="mb-0 fw-bold"><i class="bi bi-person-plus-fill me-1"></i> Tambah {{ ucfirst($role) }}</h6>
            </div>
            <div class="card-body p-3">
                <div id="formAlert" style="display:none;" class="alert py-2 small mb-3"></div>
                <form id="quickAddForm" novalidate>
                    @csrf
                    <input type="hidden" name="role" value="{{ $role }}">
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Nama Lengkap <span class="text-danger">*</span></label>
                        <input type="text" name="name" class="form-control form-control-sm" placeholder="Nama lengkap" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" class="form-control form-control-sm" placeholder="email@domain.com" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    @if($role === 'mahasiswa')
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">NIM <span class="text-danger">*</span></label>
                        <input type="text" name="nim" class="form-control form-control-sm" placeholder="Nomor Induk Mahasiswa" required>
                        <div class="invalid-feedback small"></div>
                    </div>
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
                    @endif
                    @if($role === 'dosen')
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">NIDN <span class="text-danger">*</span></label>
                        <input type="text" name="nidn" class="form-control form-control-sm" placeholder="Nomor Induk Dosen" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    @endif
                    <div class="mb-2">
                        <label class="form-label small fw-semibold mb-1">Password <span class="text-danger">*</span></label>
                        <input type="password" name="password" class="form-control form-control-sm" placeholder="Min. 8 karakter" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold mb-1">Konfirmasi Password <span class="text-danger">*</span></label>
                        <input type="password" name="password_confirmation" class="form-control form-control-sm" placeholder="Ulangi password" required>
                        <div class="invalid-feedback small"></div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-sm w-100" id="btnSubmit">
                        <i class="bi bi-plus-circle me-1"></i> Simpan
                    </button>
                </form>
                <div class="text-center mt-2">
                    <a href="{{ route('admin.users.create', ['role' => $role]) }}" class="text-muted small">
                        <i class="bi bi-arrow-up-right-square me-1"></i>Form lengkap
                    </a>
                </div>
            </div>
        </div>
    </div>

    {{-- Tabel Data (kanan, mengisi sisa lebar) --}}
    <div class="flex-fill" style="min-width:0;">
        <div class="card shadow-sm border">
            <div class="card-body p-0">
                <div class="table-responsive">

                    @if($role === 'mahasiswa')
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                            <tr><th class="ps-4">#</th><th>Nama</th><th>NIM</th><th>Email</th><th>Kelas</th><th class="text-end pe-4">Aksi</th></tr>
                        </thead>
                        <tbody id="userTableBody">
                            @forelse($users as $i => $user)
                                <tr id="row-{{ $user->id }}">
                                    <td class="ps-4 text-secondary">{{ $users->firstItem() + $i }}</td>
                                    <td><div class="fw-semibold">{{ $user->name }}</div></td>
                                    <td><code>{{ optional($user->mahasiswa)->nim ?? '-' }}</code></td>
                                    <td class="text-secondary small">{{ $user->email }}</td>
                                    <td>
                                        @if($user->mahasiswa?->kelas)
                                            <span class="badge bg-primary bg-opacity-10 text-primary fw-semibold">{{ $user->mahasiswa->kelas->nama_kelas }}</span>
                                        @else
                                            <span class="text-secondary">-</span>
                                        @endif
                                    </td>
                                    <td class="text-end pe-4">
                                        <a href="{{ route('admin.users.edit', $user) }}" class="btn btn-sm btn-outline-primary me-1">Edit</a>
                                        <form action="{{ route('admin.users.destroy', $user) }}" method="POST" class="d-inline" onsubmit="return confirm('Hapus mahasiswa {{ $user->name }}?')">
                                            @csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Hapus</button>
                                        </form>
                                    </td>
                                </tr>
                            @empty
                                <tr id="emptyRow"><td colspan="6" class="text-center py-5 text-secondary">Belum ada data mahasiswa.</td></tr>
                            @endforelse
                        </tbody>
                    </table>

                    @elseif($role === 'dosen')
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                            <tr><th class="ps-4">#</th><th>Nama</th><th>NIDN</th><th>Email</th><th>Mata Kuliah</th><th class="text-end pe-4">Aksi</th></tr>
                        </thead>
                        <tbody id="userTableBody">
                            @forelse($users as $i => $user)
                                <tr id="row-{{ $user->id }}">
                                    <td class="ps-4 text-secondary">{{ $users->firstItem() + $i }}</td>
                                    <td><div class="fw-semibold">{{ $user->name }}</div></td>
                                    <td><code>{{ optional($user->dosen)->nidn ?? '-' }}</code></td>
                                    <td class="text-secondary small">{{ $user->email }}</td>
                                    <td>
                                        @php $mkCount = optional($user->dosen)?->mataKuliah()->count() ?? 0; @endphp
                                        @if($mkCount > 0)
                                            <span class="badge bg-success bg-opacity-10 text-success fw-semibold">{{ $mkCount }} MK</span>
                                        @else
                                            <span class="text-secondary small">-</span>
                                        @endif
                                    </td>
                                    <td class="text-end pe-4">
                                        <a href="{{ route('admin.users.edit', $user) }}" class="btn btn-sm btn-outline-primary me-1">Edit</a>
                                        <form action="{{ route('admin.users.destroy', $user) }}" method="POST" class="d-inline" onsubmit="return confirm('Hapus dosen {{ $user->name }}?')">
                                            @csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Hapus</button>
                                        </form>
                                    </td>
                                </tr>
                            @empty
                                <tr id="emptyRow"><td colspan="6" class="text-center py-5 text-secondary">Belum ada data dosen.</td></tr>
                            @endforelse
                        </tbody>
                    </table>

                    @else
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                            <tr><th class="ps-4">#</th><th>Nama</th><th>Email</th><th>Bergabung</th><th class="text-end pe-4">Aksi</th></tr>
                        </thead>
                        <tbody id="userTableBody">
                            @forelse($users as $i => $user)
                                <tr id="row-{{ $user->id }}">
                                    <td class="ps-4 text-secondary">{{ $users->firstItem() + $i }}</td>
                                    <td>
                                        <div class="fw-semibold d-flex align-items-center gap-2">
                                            {{ $user->name }}
                                            @if($user->id === auth()->id())
                                                <span class="badge bg-primary bg-opacity-10 text-primary" style="font-size:.7rem">Anda</span>
                                            @endif
                                        </div>
                                    </td>
                                    <td class="text-secondary small">{{ $user->email }}</td>
                                    <td class="text-secondary small">{{ $user->created_at->format('d M Y') }}</td>
                                    <td class="text-end pe-4">
                                        <a href="{{ route('admin.users.edit', $user) }}" class="btn btn-sm btn-outline-primary me-1">Edit</a>
                                        @if($user->id !== auth()->id())
                                            <form action="{{ route('admin.users.destroy', $user) }}" method="POST" class="d-inline" onsubmit="return confirm('Hapus admin {{ $user->name }}?')">
                                                @csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Hapus</button>
                                            </form>
                                        @else
                                            <button class="btn btn-sm btn-outline-danger" disabled>Hapus</button>
                                        @endif
                                    </td>
                                </tr>
                            @empty
                                <tr id="emptyRow"><td colspan="5" class="text-center py-5 text-secondary">Belum ada data admin.</td></tr>
                            @endforelse
                        </tbody>
                    </table>
                    @endif

                </div>
                @if($users->hasPages())
                    <div class="border-top px-4 py-3">{{ $users->links() }}</div>
                @endif
            </div>
        </div>
    </div>

</div>

<script>
const quickForm   = document.getElementById('quickAddForm');
const formAlert   = document.getElementById('formAlert');
const btnSubmit   = document.getElementById('btnSubmit');
const tableBody   = document.getElementById('userTableBody');
const currentRole = '{{ $role }}';
let rowCounter    = {{ $users->total() }};

quickForm.addEventListener('submit', async (e) => {
    e.preventDefault(); clearErrors();
    btnSubmit.disabled = true;
    btnSubmit.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Menyimpan...';
    try {
        const res  = await fetch('{{ route('admin.users.store') }}', {
            method:'POST',
            headers:{'X-CSRF-TOKEN':csrf(),'Accept':'application/json','X-Requested-With':'XMLHttpRequest'},
            body: new FormData(quickForm),
        });
        const data = await res.json();
        if (!res.ok) {
            if (data.errors) {
                Object.entries(data.errors).forEach(([f,msgs])=>{
                    const el=quickForm.querySelector(`[name="${f}"]`);
                    if(el){el.classList.add('is-invalid');const fb=el.nextElementSibling;if(fb)fb.textContent=msgs[0];}
                });
                showAlert('Periksa kembali isian form.','danger');
            } else showAlert(data.message||'Terjadi kesalahan.','danger');
            return;
        }
        showAlert(data.message,'success'); quickForm.reset();
        appendRow(data.user); updateBadge(data.counts);
    } catch(err){ showAlert('Gagal menghubungi server.','danger'); }
    finally{ btnSubmit.disabled=false; btnSubmit.innerHTML='<i class="bi bi-plus-circle me-1"></i> Simpan'; }
});

function appendRow(user) {
    document.getElementById('emptyRow')?.remove();
    rowCounter++;
    let cells = '';
    if (currentRole === 'mahasiswa') {
        cells = `<td class="ps-4 text-secondary">${rowCounter}</td><td><div class="fw-semibold">${esc(user.name)}</div></td><td><code>${esc(user.nim??'-')}</code></td><td class="text-secondary small">${esc(user.email)}</td><td>${user.kelas?`<span class="badge bg-primary bg-opacity-10 text-primary fw-semibold">${esc(user.kelas)}</span>`:'<span class="text-secondary">-</span>'}</td><td class="text-end pe-4"><a href="${user.edit_url}" class="btn btn-sm btn-outline-primary me-1">Edit</a><form action="${user.delete_url}" method="POST" class="d-inline" onsubmit="return confirm('Hapus mahasiswa ${esc(user.name)}?')"><input type="hidden" name="_token" value="${csrf()}"><input type="hidden" name="_method" value="DELETE"><button class="btn btn-sm btn-outline-danger">Hapus</button></form></td>`;
    } else if (currentRole === 'dosen') {
        cells = `<td class="ps-4 text-secondary">${rowCounter}</td><td><div class="fw-semibold">${esc(user.name)}</div></td><td><code>${esc(user.nidn??'-')}</code></td><td class="text-secondary small">${esc(user.email)}</td><td>${user.mk_count>0?`<span class="badge bg-success bg-opacity-10 text-success fw-semibold">${user.mk_count} MK</span>`:'<span class="text-secondary small">-</span>'}</td><td class="text-end pe-4"><a href="${user.edit_url}" class="btn btn-sm btn-outline-primary me-1">Edit</a><form action="${user.delete_url}" method="POST" class="d-inline" onsubmit="return confirm('Hapus dosen ${esc(user.name)}?')"><input type="hidden" name="_token" value="${csrf()}"><input type="hidden" name="_method" value="DELETE"><button class="btn btn-sm btn-outline-danger">Hapus</button></form></td>`;
    } else {
        cells = `<td class="ps-4 text-secondary">${rowCounter}</td><td><div class="fw-semibold">${esc(user.name)}</div></td><td class="text-secondary small">${esc(user.email)}</td><td class="text-secondary small">${esc(user.created_at)}</td><td class="text-end pe-4"><a href="${user.edit_url}" class="btn btn-sm btn-outline-primary me-1">Edit</a><form action="${user.delete_url}" method="POST" class="d-inline" onsubmit="return confirm('Hapus admin ${esc(user.name)}?')"><input type="hidden" name="_token" value="${csrf()}"><input type="hidden" name="_method" value="DELETE"><button class="btn btn-sm btn-outline-danger">Hapus</button></form></td>`;
    }
    const tr = document.createElement('tr'); tr.id=`row-${user.id}`; tr.innerHTML=cells;
    tr.style.background='#eff6ff'; tableBody.appendChild(tr);
    setTimeout(()=>{tr.style.transition='background 1s';tr.style.background='';},100);
    tr.scrollIntoView({behavior:'smooth',block:'nearest'});
}
function updateBadge(counts){ Object.entries(counts).forEach(([r,c])=>{ const b=document.getElementById(`badge-${r}`); if(b)b.textContent=c; }); }
function showAlert(msg,type){ formAlert.className=`alert alert-${type} py-2 small mb-3`; formAlert.textContent=msg; formAlert.style.display='block'; setTimeout(()=>{formAlert.style.display='none';},4000); }
function clearErrors(){ quickForm.querySelectorAll('.is-invalid').forEach(el=>el.classList.remove('is-invalid')); quickForm.querySelectorAll('.invalid-feedback').forEach(el=>el.textContent=''); }
function csrf(){ return document.querySelector('[name=_token]').value; }
function esc(s){ if(!s)return'-'; return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
</script>
@endsection
