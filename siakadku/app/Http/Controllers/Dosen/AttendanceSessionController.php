<?php

namespace App\Http\Controllers\Dosen;

use App\Http\Controllers\Controller;
use App\Traits\FaceRecognitionTrait;
use App\Models\Absensi;
use App\Models\ActivityLog;
use App\Models\AttendanceSession;
use App\Models\FaceLog;
use App\Models\JadwalKelas;
use App\Models\Kelas;
use App\Models\Mahasiswa;
use App\Models\MataKuliah;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class AttendanceSessionController extends Controller
{
    use FaceRecognitionTrait;

    private function getDosenOrAbort()
    {
        $dosen = auth()->user()->dosen;
        abort_if(!$dosen, 422, 'Profil dosen belum terdaftar. Hubungi admin untuk melengkapi data dosen.');

        return $dosen;
    }

    public function index()
    {
        $dosen = $this->getDosenOrAbort();
        $sessions = AttendanceSession::with(['kelas', 'mataKuliah'])
            ->where('dosen_id', $dosen->id)
            ->latest()
            ->paginate(10);

        return view('dosen.sessions.index', compact('sessions'));
    }

    public function create()
    {
        $dosen = $this->getDosenOrAbort();
        $mataKuliah = MataKuliah::where('dosen_id', $dosen->id)->orderBy('nama_mk')->get();
        $kelas = Kelas::orderBy('nama_kelas')->get();

        return view('dosen.sessions.create', compact('mataKuliah', 'kelas'));
    }

    public function store(Request $request)
    {
        $dosen = $this->getDosenOrAbort();
        $validated = $request->validate([
            'kelas_id' => 'required|exists:kelas,id',
            'mata_kuliah_id' => 'required|exists:mata_kuliah,id',
            'method' => 'required|in:manual,barcode,faceid',
            'session_date' => 'required|date',
            'start_time' => 'nullable|date_format:H:i',
            'end_time' => 'nullable|date_format:H:i',
            'use_jadwal_time' => 'nullable|in:0,1',
        ]);

        $useJadwalTime = ($validated['use_jadwal_time'] ?? '1') === '1';

        $resolvedStart = $validated['start_time'] ?? null;
        $resolvedEnd = $validated['end_time'] ?? null;

        if ($useJadwalTime) {
            $hari = $this->toHari(Carbon::parse($validated['session_date']));
            $jadwal = JadwalKelas::query()
                ->where('kelas_id', $validated['kelas_id'])
                ->where('mata_kuliah_id', $validated['mata_kuliah_id'])
                ->where('hari', $hari)
                ->orderBy('jam_mulai')
                ->first();

            if ($jadwal) {
                $resolvedStart = substr((string) $jadwal->jam_mulai, 0, 5);
                $resolvedEnd = substr((string) $jadwal->jam_selesai, 0, 5);
            }
        }

        if (!$resolvedStart || !$resolvedEnd) {
            throw ValidationException::withMessages([
                'start_time' => 'Jam mulai/jam selesai belum terisi. Pastikan jadwal untuk hari tersebut tersedia, atau isi manual.',
            ]);
        }

        if ($resolvedEnd <= $resolvedStart) {
            throw ValidationException::withMessages([
                'end_time' => 'Jam selesai harus setelah jam mulai.',
            ]);
        }

        $session = AttendanceSession::create([
            'dosen_id' => $dosen->id,
            'kelas_id' => $validated['kelas_id'],
            'mata_kuliah_id' => $validated['mata_kuliah_id'],
            'method' => $validated['method'],
            'session_date' => $validated['session_date'],
            'start_time' => $resolvedStart,
            'end_time' => $resolvedEnd,
            'barcode_token' => $validated['method'] === 'barcode' ? Str::upper(Str::random(10)) : null,
            'is_active' => true,
        ]);

        return redirect()->route('dosen.sessions.show', $session)->with('success', 'Sesi absensi berhasil dibuat.');
    }

    public function show(Request $request, AttendanceSession $session)
    {
        $dosen = $this->getDosenOrAbort();
        abort_if($session->dosen_id !== $dosen->id, 403);
        $session->load(['kelas', 'mataKuliah', 'absensi.mahasiswa']);

        $mahasiswaKandidat = $this->mahasiswaKandidatForSession($session);
        $absensiByMahasiswa = $session->absensi->keyBy('mahasiswa_id');
        $mahasiswaBukanHadir = $mahasiswaKandidat->filter(function ($m) use ($absensiByMahasiswa) {
            $st = optional($absensiByMahasiswa->get($m->id))->status;

            return $st !== 'hadir';
        });

        // Deteksi base URL LAN otomatis — bekerja meski IP laptop berubah-ubah
        $lanBase = \App\Helpers\ServerHelper::getLanBaseUrl($request);
        $barcodePublicUrl = $lanBase . route('mahasiswa.sessions.scan', [
            'session' => $session->id,
            'token'   => $session->barcode_token,
        ], false);

        // Jika request AJAX (dari tombol Refresh QR di view), kembalikan JSON
        if ($request->ajax() || $request->wantsJson()) {
            return response()->json(['barcode_url' => $barcodePublicUrl]);
        }

        return view('dosen.sessions.show', compact(
            'session', 'mahasiswaKandidat', 'absensiByMahasiswa', 'mahasiswaBukanHadir', 'barcodePublicUrl'
        ));
    }

    /**
     * Simpan mahasiswa yang dicentang sebagai Hadir (tepat waktu). Yang tidak dicentang: hapus record jika sebelumnya Hadir,
     * agar bisa diklasifikasi lewat aksi Izin/Sakit/Alpha/Telat.
     */
    public function storeManualHadir(Request $request, AttendanceSession $session)
    {
        $dosen = $this->getDosenOrAbort();
        abort_if($session->dosen_id !== $dosen->id, 403);
        abort_if($session->method !== 'manual', 422, 'Absensi manual hanya untuk sesi ber-metode manual.');
        abort_if(!$session->is_active, 422, 'Sesi sudah ditutup.');

        $allowedIds = $this->mahasiswaKandidatForSession($session)->pluck('id')->map(function ($id) {
            return (int) $id;
        })->all();
        if (empty($allowedIds)) {
            return back()->with('error', 'Tidak ada mahasiswa untuk kelas/mata kuliah ini. Pastikan mahasiswa sudah mengambil MK (susun mata kuliah) atau data kelas terisi.');
        }

        $hadirIds = collect($request->input('hadir', []))->map(function ($id) {
            return (int) $id;
        })->unique()->values()->all();
        foreach ($hadirIds as $id) {
            if (!in_array($id, $allowedIds, true)) {
                abort(422, 'Data mahasiswa tidak valid untuk sesi ini.');
            }
        }

        $tanggal = $session->session_date->format('Y-m-d');

        foreach ($hadirIds as $mid) {
            Absensi::updateOrCreate(
                [
                    'mahasiswa_id' => $mid,
                    'mata_kuliah_id' => $session->mata_kuliah_id,
                    'tanggal' => $tanggal,
                ],
                [
                    'attendance_session_id' => $session->id,
                    'jam_masuk' => now()->format('H:i:s'),
                    'status' => 'hadir',
                    'metode' => 'manual',
                    'confidence' => null,
                    'verification_status' => 'approved',
                    'verified_by_dosen' => auth()->id(),
                    'verified_at' => now(),
                ]
            );
        }

        foreach ($allowedIds as $mid) {
            if (in_array($mid, $hadirIds, true)) {
                continue;
            }
            $row = Absensi::where('mahasiswa_id', $mid)
                ->where('mata_kuliah_id', $session->mata_kuliah_id)
                ->where('tanggal', $tanggal)
                ->first();
            if ($row && $row->status === 'hadir') {
                $row->delete();
            }
        }

        ActivityLog::create([
            'user_id' => auth()->id(),
            'activity_type' => 'dosen_manual_hadir',
            'description' => 'Dosen menyimpan absensi manual (ceklis hadir) untuk sesi #' . $session->id,
            'ip_address' => $request->ip(),
            'user_agent' => (string) $request->userAgent(),
        ]);

        return back()->with('success', 'Kehadiran (hadir) berhasil disimpan. Untuk yang tidak dicentang, atur status di bawah.');
    }

    /**
     * Set status untuk mahasiswa yang bukan Hadir: izin, sakit, tidak_hadir (alpha), telat.
     */
    public function storeManualStatus(Request $request, AttendanceSession $session)
    {
        $dosen = $this->getDosenOrAbort();
        abort_if($session->dosen_id !== $dosen->id, 403);
        abort_if($session->method !== 'manual', 422);
        abort_if(!$session->is_active, 422, 'Sesi sudah ditutup.');

        $allowedIds = $this->mahasiswaKandidatForSession($session)->pluck('id')->map(function ($id) {
            return (int) $id;
        })->all();
        $validated = $request->validate([
            'mahasiswa_id' => 'required|integer',
            'status' => 'required|in:izin,sakit,tidak_hadir,telat',
        ]);

        $mid = (int) $validated['mahasiswa_id'];
        if (!in_array($mid, $allowedIds, true)) {
            abort(422, 'Mahasiswa tidak valid untuk sesi ini.');
        }

        $status = $validated['status'];
        $jamMasuk = $status === 'telat' ? now()->format('H:i:s') : null;

        Absensi::updateOrCreate(
            [
                'mahasiswa_id' => $mid,
                'mata_kuliah_id' => $session->mata_kuliah_id,
                'tanggal' => $session->session_date->format('Y-m-d'),
            ],
            [
                'attendance_session_id' => $session->id,
                'jam_masuk' => $jamMasuk,
                'status' => $status,
                'metode' => 'manual',
                'confidence' => null,
                'verification_status' => 'approved',
                'verified_by_dosen' => auth()->id(),
                'verified_at' => now(),
            ]
        );

        ActivityLog::create([
            'user_id' => auth()->id(),
            'activity_type' => 'dosen_manual_status',
            'description' => 'Dosen set status absensi manual ' . $status . ' untuk mahasiswa #' . $mid . ' (sesi #' . $session->id . ')',
            'ip_address' => $request->ip(),
            'user_agent' => (string) $request->userAgent(),
        ]);

        return back()->with('success', 'Status kehadiran berhasil disimpan.');
    }

    public function close(AttendanceSession $session)
    {
        $dosen = $this->getDosenOrAbort();
        abort_if($session->dosen_id !== $dosen->id, 403);
        $session->update(['is_active' => false]);

        return back()->with('success', 'Sesi absensi ditutup.');
    }

    public function kiosk(AttendanceSession $session)
    {
        $dosen = $this->getDosenOrAbort();
        abort_if($session->dosen_id !== $dosen->id, 403);
        abort_if($session->method !== 'faceid', 422, 'Kiosk hanya untuk sesi Face ID.');

        $session->load(['absensi.mahasiswa']);
        $mahasiswaKandidat = $this->mahasiswaKandidatForSession($session);
        $hadirNames = $session->absensi
            ->map(function ($item) {
                return optional($item->mahasiswa)->nama;
            })
            ->filter()
            ->values();

        return view('dosen.sessions.kiosk', compact('session', 'mahasiswaKandidat', 'hadirNames'));
    }

    public function identifyFace(Request $request, AttendanceSession $session)
    {
        $dosen = $this->getDosenOrAbort();
        abort_if($session->dosen_id !== $dosen->id, 403);
        abort_if($session->method !== 'faceid' || !$session->is_active, 422, 'Sesi Face ID tidak aktif.');

        $request->validate([
            'embedding' => ['required', 'array', 'size:128'],
            'embedding.*' => ['required', 'numeric'],
        ]);

        $candidatesQuery = Mahasiswa::with('user.faceData');
        if (Schema::hasTable('mahasiswa_mata_kuliah')) {
            $candidatesQuery->whereHas('mataKuliahs', function ($query) use ($session) {
                $query->where('mata_kuliah.id', $session->mata_kuliah_id);
            });
        } else {
            $candidatesQuery->where('kelas_id', $session->kelas_id);
        }
        $candidates = $candidatesQuery->get();
        if ($candidates->isEmpty()) {
            return response()->json([
                'message' => 'Belum ada mahasiswa kandidat untuk sesi ini. Pastikan mahasiswa mengambil mata kuliah ini.',
                'confidence' => 0,
            ], 422);
        }

        $registeredFaceCount = 0;
        $bestMahasiswa = null;
        $bestDistance = null;
        foreach ($candidates as $mhs) {
            $faceData = optional($mhs->user)->faceData;
            if (!$faceData || !is_array($faceData->embedding)) {
                continue;
            }
            $registeredFaceCount++;
            $distance = $this->calculateDistance($request->embedding, $faceData->embedding);
            if ($bestDistance === null || $distance < $bestDistance) {
                $bestDistance = $distance;
                $bestMahasiswa = $mhs;
            }
        }
        if ($registeredFaceCount === 0) {
            return response()->json([
                'message' => 'Belum ada data wajah mahasiswa yang terdaftar untuk sesi ini.',
                'confidence' => 0,
            ], 422);
        }

        $threshold  = $this->getThreshold();
        $confidence = $bestDistance === null ? 0.0 : $this->calculateConfidence($bestDistance, $threshold);
        $validation = $this->validateFaceRecognition($bestDistance ?? INF, $confidence);

        // Log ke face_logs agar bisa dimonitor
        \App\Models\FaceLog::create([
            'user_id'    => optional(optional($bestMahasiswa)->user)->id ?? auth()->id(),
            'absensi_id' => null,
            'status'     => $validation['valid'] ? 'success' : 'failed',
            'distance'   => $bestDistance,
            'confidence' => $confidence,
            'message'    => $validation['reason'] . ' (kiosk)',
        ]);

        if (!$bestMahasiswa || $bestDistance === null || !$validation['valid']) {
            return response()->json([
                'message'    => $validation['reason'] . ' Kandidat terdekat: ' . ($bestMahasiswa ? $bestMahasiswa->nama : '-') . '.',
                'confidence' => $confidence,
                'distance'   => round($bestDistance ?? 0, 4),
                'threshold'  => $threshold,
                'min_confidence' => $this->getMinConfidence(),
            ], 404);
        }

        $result = $this->storeOrLinkKioskAbsensi($session, $bestMahasiswa, $confidence);
        $absensi = $result['absensi'];

        if ($result['already_in_session']) {
            return response()->json([
                'message' => $bestMahasiswa->nama . ' sudah tercatat pada sesi ini.',
                'confidence' => $confidence,
                'recognized_name' => $bestMahasiswa->nama,
                'already_in_session' => true,
            ]);
        }

        FaceLog::create([
            'user_id' => $bestMahasiswa->user_id,
            'absensi_id' => $absensi->id,
            'status' => 'success',
            'distance' => $bestDistance,
            'confidence' => $confidence,
            'message' => 'Identifikasi kiosk Face ID oleh dosen.',
        ]);

        ActivityLog::create([
            'user_id' => auth()->id(),
            'activity_type' => 'kiosk_face_checkin',
            'description' => 'Dosen melakukan check-in Face ID kiosk untuk ' . $bestMahasiswa->nama,
            'ip_address' => $request->ip(),
            'user_agent' => (string) $request->userAgent(),
        ]);

        return response()->json([
            'message' => 'Absensi berhasil untuk ' . $bestMahasiswa->nama,
            'confidence' => $confidence,
            'recognized_name' => $bestMahasiswa->nama,
            'already_in_session' => false,
        ]);
    }

    /**
     * Satu baris per mahasiswa+MK+tanggal (uniq_absensi_harian). Tautkan ke sesi kiosk agar muncul di daftar sesi.
     *
     * @return array{absensi: \App\Models\Absensi, already_in_session: bool}
     */
    private function storeOrLinkKioskAbsensi(AttendanceSession $session, Mahasiswa $mahasiswa, float $confidence): array
    {
        $tanggalSesi = $session->session_date->format('Y-m-d');
        $statusBaru = $this->resolveStatusBySessionTime($session);

        $existing = Absensi::where('mahasiswa_id', $mahasiswa->id)
            ->where('mata_kuliah_id', $session->mata_kuliah_id)
            ->whereDate('tanggal', $tanggalSesi)
            ->first();

        $payload = [
            'attendance_session_id' => $session->id,
            'jam_masuk' => now()->format('H:i:s'),
            'metode' => 'faceid',
            'confidence' => $confidence,
            'verification_status' => 'auto_valid',
        ];

        if ($existing) {
            if ((int) $existing->attendance_session_id === (int) $session->id) {
                return ['absensi' => $existing, 'already_in_session' => true];
            }
            if (!in_array($existing->status, ['izin', 'sakit'], true)) {
                $payload['status'] = $statusBaru;
            }
            $existing->update($payload);

            return ['absensi' => $existing->fresh(), 'already_in_session' => false];
        }

        try {
            $absensi = Absensi::create(array_merge($payload, [
                'mahasiswa_id' => $mahasiswa->id,
                'mata_kuliah_id' => $session->mata_kuliah_id,
                'tanggal' => $tanggalSesi,
                'status' => $statusBaru,
            ]));
        } catch (QueryException $e) {
            $sqlState = $e->errorInfo[0] ?? '';
            if ($sqlState === '23000' && str_contains((string) $e->getMessage(), 'uniq_absensi_harian')) {
                $row = Absensi::where('mahasiswa_id', $mahasiswa->id)
                    ->where('mata_kuliah_id', $session->mata_kuliah_id)
                    ->whereDate('tanggal', $tanggalSesi)
                    ->first();
                if (!$row) {
                    throw $e;
                }
                if ((int) $row->attendance_session_id === (int) $session->id) {
                    return ['absensi' => $row, 'already_in_session' => true];
                }
                if (!in_array($row->status, ['izin', 'sakit'], true)) {
                    $payload['status'] = $statusBaru;
                }
                $row->update($payload);

                return ['absensi' => $row->fresh(), 'already_in_session' => false];
            }
            throw $e;
        }

        return ['absensi' => $absensi, 'already_in_session' => false];
    }

    /**
     * Mahasiswa yang boleh diabsen di sesi ini (sama dengan logika kiosk Face ID).
     * Jika pivot susun MK ada: cukup yang sudah mengambil MK ini (tanpa memaksa kelas = kelas sesi),
     * agar konsisten dengan pilihan mahasiswa di menu susun mata kuliah.
     */
    private function mahasiswaKandidatForSession(AttendanceSession $session)
    {
        $query = Mahasiswa::query()->orderBy('nama');

        if (Schema::hasTable('mahasiswa_mata_kuliah')) {
            $query->whereHas('mataKuliahs', function ($q) use ($session) {
                $q->where('mata_kuliah.id', $session->mata_kuliah_id);
            });
        } else {
            $query->where('kelas_id', $session->kelas_id);
        }

        return $query->get();
    }

    public function jadwalTime(Request $request)
    {
        $dosen = $this->getDosenOrAbort();

        $validated = $request->validate([
            'kelas_id' => 'nullable|integer|exists:kelas,id',
            'mata_kuliah_id' => 'required|integer|exists:mata_kuliah,id',
            'session_date' => 'required|date',
        ]);

        // Pastikan mata kuliah ini memang milik dosen yang login
        $owns = MataKuliah::where('id', $validated['mata_kuliah_id'])
            ->where('dosen_id', $dosen->id)
            ->exists();
        abort_if(!$owns, 403);

        $hari = $this->toHari(Carbon::parse($validated['session_date']));
        $jadwal = JadwalKelas::query()
            ->where('mata_kuliah_id', $validated['mata_kuliah_id'])
            ->where('hari', $hari)
            ->when($validated['kelas_id'], function ($query, $kelasId) {
                return $query->where('kelas_id', $kelasId);
            })
            ->orderBy('jam_mulai')
            ->first();

        if (!$jadwal) {
            return response()->json([
                'found' => false,
                'hari' => $hari,
            ]);
        }

        return response()->json([
            'found'      => true,
            'hari'       => $hari,
            'kelas_id'   => $jadwal->kelas_id,
            'start_time' => substr((string) $jadwal->jam_mulai, 0, 5),
            'end_time'   => substr((string) $jadwal->jam_selesai, 0, 5),
        ]);
    }

    /**
     * Ambil semua jadwal untuk mata kuliah tertentu (tanpa perlu tanggal).
     * Digunakan saat dosen memilih mata kuliah di form buat sesi —
     * kelas, hari, dan jam langsung terisi otomatis.
     */
    public function jadwalByMataKuliah(Request $request)
    {
        $dosen = $this->getDosenOrAbort();

        $validated = $request->validate([
            'mata_kuliah_id' => 'required|integer|exists:mata_kuliah,id',
        ]);

        $owns = MataKuliah::where('id', $validated['mata_kuliah_id'])
            ->where('dosen_id', $dosen->id)
            ->exists();
        abort_if(!$owns, 403);

        $jadwalList = JadwalKelas::with('kelas')
            ->where('mata_kuliah_id', $validated['mata_kuliah_id'])
            ->orderBy('hari')
            ->orderBy('jam_mulai')
            ->get()
            ->map(function ($j) {
                return [
                    'kelas_id'   => $j->kelas_id,
                    'kelas_nama' => optional($j->kelas)->nama_kelas,
                    'hari'       => $j->hari,
                    'start_time' => substr((string) $j->jam_mulai, 0, 5),
                    'end_time'   => substr((string) $j->jam_selesai, 0, 5),
                ];
            });

        return response()->json([
            'found'   => $jadwalList->isNotEmpty(),
            'jadwal'  => $jadwalList->values(),
        ]);
    }

    private function toHari(Carbon $date): string
    {
        // Carbon: 0=Sunday ... 6=Saturday
        switch ($date->dayOfWeek) {
            case Carbon::MONDAY:
                return 'senin';
            case Carbon::TUESDAY:
                return 'selasa';
            case Carbon::WEDNESDAY:
                return 'rabu';
            case Carbon::THURSDAY:
                return 'kamis';
            case Carbon::FRIDAY:
                return 'jumat';
            case Carbon::SATURDAY:
                return 'sabtu';
            default:
                return 'minggu';
        }
    }

    private function resolveStatusBySessionTime(AttendanceSession $session): string
    {
        $now = now();
        $sessionDate = $session->session_date->format('Y-m-d');
        $endTime = $session->end_time ?: $session->start_time;

        if (!$endTime) {
            return 'hadir';
        }

        $endAt = Carbon::parse($sessionDate . ' ' . $endTime);

        return $now->greaterThan($endAt) ? 'telat' : 'hadir';
    }
}