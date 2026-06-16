<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mahasiswa extends Model
{
    use HasFactory;

    protected $table = 'mahasiswa';

    protected $fillable = [
        'user_id',
        'kelas_id',
        'nim',
        'nama',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function kelas()
    {
        return $this->belongsTo(Kelas::class);
    }

    public function absensi()
    {
        return $this->hasMany(Absensi::class);
    }

    public function attendanceSessions()
    {
        return $this->hasManyThrough(
            AttendanceSession::class,
            Kelas::class,
            'id',
            'kelas_id',
            'kelas_id',
            'id'
        );
    }

    public function mataKuliahs()
    {
        return $this->belongsToMany(
            MataKuliah::class,
            'mahasiswa_mata_kuliah',
            'mahasiswa_id',
            'mata_kuliah_id'
        )->withTimestamps();
    }
}
