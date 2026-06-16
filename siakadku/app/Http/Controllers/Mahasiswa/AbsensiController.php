<?php

namespace App\Http\Controllers\Mahasiswa;

use App\Http\Controllers\Controller;
use App\Models\Absensi;
use App\Models\ActivityLog;
use App\Models\AttendanceSession;
use App\Models\FaceData;
use App\Models\User;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Schema;

class AbsensiController extends Controller
{
    public function rekap()
    {
        $mahasiswa = optional(auth()->user())->mahasiswa;
        abort_if(!$mahasiswa, 422, 'Profil mahasiswa belum terdaftar.');

        $baseQuery = Absensi::query()->where('mahasiswa_id', $mahasiswa->id);

        $rekap = $baseQuery
            ->select(
                'mata_kuliah_id',
                DB::raw('COUNT(*) as total_pertemuan'),
                DB::raw("SUM(CASE WHEN status = 'hadir' THEN 1 ELSE 0 END) as total_hadir"),
                DB::raw("SUM(CASE WHEN status = 'telat' THEN 1 ELSE 0 END) as total_telat"),
                DB::raw("SUM(CASE WHEN status = 'tidak_hadir' THEN 1 ELSE 0 END) as total_alpha")
            )
            ->with('mataKuliah')
            ->groupBy('mata_kuliah_id')
            ->orderBy('mata_kuliah_id')
            ->get()
            ->map(function ($row) {
                $presentCount = (int) $row->total_hadir + (int) $row->total_telat;
                $meetingCount = max(1, (int) $row->total_pertemuan);
                $percentage = round(($presentCount / $meetingCount) * 100, 2);

                $row->persentase_kehadiran = $percentage;
                return $row;
            });

        return view('mahasiswa.rekap_absensi', compact('rekap'));
    }

    public function index()
    {
        $faceData = auth()->user()->faceData;
        return view('mahasiswa.absensi', compact('faceData'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'embedding' => ['required', 'array', 'size:128'],
            'embedding.*' => ['required', 'numeric'],
        ]);

        FaceData::updateOrCreate(
            ['user_id' => auth()->id()],
            ['embedding' => $request->embedding]
        );

        ActivityLog::create([
            'user_id' => auth()->id(),
            'activity_type' => 'face_enroll',
            'description' => 'Registrasi/update Face ID via halaman mahasiswa.',
            'ip_address' => $request->ip(),
            'user_agent' => (string) $request->userAgent(),
        ]);

        return response()->json(['message' => 'Data wajah berhasil disimpan.']);
    }

    public function scanBarcode(Request $request)
    {
        $validated = $request->validate([
            'session' => ['required', 'integer', 'exists:attendance_sessions,id'],
            'token' => ['nullable', 'string'],
            'email' => ['nullable', 'email'],
        ]);

        $session = AttendanceSession::with(['mataKuliah', 'kelas'])
            ->where('id', $validated['session'])
            ->where('method', 'barcode')
            ->first();

        if (!$session) {
            return view('mahasiswa.barcode_scan', [
                'sessionData' => null,
                'scanParams' => $validated,
                'statusType' => 'danger',
                'statusMessage' => 'Sesi barcode tidak valid.',
            ]);
        }

        [$statusType, $statusMessage] = $this->validateBarcodeSessionForDateAndStatus($session);

        return view('mahasiswa.barcode_scan', [
            'sessionData' => $session,
            'scanParams' => $validated,
            'statusType' => $statusType,
            'statusMessage' => $statusMessage,
        ]);
    }

    public function submitBarcodeScan(Request $request)
    {
        $validated = $request->validate([
            'session' => ['required', 'integer', 'exists:attendance_sessions,id'],
            'token' => ['required', 'string'],
            'email' => ['required', 'email'],
        ]);

        $session = AttendanceSession::with(['mataKuliah', 'kelas'])
            ->where('id', $validated['session'])
            ->where('method', 'barcode')
            ->first();

        if (!$session) {
            return redirect()
                ->route('mahasiswa.sessions.scan', $validated)
                ->with('error', 'Sesi barcode tidak valid.');
        }

        if ($validated['token'] !== (string) $session->barcode_token) {
            return redirect()
                ->route('mahasiswa.sessions.scan', ['session' => $validated['session']])
                ->with('error', 'Token barcode tidak sesuai.');
        }

        $user = User::with('mahasiswa')
            ->where('email', $validated['email'])
            ->where('role', 'mahasiswa')
            ->first();

        if (!$user || !$user->mahasiswa) {
            return redirect()
                ->route('mahasiswa.sessions.scan', ['session' => $validated['session']])
                ->with('error', 'Email mahasiswa tidak ditemukan.');
        }

        [$statusType, $statusMessage] = $this->validateBarcodeSessionForMahasiswa($session, $user->mahasiswa);
        if ($statusType !== 'success') {
            return redirect()
                ->route('mahasiswa.sessions.scan', ['session' => $validated['session']])
                ->with('error', $statusMessage);
        }

        try {
            $status = $this->resolveStatusBySessionTime($session);
            Absensi::create([
                'attendance_session_id' => $session->id,
                'mahasiswa_id' => $user->mahasiswa->id,
                'mata_kuliah_id' => $session->mata_kuliah_id,
                'tanggal' => $session->session_date->format('Y-m-d'),
                'jam_masuk' => now()->format('H:i:s'),
                'status' => $status,
                'metode' => 'barcode',
                'verification_status' => 'auto_valid',
            ]);
        } catch (QueryException $e) {
            if (($e->errorInfo[0] ?? '') === '23000') {
                return redirect()
                    ->route('mahasiswa.sessions.scan', ['session' => $validated['session']])
                    ->with('error', 'Anda sudah absen untuk mata kuliah ini hari ini.');
            }
            throw $e;
        }

        ActivityLog::create([
            'user_id' => $user->id,
            'activity_type' => 'barcode_scan_success',
            'description' => 'Absensi barcode berhasil untuk MK: ' . optional($session->mataKuliah)->nama_mk,
            'ip_address' => $request->ip(),
            'user_agent' => (string) $request->userAgent(),
            'meta' => [
                'session_id' => $session->id,
                'mata_kuliah_id' => $session->mata_kuliah_id,
            ],
        ]);

        return redirect()
            ->route('mahasiswa.sessions.scan', ['session' => $validated['session']])
            ->with('success', 'Absensi barcode berhasil dicatat.');
    }

    private function validateBarcodeSessionForDateAndStatus(AttendanceSession $session): array
    {
        if (!$session->is_active) {
            return ['danger', 'Sesi barcode sudah ditutup.'];
        }

        if ($session->session_date->format('Y-m-d') !== now()->toDateString()) {
            return ['danger', 'Sesi barcode tidak berlaku untuk hari ini.'];
        }

        return ['info', 'Masukkan token barcode dan email mahasiswa untuk verifikasi absensi.'];
    }

    private function validateBarcodeSessionForMahasiswa(AttendanceSession $session, $mahasiswa): array
    {
        [$type, $message] = $this->validateBarcodeSessionForDateAndStatus($session);
        if ($type !== 'info') {
            return [$type, $message];
        }

        if (Schema::hasTable('mahasiswa_mata_kuliah')) {
            $isTakingCourse = $mahasiswa->mataKuliahs()
                ->where('mata_kuliah.id', $session->mata_kuliah_id)
                ->exists();
            if (!$isTakingCourse) {
                return ['danger', 'Anda tidak terdaftar pada mata kuliah ini.'];
            }
        } elseif ($session->kelas_id !== $mahasiswa->kelas_id) {
            return ['danger', 'Sesi ini bukan untuk kelas Anda.'];
        }

        return ['success', 'Data valid. Absensi bisa diverifikasi.'];
    }

    private function resolveStatusBySessionTime(AttendanceSession $session): string
    {
        $endTime = $session->end_time ?: $session->start_time;
        if (!$endTime) {
            return 'hadir';
        }

        $endAt = Carbon::parse($session->session_date->format('Y-m-d') . ' ' . $endTime);

        return now()->greaterThan($endAt) ? 'telat' : 'hadir';
    }
}
