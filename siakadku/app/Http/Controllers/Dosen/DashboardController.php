<?php

namespace App\Http\Controllers\Dosen;

use App\Http\Controllers\Controller;
use App\Models\Absensi;
use App\Models\FaceLog;
use App\Models\JadwalKelas;
use App\Models\MataKuliah;
use App\Models\Mahasiswa;
use Illuminate\Support\Facades\Schema;

class DashboardController extends Controller
{
    public function index()
    {
        $dosen = auth()->user()->dosen;
        // Ambil ID MK langsung dari tabel (hindari ambigu pluck lewat relasi)
        $mataKuliahIds = $dosen
            ? MataKuliah::where('dosen_id', $dosen->id)->pluck('id')
            : collect();

        // Jumlah mahasiswa diampu: dari susunan MK (pivot), bukan hanya yang sudah pernah absen
        if ($mataKuliahIds->isNotEmpty() && Schema::hasTable('mahasiswa_mata_kuliah')) {
            $totalMahasiswaKelas = Mahasiswa::whereHas('mataKuliahs', function ($q) use ($mataKuliahIds) {
                $q->whereIn('mata_kuliah.id', $mataKuliahIds);
            })->count();
        } elseif ($mataKuliahIds->isNotEmpty()) {
            $totalMahasiswaKelas = Mahasiswa::whereHas('absensi', function ($q) use ($mataKuliahIds) {
                $q->whereIn('mata_kuliah_id', $mataKuliahIds);
            })->distinct('mahasiswa.id')->count('mahasiswa.id');
        } else {
            $totalMahasiswaKelas = 0;
        }

        $hadirHariIni = Absensi::whereIn('mata_kuliah_id', $mataKuliahIds)
            ->whereDate('tanggal', now()->toDateString())
            ->whereIn('status', ['hadir', 'telat'])
            ->count();

        $persentase = $totalMahasiswaKelas > 0
            ? round(($hadirHariIni / $totalMahasiswaKelas) * 100, 2)
            : 0;

        $absensiKelas = Absensi::with(['mahasiswa', 'mataKuliah'])
            ->whereIn('mata_kuliah_id', $mataKuliahIds)
            ->latest()
            ->paginate(15);

        $faceLogs = FaceLog::with(['user', 'absensi'])
            ->whereHas('absensi', function ($q) use ($mataKuliahIds) {
                $q->whereIn('mata_kuliah_id', $mataKuliahIds);
            })
            ->latest()
            ->limit(20)
            ->get();

        // Jadwal: baris jadwal_kelas yang MK-nya pengampunya dosen ini (bukan hanya whereIn id, agar konsisten)
        $jadwalMengajar = collect();
        if ($dosen) {
            $jadwalMengajar = JadwalKelas::with(['kelas', 'mataKuliah'])
                ->whereHas('mataKuliah', function ($query) use ($dosen) {
                    $query->where('dosen_id', $dosen->id);
                })
                ->orderByRaw("FIELD(hari, 'senin','selasa','rabu','kamis','jumat','sabtu')")
                ->orderBy('jam_mulai')
                ->get();
        }

        $punyaMataKuliah = $mataKuliahIds->isNotEmpty();

        return view('dosen.dashboard', compact(
            'totalMahasiswaKelas',
            'hadirHariIni',
            'persentase',
            'absensiKelas',
            'faceLogs',
            'jadwalMengajar',
            'dosen',
            'punyaMataKuliah'
        ));
    }
}

