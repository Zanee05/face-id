<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Traits\FaceRecognitionTrait;
use App\Models\Absensi;
use App\Models\AttendanceSession;
use App\Models\ActivityLog;
use App\Models\FaceData;
use App\Models\FaceLog;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class FaceRecognitionController extends Controller
{
    use FaceRecognitionTrait;

    public function register(Request $request)
    {
        $request->validate([
            'embedding' => ['required', 'array', 'size:128'],
            'embedding.*' => ['required', 'numeric'],
        ]);

        FaceData::updateOrCreate(
            ['user_id' => $request->user()->id],
            ['embedding' => $request->input('embedding')]
        );

        ActivityLog::create([
            'user_id' => $request->user()->id,
            'activity_type' => 'face_enroll',
            'description' => 'User melakukan pendaftaran/ubah data Face ID',
            'ip_address' => $request->ip(),
            'user_agent' => (string) $request->userAgent(),
        ]);

        return response()->json([
            'message' => 'Data wajah berhasil disimpan.',
        ]);
    }

    public function verifyAndAttend(Request $request)
    {
        $request->validate([
            'embedding' => ['required', 'array', 'size:128'],
            'embedding.*' => ['required', 'numeric'],
            'mata_kuliah_id' => ['required', 'exists:mata_kuliah,id'],
            'snapshot_base64' => ['nullable', 'string'],
        ]);

        $user = $request->user();
        $faceData = FaceData::where('user_id', $user->id)->first();

        if (!$faceData) {
            $this->storeFaceLog($user->id, null, 'failed', null, null, 'Data wajah belum diregistrasi.');
            return response()->json(['message' => 'Data wajah belum diregistrasi.'], 422);
        }

        if (!$user->mahasiswa) {
            return response()->json(['message' => 'Akun bukan mahasiswa.'], 422);
        }

        if (Schema::hasTable('mahasiswa_mata_kuliah')) {
            $isTakingCourse = $user->mahasiswa->mataKuliahs()
                ->where('mata_kuliah.id', $request->input('mata_kuliah_id'))
                ->exists();
            if (!$isTakingCourse) {
                return response()->json(['message' => 'Anda tidak terdaftar pada mata kuliah ini.'], 403);
            }
        }

        $distance = $this->calculateDistance(
            $request->input('embedding'),
            $faceData->embedding
        );

        $threshold = $this->getThreshold();
        $confidence = $this->calculateConfidence($distance, $threshold);
        
        $validation = $this->validateFaceRecognition($distance, $confidence);
        
        if (!$validation['valid']) {
            $this->storeFaceLog($user->id, null, 'failed', $distance, $confidence, $validation['reason']);

            ActivityLog::create([
                'user_id' => $user->id,
                'activity_type' => 'face_scan_failed',
                'description' => 'Scan wajah gagal: ' . $validation['reason'],
                'ip_address' => $request->ip(),
                'user_agent' => (string) $request->userAgent(),
                'meta' => ['distance' => $distance, 'confidence' => $confidence, 'code' => $validation['code']],
            ]);

            return response()->json([
                'message' => $validation['reason'],
                'distance' => $distance,
                'confidence' => $confidence,
            ], 401);
        }

        $sudahAbsen = Absensi::where('mahasiswa_id', $user->mahasiswa->id)
            ->where('mata_kuliah_id', $request->input('mata_kuliah_id'))
            ->whereDate('tanggal', now()->toDateString())
            ->exists();

        if ($sudahAbsen) {
            return response()->json(['message' => 'Anda sudah absen hari ini.'], 409);
        }

        // Mencoba mencari sesi aktif untuk menentukan status terlambat secara dinamis
        $session = AttendanceSession::where('mata_kuliah_id', $request->input('mata_kuliah_id'))
            ->where('is_active', true)
            ->where('session_date', now()->toDateString())
            ->first();

        $status = $session ? $this->resolveStatusBySessionTime($session) : 'hadir';

        $absensi = Absensi::create([
            'mahasiswa_id' => $user->mahasiswa->id,
            'mata_kuliah_id' => $request->input('mata_kuliah_id'),
            'tanggal' => now()->toDateString(),
            'jam_masuk' => now()->format('H:i:s'),
            'status' => $status,
            'metode' => 'face_id',
            'confidence' => $confidence,
            'snapshot_path' => $this->saveSnapshotIfProvided($request->input('snapshot_base64'), $user->id),
            'verification_status' => 'auto_valid',
        ]);

        $this->storeFaceLog($user->id, $absensi->id, 'success', $distance, $confidence, 'Wajah cocok, absensi tersimpan.');

        ActivityLog::create([
            'user_id' => $user->id,
            'activity_type' => 'absensi_sukses',
            'description' => 'Absensi berhasil via Face ID.',
            'ip_address' => $request->ip(),
            'user_agent' => (string) $request->userAgent(),
            'meta' => ['absensi_id' => $absensi->id, 'distance' => $distance],
        ]);

        return response()->json([
            'message' => 'Absensi berhasil.',
            'distance' => $distance,
            'confidence' => $confidence,
        ]);
    }

    public function verifySessionFace(Request $request, AttendanceSession $session)
    {
        $request->validate([
            'embedding' => ['required', 'array', 'size:128'],
            'embedding.*' => ['required', 'numeric'],
            'snapshot_base64' => ['nullable', 'string'],
        ]);

        $user = $request->user();
        $mahasiswa = $user->mahasiswa;
        if (!$mahasiswa) {
            return response()->json(['message' => 'Sesi tidak valid untuk mahasiswa ini.'], 403);
        }

        if (Schema::hasTable('mahasiswa_mata_kuliah')) {
            $isTakingCourse = $mahasiswa->mataKuliahs()
                ->where('mata_kuliah.id', $session->mata_kuliah_id)
                ->exists();
            if (!$isTakingCourse) {
                return response()->json(['message' => 'Anda tidak mengambil mata kuliah pada sesi ini.'], 403);
            }
        } elseif ($session->kelas_id !== $mahasiswa->kelas_id) {
            return response()->json(['message' => 'Sesi tidak valid untuk mahasiswa ini.'], 403);
        }

        if (!$session->is_active || $session->method !== 'faceid') {
            return response()->json(['message' => 'Sesi Face ID tidak aktif.'], 422);
        }
        if ($this->isSessionEnded($session)) {
            return response()->json(['message' => 'Waktu absensi sudah berakhir'], 422);
        }

        $faceData = FaceData::where('user_id', $user->id)->first();
        if (!$faceData) {
            $this->storeFaceLog($user->id, null, 'failed', null, null, 'Data wajah belum diregistrasi.');
            return response()->json(['message' => 'Data wajah belum diregistrasi.'], 422);
        }

        $tanggalSesi = $session->session_date->format('Y-m-d');
        $sudahAbsenHarian = Absensi::where('mahasiswa_id', $mahasiswa->id)
            ->where('mata_kuliah_id', $session->mata_kuliah_id)
            ->whereDate('tanggal', $tanggalSesi)
            ->exists();
        if ($sudahAbsenHarian) {
            return response()->json(['message' => 'Anda sudah absen untuk mata kuliah ini pada tanggal tersebut.'], 409);
        }

        $distance = $this->calculateDistance($request->embedding, $faceData->embedding);
        $threshold = $this->getThreshold();
        $confidence = $this->calculateConfidence($distance, $threshold);
        
        $validation = $this->validateFaceRecognition($distance, $confidence);
        
        if (!$validation['valid']) {
            $this->storeFaceLog($user->id, null, 'failed', $distance, $confidence, $validation['reason']);
            return response()->json([
                'message' => $validation['reason'],
                'distance' => $distance,
                'confidence' => $confidence
            ], 401);
        }

        try {
            $absensi = Absensi::create([
                'attendance_session_id' => $session->id,
                'mahasiswa_id' => $mahasiswa->id,
                'mata_kuliah_id' => $session->mata_kuliah_id,
                'tanggal' => $tanggalSesi,
                'jam_masuk' => now()->format('H:i:s'),
                'status' => $this->resolveStatusBySessionTime($session),
                'metode' => 'faceid',
                'confidence' => $confidence,
                'snapshot_path' => $this->saveSnapshotIfProvided($request->input('snapshot_base64'), $user->id),
                'verification_status' => 'auto_valid',
            ]);
        } catch (QueryException $e) {
            $sqlState = $e->errorInfo[0] ?? '';
            if ($sqlState === '23000' && str_contains((string) $e->getMessage(), 'uniq_absensi_harian')) {
                return response()->json(['message' => 'Anda sudah absen untuk mata kuliah ini pada tanggal tersebut.'], 409);
            }
            throw $e;
        }

        $this->storeFaceLog($user->id, $absensi->id, 'success', $distance, $confidence, 'Face ID session check-in berhasil.');

        return response()->json([
            'message' => 'Absensi Face ID berhasil.',
            'distance' => $distance,
            'confidence' => $confidence,
        ]);
    }

    public function scanBarcode(Request $request)
    {
        $request->validate([
            'barcode_token' => ['required', 'string'],
        ]);

        $user = $request->user();
        $mahasiswa = $user->mahasiswa;

        if (!$mahasiswa) {
            return response()->json(['message' => 'Akun bukan mahasiswa.'], 422);
        }

        // Cari sesi barcode yang aktif berdasarkan token
        $session = AttendanceSession::where('barcode_token', $request->barcode_token)
            ->where('is_active', true)
            ->where('method', 'barcode')
            ->first();

        if (!$session) {
            return response()->json(['message' => 'Sesi barcode tidak valid atau sudah ditutup.'], 404);
        }

        if ($session->session_date->format('Y-m-d') !== now()->toDateString()) {
            return response()->json(['message' => 'Sesi ini tidak berlaku untuk hari ini.'], 422);
        }
        if ($this->isSessionEnded($session)) {
            return response()->json(['message' => 'Waktu absensi sudah berakhir'], 422);
        }

        // Verifikasi apakah mahasiswa berhak mengikuti sesi ini
        if (Schema::hasTable('mahasiswa_mata_kuliah')) {
            $isTakingCourse = $mahasiswa->mataKuliahs()
                ->where('mata_kuliah.id', $session->mata_kuliah_id)
                ->exists();
            if (!$isTakingCourse) {
                return response()->json(['message' => 'Anda tidak terdaftar pada mata kuliah ini.'], 403);
            }
        } elseif ($session->kelas_id !== $mahasiswa->kelas_id) {
            return response()->json(['message' => 'Sesi ini bukan untuk kelas Anda.'], 403);
        }

        try {
            $status = $this->resolveStatusBySessionTime($session);

            $absensi = Absensi::create([
                'attendance_session_id' => $session->id,
                'mahasiswa_id' => $mahasiswa->id,
                'mata_kuliah_id' => $session->mata_kuliah_id,
                'tanggal' => $session->session_date->format('Y-m-d'),
                'jam_masuk' => now()->format('H:i:s'),
                'status' => $status,
                'metode' => 'barcode',
                'verification_status' => 'auto_valid',
            ]);

            ActivityLog::create([
                'user_id' => $user->id,
                'activity_type' => 'barcode_scan_success',
                'description' => "Absensi barcode berhasil untuk MK: {$session->mataKuliah->nama_mk}",
                'ip_address' => $request->ip(),
                'user_agent' => (string) $request->userAgent(),
            ]);

            return response()->json(['message' => 'Absensi barcode berhasil.', 'status' => $status]);
        } catch (QueryException $e) {
            if (($e->errorInfo[0] ?? '') === '23000') {
                return response()->json(['message' => 'Anda sudah melakukan absensi untuk mata kuliah ini hari ini.'], 409);
            }
            throw $e;
        }
    }

    private function storeFaceLog(
        int $userId,
        ?int $absensiId,
        string $status,
        ?float $distance,
        ?float $confidence,
        string $message
    ): void {
        FaceLog::create([
            'user_id' => $userId,
            'absensi_id' => $absensiId,
            'status' => $status,
            'distance' => $distance,
            'confidence' => $confidence,
            'message' => $message,
        ]);
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

    private function isSessionEnded(AttendanceSession $session): bool
    {
        $endTime = $session->end_time ?: $session->start_time;
        if (!$endTime) {
            return false;
        }

        $endAt = Carbon::parse($session->session_date->format('Y-m-d') . ' ' . $endTime);

        return now()->greaterThan($endAt);
    }

    private function saveSnapshotIfProvided(?string $snapshotBase64, int $userId): ?string
    {
        if (!$snapshotBase64) {
            return null;
        }

        $normalized = $snapshotBase64;
        if (str_contains($snapshotBase64, ',')) {
            $parts = explode(',', $snapshotBase64, 2);
            $normalized = $parts[1] ?? '';
        }

        $binary = base64_decode($normalized, true);
        if ($binary === false) {
            return null;
        }

        $fileName = $userId . '_' . now()->format('Ymd_His') . '_' . Str::random(6) . '.jpg';
        $relativePath = 'snapshots/' . $fileName;
        Storage::disk('public')->put($relativePath, $binary);

        return 'storage/' . $relativePath;
    }
}
