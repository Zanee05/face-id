<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FaceLog extends Model
{
    use HasFactory;

    protected $table = 'face_logs';

    protected $fillable = [
        'user_id',
        'absensi_id',
        'status',
        'distance',
        'confidence',
        'message',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function absensi()
    {
        return $this->belongsTo(Absensi::class);
    }
}
