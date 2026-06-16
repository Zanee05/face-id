<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MataKuliah extends Model
{
    use HasFactory;

    protected $table = 'mata_kuliah';

    protected $fillable = [
        'dosen_id',
        'kode_mk',
        'nama_mk',
        'sks',
    ];

    public function dosen()
    {
        return $this->belongsTo(Dosen::class);
    }

    public function absensi()
    {
        return $this->hasMany(Absensi::class);
    }

    public function jadwalKelas()
    {
        return $this->hasMany(JadwalKelas::class);
    }

    public function mahasiswa()
    {
        return $this->belongsToMany(
            Mahasiswa::class,
            'mahasiswa_mata_kuliah',
            'mata_kuliah_id',
            'mahasiswa_id'
        )->withTimestamps();
    }
}
