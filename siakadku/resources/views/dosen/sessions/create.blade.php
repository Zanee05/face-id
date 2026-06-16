@extends('layouts.app')

@section('content')
<div class="container" style="max-width:680px;">
    <h4 class="mb-3 fw-bold">Buat Sesi Absensi</h4>

    <div class="card shadow-sm">
        <div class="card-body">
            <form method="POST" action="{{ route('dosen.sessions.store') }}">
                @csrf
                <input type="hidden" name="use_jadwal_time" value="1">

                <div class="row g-3">

                    {{-- 1. Mata Kuliah — pilih dulu, sisanya otomatis --}}
                    <div class="col-12">
                        <label class="form-label fw-semibold">Mata Kuliah <span class="text-danger">*</span></label>
                        <select class="form-select" name="mata_kuliah_id" id="mata_kuliah_id" required>
                            <option value="">-- Pilih mata kuliah --</option>
                            @foreach($mataKuliah as $mk)
                                <option value="{{ $mk->id }}">{{ $mk->nama_mk }}</option>
                            @endforeach
                        </select>
                        <div class="form-text text-muted">Pilih mata kuliah — kelas, hari, dan jam akan terisi otomatis</div>
                    </div>

                    {{-- Info jadwal yang ditemukan --}}
                    <div class="col-12" id="jadwal_info_wrap" style="display:none;">
                        <div class="alert alert-success py-2 mb-0 small" id="jadwal_info_text"></div>
                    </div>

                    {{-- Jika ada lebih dari 1 jadwal untuk MK ini, tampilkan pilihan --}}
                    <div class="col-12" id="jadwal_picker_wrap" style="display:none;">
                        <label class="form-label fw-semibold">Pilih Jadwal</label>
                        <select class="form-select" id="jadwal_picker">
                            <option value="">-- Pilih jadwal --</option>
                        </select>
                        <div class="form-text text-muted">Mata kuliah ini memiliki beberapa jadwal</div>
                    </div>

                    {{-- 2. Kelas — readonly, diisi otomatis --}}
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Kelas</label>
                        <select class="form-select" name="kelas_id" id="kelas_id" required>
                            <option value="">-- otomatis --</option>
                            @foreach($kelas as $k)
                                <option value="{{ $k->id }}">{{ $k->nama_kelas }}</option>
                            @endforeach
                        </select>
                    </div>

                    {{-- 3. Metode --}}
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Metode Absensi <span class="text-danger">*</span></label>
                        <select class="form-select" name="method" required>
                            <option value="manual">Manual/Ceklis</option>
                            <option value="barcode">Barcode</option>
                            <option value="faceid" selected>Face ID</option>
                        </select>
                    </div>

                    {{-- 4. Tanggal — otomatis ke hari jadwal berikutnya, bisa diubah --}}
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Tanggal <span class="text-danger">*</span></label>
                        <input class="form-control" type="date" name="session_date" id="session_date"
                               value="{{ date('Y-m-d') }}" required>
                        <div class="form-text" id="tanggal_hint"></div>
                    </div>

                    {{-- 5. Jam Mulai — otomatis dari jadwal --}}
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Jam Mulai</label>
                        <input class="form-control" type="time" name="start_time" id="start_time">
                    </div>

                    {{-- 6. Jam Selesai — otomatis dari jadwal --}}
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Jam Selesai</label>
                        <input class="form-control" type="time" name="end_time" id="end_time">
                    </div>

                </div>

                <div class="mt-4 d-flex gap-2">
                    <button class="btn btn-primary px-4">Simpan Sesi</button>
                    <a href="{{ route('dosen.sessions.index') }}" class="btn btn-outline-secondary">Batal</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
(() => {
    const mkEl          = document.getElementById('mata_kuliah_id');
    const kelasEl       = document.getElementById('kelas_id');
    const dateEl        = document.getElementById('session_date');
    const startEl       = document.getElementById('start_time');
    const endEl         = document.getElementById('end_time');
    const infoWrap      = document.getElementById('jadwal_info_wrap');
    const infoText      = document.getElementById('jadwal_info_text');
    const pickerWrap    = document.getElementById('jadwal_picker_wrap');
    const picker        = document.getElementById('jadwal_picker');
    const tanggalHint   = document.getElementById('tanggal_hint');

    // Nama hari → angka JS (0=Minggu)
    const hariToDay = { minggu:0, senin:1, selasa:2, rabu:3, kamis:4, jumat:5, sabtu:6 };

    // Hitung tanggal berikutnya yang sesuai hari jadwal
    function nextDateForHari(hariStr) {
        const target  = hariToDay[hariStr.toLowerCase()];
        if (target === undefined) return null;
        const today   = new Date();
        let diff      = target - today.getDay();
        if (diff < 0) diff += 7;
        const result  = new Date(today);
        result.setDate(today.getDate() + diff);
        return result.toISOString().split('T')[0];
    }

    function ucfirst(s) { return s ? s.charAt(0).toUpperCase() + s.slice(1) : s; }

    // Terapkan satu jadwal ke form
    function applyJadwal(j) {
        // Kelas
        kelasEl.value = j.kelas_id;

        // Jam
        startEl.value = j.start_time;
        endEl.value   = j.end_time;

        // Tanggal → hari jadwal berikutnya
        const nextDate = nextDateForHari(j.hari);
        if (nextDate) {
            dateEl.value = nextDate;
            tanggalHint.className   = 'form-text text-success';
            tanggalHint.textContent = `✓ Tanggal diisi ke ${ucfirst(j.hari)} berikutnya`;
        }

        // Info
        infoText.textContent = `✅ Jadwal: ${ucfirst(j.hari)}, ${j.start_time} – ${j.end_time}, Kelas ${j.kelas_nama}`;
        infoWrap.style.display = 'block';
    }

    // Saat mata kuliah dipilih
    mkEl.addEventListener('change', async () => {
        const mk_id = mkEl.value;

        // Reset
        pickerWrap.style.display = 'none';
        infoWrap.style.display   = 'none';
        tanggalHint.textContent  = '';
        picker.innerHTML         = '<option value="">-- Pilih jadwal --</option>';

        if (!mk_id) return;

        infoText.textContent = '⏳ Mengambil jadwal...';
        infoWrap.style.display = 'block';

        try {
            const url = new URL(@json(route('dosen.sessions.jadwal-by-mk')), window.location.origin);
            url.searchParams.set('mata_kuliah_id', mk_id);

            const res  = await fetch(url.toString(), { headers: { 'Accept': 'application/json' } });
            const data = await res.json();

            if (!res.ok || !data.found || !data.jadwal.length) {
                infoText.textContent = 'ℹ️ Jadwal belum diatur untuk mata kuliah ini. Isi kelas, tanggal, dan jam secara manual.';
                infoText.className   = 'alert alert-warning py-2 mb-0 small';
                return;
            }

            infoText.className = 'alert alert-success py-2 mb-0 small';

            if (data.jadwal.length === 1) {
                // Hanya 1 jadwal — langsung terapkan
                applyJadwal(data.jadwal[0]);
            } else {
                // Lebih dari 1 jadwal — tampilkan picker
                data.jadwal.forEach((j, i) => {
                    const opt = document.createElement('option');
                    opt.value = i;
                    opt.textContent = `${ucfirst(j.hari)} | ${j.start_time}–${j.end_time} | Kelas ${j.kelas_nama}`;
                    picker.appendChild(opt);
                });

                pickerWrap.style.display = 'block';
                infoText.textContent = `Ditemukan ${data.jadwal.length} jadwal. Pilih salah satu di bawah.`;

                // Simpan data jadwal untuk diakses picker
                picker._jadwalData = data.jadwal;

                // Terapkan jadwal pertama sebagai default
                applyJadwal(data.jadwal[0]);
                picker.value = '0';
            }

        } catch (e) {
            infoText.textContent = '⚠️ Gagal mengambil jadwal. Isi manual.';
            infoText.className   = 'alert alert-warning py-2 mb-0 small';
        }
    });

    // Saat picker jadwal berubah (jika ada lebih dari 1 jadwal)
    picker.addEventListener('change', () => {
        const idx = parseInt(picker.value);
        if (isNaN(idx) || !picker._jadwalData) return;
        applyJadwal(picker._jadwalData[idx]);
    });
})();
</script>
@endsection
