<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Absensi extends Model
{
    use HasFactory;

    protected $table = 'absensi';

    protected $fillable = [
        'mahasiswa_id',
        'mata_kuliah_id',
        'attendance_session_id',
        'tanggal',
        'jam_masuk',
        'status',
        'metode',
        'confidence',
        'snapshot_path',
        'verification_status',
        'verified_by_dosen',
        'verified_at',
    ];

    public function mahasiswa()
    {
        return $this->belongsTo(Mahasiswa::class);
    }

    public function mataKuliah()
    {
        return $this->belongsTo(MataKuliah::class);
    }

    public function faceLogs()
    {
        return $this->hasMany(FaceLog::class);
    }

    public function verifiedByDosen()
    {
        return $this->belongsTo(User::class, 'verified_by_dosen');
    }

    public function attendanceSession()
    {
        return $this->belongsTo(AttendanceSession::class);
    }
}
