<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAbsensisTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('absensi', function (Blueprint $table) {
            $table->id();
            $table->foreignId('mahasiswa_id')->constrained('mahasiswa')->cascadeOnDelete();
            $table->foreignId('mata_kuliah_id')->constrained('mata_kuliah')->restrictOnDelete();
            $table->date('tanggal');
            $table->time('jam_masuk')->nullable();
            $table->enum('status', ['hadir', 'telat', 'tidak_hadir', 'izin', 'sakit'])->default('hadir');
            $table->string('metode')->default('face_id');
            $table->timestamps();
            $table->unique(['mahasiswa_id', 'mata_kuliah_id', 'tanggal'], 'uniq_absensi_harian');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('absensi');
    }
}
