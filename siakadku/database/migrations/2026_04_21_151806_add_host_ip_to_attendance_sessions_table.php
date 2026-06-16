<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddHostIpToAttendanceSessionsTable extends Migration
{
    public function up()
    {
        Schema::table('attendance_sessions', function (Blueprint $table) {
            // IP laptop dosen saat sesi barcode dibuat (disimpan agar QR otomatis terbentuk)
            $table->string('host_ip', 100)->nullable()->after('barcode_token');
        });
    }

    public function down()
    {
        Schema::table('attendance_sessions', function (Blueprint $table) {
            $table->dropColumn('host_ip');
        });
    }
}