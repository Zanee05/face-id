<?php

use App\Http\Controllers\Admin\DosenController as AdminDosenController;
use App\Http\Controllers\Admin\DashboardController as AdminDashboardController;
use App\Http\Controllers\Admin\JadwalKelasController as AdminJadwalKelasController;
use App\Http\Controllers\Admin\KelasController as AdminKelasController;
use App\Http\Controllers\Admin\MahasiswaController as AdminMahasiswaController;
use App\Http\Controllers\Admin\MataKuliahController as AdminMataKuliahController;
use App\Http\Controllers\Admin\UserController as AdminUserController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\Dosen\DashboardController as DosenDashboardController;
use App\Http\Controllers\Dosen\AbsensiController as DosenAbsensiController;
use App\Http\Controllers\Dosen\AttendanceSessionController as DosenAttendanceSessionController;
use App\Http\Controllers\Mahasiswa\DashboardController as MahasiswaDashboardController;
use App\Http\Controllers\Mahasiswa\AbsensiController as MahasiswaAbsensiController;
use App\Http\Controllers\Mahasiswa\MataKuliahController as MahasiswaMataKuliahController;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return redirect()->route('login');
});

Auth::routes();

Route::get('/mahasiswa/sessions', [MahasiswaAbsensiController::class, 'scanBarcode'])->name('mahasiswa.sessions.scan');
Route::post('/mahasiswa/sessions', [MahasiswaAbsensiController::class, 'submitBarcodeScan'])->name('mahasiswa.sessions.submit');

Route::middleware('auth')->group(function () {
    Route::get('/home', fn () => redirect()->route('dashboard'))->name('home');
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

    // ─── Tool: normalisasi semua embedding (admin only, hapus setelah dipakai) ───
    Route::get('/admin/tools/normalize-embeddings', function () {
        abort_if(auth()->user()->role !== 'admin', 403);

        $faceDataList = \App\Models\FaceData::all();
        $count = 0;

        foreach ($faceDataList as $fd) {
            $emb = $fd->embedding;
            if (!is_array($emb) || count($emb) !== 128) continue;

            // Hitung magnitude
            $ss  = array_sum(array_map(fn($v) => $v * $v, $emb));
            $mag = sqrt($ss);
            if ($mag < 1e-10) continue;

            // Sudah ternormalisasi jika magnitude ≈ 1
            if (abs($mag - 1.0) < 0.01) continue;

            $fd->embedding = array_map(fn($v) => $v / $mag, $emb);
            $fd->save();
            $count++;
        }

        return response()->json([
            'status'     => 'ok',
            'normalized' => $count,
            'total'      => $faceDataList->count(),
            'message'    => "Berhasil normalisasi {$count} dari {$faceDataList->count()} data wajah.",
        ]);
    })->name('admin.tools.normalize-embeddings');

    Route::middleware('role:admin')->prefix('admin')->name('admin.')->group(function () {
        Route::get('/dashboard', [AdminDashboardController::class, 'index'])->name('dashboard');
        Route::get('/monitoring/absensi-live', [AdminDashboardController::class, 'monitoringAbsensi'])->name('monitoring.absensi');
        Route::post('/face-data/reset/{user}', [AdminDashboardController::class, 'resetFaceData'])->name('face-data.reset');
        Route::post('/face-data/normalize-all', [AdminDashboardController::class, 'normalizeEmbeddings'])->name('face-data.normalize');
        Route::resource('users', AdminUserController::class)->except(['show']);
        Route::resource('mahasiswa', AdminMahasiswaController::class);
        Route::resource('dosen', AdminDosenController::class);
        Route::resource('kelas', AdminKelasController::class);
        Route::resource('mata-kuliah', AdminMataKuliahController::class);
        Route::resource('jadwal', AdminJadwalKelasController::class);
    });

    Route::middleware('role:dosen')->prefix('dosen')->name('dosen.')->group(function () {
        Route::get('/dashboard', [DosenDashboardController::class, 'index'])->name('dashboard');
        Route::get('/absensi', [DosenAbsensiController::class, 'index'])->name('absensi.index');
        Route::get('/absensi/rekap', [DosenAbsensiController::class, 'rekapHarian'])->name('absensi.rekap');
        Route::get('/absensi/rekap/export', [DosenAbsensiController::class, 'exportRekap'])->name('absensi.rekap.export');
        Route::post('/absensi/{absensi}/verify', [DosenAbsensiController::class, 'verify'])->name('absensi.verify');
        Route::get('/sessions', [DosenAttendanceSessionController::class, 'index'])->name('sessions.index');
        Route::get('/sessions/create', [DosenAttendanceSessionController::class, 'create'])->name('sessions.create');
        Route::get('/sessions/jadwal-time', [DosenAttendanceSessionController::class, 'jadwalTime'])->name('sessions.jadwal-time');
        Route::get('/sessions/jadwal-by-mk', [DosenAttendanceSessionController::class, 'jadwalByMataKuliah'])->name('sessions.jadwal-by-mk');
        Route::post('/sessions', [DosenAttendanceSessionController::class, 'store'])->name('sessions.store');
        Route::get('/sessions/{session}', [DosenAttendanceSessionController::class, 'show'])->name('sessions.show');
        Route::post('/sessions/{session}/manual-hadir', [DosenAttendanceSessionController::class, 'storeManualHadir'])->name('sessions.manual-hadir');
        Route::post('/sessions/{session}/manual-status', [DosenAttendanceSessionController::class, 'storeManualStatus'])->name('sessions.manual-status');
        Route::post('/sessions/{session}/close', [DosenAttendanceSessionController::class, 'close'])->name('sessions.close');
        Route::get('/sessions/{session}/kiosk', [DosenAttendanceSessionController::class, 'kiosk'])->name('sessions.kiosk');
        Route::post('/sessions/{session}/identify-face', [DosenAttendanceSessionController::class, 'identifyFace'])->name('sessions.identify-face');
    });

    Route::middleware('role:mahasiswa')->prefix('mahasiswa')->name('mahasiswa.')->group(function () {
        Route::get('/dashboard', [MahasiswaDashboardController::class, 'index'])->name('dashboard');
        Route::get('/absensi', [MahasiswaAbsensiController::class, 'index'])->name('absensi.index');
        Route::get('/rekap-absensi', [MahasiswaAbsensiController::class, 'rekap'])->name('absensi.rekap');
        Route::post('/absensi/register-face', [MahasiswaAbsensiController::class, 'store'])->name('absensi.register-face');
        Route::get('/mata-kuliah', [MahasiswaMataKuliahController::class, 'index'])->name('mata-kuliah.index');
        Route::post('/mata-kuliah', [MahasiswaMataKuliahController::class, 'update'])->name('mata-kuliah.update');
    });
});
