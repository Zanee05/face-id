<?php

namespace App\Http\Controllers\Dosen;

use App\Exports\AbsensiExport;
use App\Http\Controllers\Controller;
use App\Models\Absensi;
use App\Models\ActivityLog;
use App\Models\AttendanceSession;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

class AbsensiController extends Controller
{
    public function index()
    {
        $dosen = optional(auth()->user())->dosen;
        abort_if(!$dosen, 422, 'Profil dosen belum terdaftar.');

        $absensi = Absensi::with(['mahasiswa', 'mataKuliah'])
            ->whereHas('mataKuliah', function ($query) use ($dosen) {
                $query->where('dosen_id', $dosen->id);
            })
            ->latest('tanggal')
            ->paginate(20);

        return view('dosen.absensi', compact('absensi'));
    }

    public function rekapHarian(Request $request)
    {
        $dosen = optional(auth()->user())->dosen;
        abort_if(!$dosen, 422, 'Profil dosen belum terdaftar.');

        $tanggal = $request->input('tanggal', now()->toDateString());

        // Ambil sesi pada tanggal tersebut beserta relasinya
        $sessions = AttendanceSession::with(['kelas', 'mataKuliah'])
            ->where('dosen_id', $dosen->id)
            ->whereDate('session_date', $tanggal)
            ->get();

        // Hitung statistik absensi per sesi untuk menghindari N+1 query
        $sessionIds = $sessions->pluck('id');
        $counts = Absensi::whereIn('attendance_session_id', $sessionIds)
            ->selectRaw('attendance_session_id, status, count(*) as total')
            ->groupBy('attendance_session_id', 'status')
            ->get()
            ->groupBy('attendance_session_id');

        $sessions->each(function ($session) use ($counts) {
            $session->rekap = $counts->get($session->id, collect())->pluck('total', 'status');
        });

        return view('dosen.rekap_harian', compact('sessions', 'tanggal'));
    }

    public function exportRekap(Request $request)
    {
        $dosen = optional(auth()->user())->dosen;
        abort_if(!$dosen, 422, 'Profil dosen belum terdaftar.');

        $tanggal = $request->input('tanggal');
        $query = Absensi::with('mahasiswa')
            ->whereHas('mataKuliah', function ($q) use ($dosen) {
                $q->where('dosen_id', $dosen->id);
            })
            ->orderByDesc('tanggal')
            ->orderBy('mahasiswa_id');

        if ($tanggal) {
            $query->whereDate('tanggal', $tanggal);
        }

        $rows = $query->get();
        $filename = 'rekap-absensi-dosen-' . ($tanggal ?: now()->toDateString());

        return Excel::download(new AbsensiExport($rows), $filename . '.xlsx');
    }

    public function verify(Request $request, Absensi $absensi)
    {
        $request->validate([
            'decision' => 'required|in:approved,rejected',
        ]);

        $absensi->update([
            'verification_status' => $request->decision,
            'verified_by_dosen' => auth()->id(),
            'verified_at' => now(),
        ]);

        ActivityLog::create([
            'user_id' => auth()->id(),
            'activity_type' => 'dosen_verifikasi_absensi',
            'description' => 'Dosen memverifikasi absensi #' . $absensi->id . ' sebagai ' . $request->decision,
            'ip_address' => $request->ip(),
            'user_agent' => (string) $request->userAgent(),
        ]);

        return back()->with('success', 'Verifikasi absensi berhasil diperbarui.');
    }
    
}
