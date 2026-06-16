<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('absensi', function (Blueprint $table) {
            // Tambahkan index untuk query yang sering menggunakan confidence
            $table->index('confidence', 'idx_absensi_confidence');
            
            // Tambahkan index composite untuk query berdasarkan metode dan confidence
            $table->index(['metode', 'confidence'], 'idx_absensi_metode_confidence');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('absensi', function (Blueprint $table) {
            $table->dropIndex('idx_absensi_confidence');
            $table->dropIndex('idx_absensi_metode_confidence');
        });
    }
};
