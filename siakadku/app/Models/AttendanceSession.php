<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AttendanceSession extends Model
{
    use HasFactory;

    protected $table = 'attendance_sessions';

    protected $fillable = [
        'dosen_id',
        'kelas_id',
        'mata_kuliah_id',
        'method',
        'session_date',
        'start_time',
        'end_time',
        'barcode_token',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'session_date' => 'date',
    ];

    public function dosen()
    {
        return $this->belongsTo(Dosen::class);
    }

    public function kelas()
    {
        return $this->belongsTo(Kelas::class);
    }

    public function mataKuliah()
    {
        return $this->belongsTo(MataKuliah::class);
    }

    public function absensi()
    {
        return $this->hasMany(Absensi::class);
    }
}
