<?php

namespace App\Http\Controllers\Mahasiswa;

use App\Http\Controllers\Controller;
use App\Models\Absensi;
use App\Models\JadwalKelas;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class DashboardController extends Controller
{
    public function index()
    {
        $user = auth()->user();
        $mahasiswa = $user->mahasiswa;

        $absensiHariIni = null;
        $riwayat = Absensi::whereRaw('1 = 0')->paginate(10);

        if ($mahasiswa) {
            $absensiHariIni = Absensi::with('mataKuliah')
                ->where('mahasiswa_id', $mahasiswa->id)
                ->whereDate('tanggal', now()->toDateString())
                ->first();

            $riwayat = Absensi::with('mataKuliah')
                ->where('mahasiswa_id', $mahasiswa->id)
                ->latest('tanggal')
                ->paginate(10);
        }

        $sudahDaftarWajah = $user->faceData()->exists();
        $jadwalKelas = collect();
        $mataKuliahDipilih = collect();
        $punyaPilihanMk = false;
        $jadwalKosongPadahalPilihMk = false;

        if ($mahasiswa) {
            // Ambil ID MK dari pivot (eksplisit) — hindari ambigu kolom `id` join vs mata_kuliah.id
            $selectedCourseIds = collect();
            if (Schema::hasTable('mahasiswa_mata_kuliah')) {
                $selectedCourseIds = DB::table('mahasiswa_mata_kuliah')
                    ->where('mahasiswa_id', $mahasiswa->id)
                    ->pluck('mata_kuliah_id');
            }

            $punyaPilihanMk = $selectedCourseIds->isNotEmpty();

            if ($punyaPilihanMk) {
                $mataKuliahDipilih = $mahasiswa->mataKuliahs()->with('dosen')->orderBy('nama_mk')->get();
            }

            $jadwalKelas = JadwalKelas::with(['mataKuliah.dosen', 'kelas'])
                ->where('kelas_id', $mahasiswa->kelas_id)
                ->when($punyaPilihanMk, function ($query) use ($selectedCourseIds) {
                    $query->whereIn('mata_kuliah_id', $selectedCourseIds);
                }, function ($query) {
                    $query->whereRaw('1 = 0');
                })
                ->orderByRaw("FIELD(hari, 'senin','selasa','rabu','kamis','jumat','sabtu')")
                ->orderBy('jam_mulai')
                ->get();

            // Susun MK ≠ jadwal: jadwal diisi admin (jadwal_kelas) per kelas + MK + hari/jam
            $jadwalKosongPadahalPilihMk = $punyaPilihanMk && $jadwalKelas->isEmpty();
        }

        return view('mahasiswa.dashboard', compact(
            'absensiHariIni',
            'riwayat',
            'sudahDaftarWajah',
            'jadwalKelas',
            'mataKuliahDipilih',
            'punyaPilihanMk',
            'jadwalKosongPadahalPilihMk'
        ));
    }
}

