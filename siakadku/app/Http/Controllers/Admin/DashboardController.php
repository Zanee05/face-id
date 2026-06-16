<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Absensi;
use App\Models\ActivityLog;
use App\Models\Dosen;
use App\Models\FaceData;
use App\Models\FaceLog;
use App\Models\Kelas;
use App\Models\Mahasiswa;
use App\Models\AttendanceSession;
use App\Models\MataKuliah;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Schema;

class DashboardController extends Controller
{
    public function index()
    {
        $totalMahasiswa = User::where('role', 'mahasiswa')->count();
        $totalDosen = Dosen::count();
        $totalKelas = Kelas::count();
        $totalAbsensiHariIni = Absensi::whereDate('tanggal', now()->toDateString())->count();

        $rekapBulanan = Absensi::selectRaw('MONTH(tanggal) as bulan, COUNT(*) as total')
            ->whereYear('tanggal', now()->year)
            ->groupBy('bulan')
            ->orderBy('bulan')
            ->get();

        $latestAbsensi = Absensi::with(['mahasiswa', 'mataKuliah'])
            ->latest()
            ->limit(10)
            ->get();

        $latestFaceLogs = FaceLog::with('user')->latest()->limit(10)->get();

        $faceStatus = User::selectRaw(
            'SUM(CASE WHEN face_data.id IS NOT NULL THEN 1 ELSE 0 END) as sudah_daftar, ' .
            'SUM(CASE WHEN face_data.id IS NULL THEN 1 ELSE 0 END) as belum_daftar'
        )
            ->leftJoin('face_data', 'face_data.user_id', '=', 'users.id')
            ->where('users.role', 'mahasiswa')
            ->first();

        $activityLogs = ActivityLog::with('user')->latest()->limit(12)->get();
        $faceUsers = User::where('role', 'mahasiswa')
            ->with('faceData')
            ->orderBy('name')
            ->limit(30)
            ->get();

        return view('admin.dashboard', compact(
            'totalMahasiswa',
            'totalDosen',
            'totalKelas',
            'totalAbsensiHariIni',
            'rekapBulanan',
            'latestAbsensi',
            'latestFaceLogs',
            'faceStatus',
            'activityLogs',
            'faceUsers'
        ));
    }

    public function monitoringAbsensi(Request $request)
    {
        $kelasId = $request->input('kelas_id');
        $mataKuliahId = $request->input('mata_kuliah_id');

        $sessions = AttendanceSession::with(['kelas', 'mataKuliah'])
            ->whereDate('session_date', now()->toDateString())
            ->where('is_active', true)
            ->when($kelasId, function ($query) use ($kelasId) {
                $query->where('kelas_id', $kelasId);
            })
            ->when($mataKuliahId, function ($query) use ($mataKuliahId) {
                $query->where('mata_kuliah_id', $mataKuliahId);
            })
            ->orderBy('start_time')
            ->get()
            ->map(function ($session) {
                $sudahAbsen = Absensi::where('attendance_session_id', $session->id)->count();
                if (Schema::hasTable('mahasiswa_mata_kuliah')) {
                    $targetMahasiswa = Mahasiswa::whereHas('mataKuliahs', function ($q) use ($session) {
                        $q->where('mata_kuliah.id', $session->mata_kuliah_id);
                    })->count();
                } else {
                    $targetMahasiswa = Mahasiswa::where('kelas_id', $session->kelas_id)->count();
                }

                return [
                    'id' => $session->id,
                    'kelas' => optional($session->kelas)->nama_kelas,
                    'mata_kuliah' => optional($session->mataKuliah)->nama_mk,
                    'jam' => $session->start_time . ' - ' . $session->end_time,
                    'target_mahasiswa' => $targetMahasiswa,
                    'sudah_absen' => $sudahAbsen,
                    'belum_absen' => max($targetMahasiswa - $sudahAbsen, 0),
                ];
            });

        if ($request->boolean('json')) {
            return response()->json($sessions);
        }

        $kelasList = Kelas::orderBy('nama_kelas')->get();
        $mataKuliahList = MataKuliah::orderBy('nama_mk')->get();

        return view('admin.monitoring.absensi', [
            'sessions' => $sessions,
            'kelasList' => $kelasList,
            'mataKuliahList' => $mataKuliahList,
            'kelasId' => $kelasId,
            'mataKuliahId' => $mataKuliahId,
        ]);
    }

    public function resetFaceData(User $user)
    {
        $user->faceData()->delete();

        ActivityLog::create([
            'user_id' => auth()->id(),
            'activity_type' => 'face_reset',
            'description' => 'Admin reset data wajah user: ' . $user->email,
            'ip_address' => request()->ip(),
            'user_agent' => (string) request()->userAgent(),
        ]);

        return redirect()->route('admin.dashboard')->with('success', 'Face ID user berhasil direset.');
    }

    public function normalizeEmbeddings()
    {
        $faceDataList = FaceData::all();
        $normalized   = 0;
        $skipped      = 0;

        foreach ($faceDataList as $fd) {
            $emb = $fd->embedding;
            if (!is_array($emb) || count($emb) !== 128) {
                $skipped++;
                continue;
            }

            // Hitung magnitude saat ini
            $ss  = array_sum(array_map(fn($v) => (float)$v * (float)$v, $emb));
            $mag = sqrt($ss);

            if ($mag < 1e-10) {
                $skipped++;
                continue;
            }

            // Sudah ternormalisasi jika magnitude ≈ 1.0 (toleransi 1%)
            if (abs($mag - 1.0) < 0.01) {
                $skipped++;
                continue;
            }

            // Normalisasi L2
            $fd->embedding = array_map(fn($v) => (float)$v / $mag, $emb);
            $fd->save();
            $normalized++;
        }

        ActivityLog::create([
            'user_id'       => auth()->id(),
            'activity_type' => 'face_normalize',
            'description'   => "Admin normalisasi embedding: {$normalized} diproses, {$skipped} dilewati.",
            'ip_address'    => request()->ip(),
            'user_agent'    => (string) request()->userAgent(),
        ]);

        return redirect()->route('admin.dashboard')
            ->with('success', "✅ Normalisasi selesai: {$normalized} data wajah diperbarui, {$skipped} sudah normal.");
    }
}

