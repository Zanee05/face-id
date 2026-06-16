<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class AlterStatusEnumOnAbsensiTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('absensi')) {
            return;
        }

        DB::statement("ALTER TABLE `absensi` MODIFY `status` ENUM('hadir','telat','tidak_hadir','izin','sakit') NOT NULL DEFAULT 'hadir'");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        if (!Schema::hasTable('absensi')) {
            return;
        }

        DB::statement("ALTER TABLE `absensi` MODIFY `status` ENUM('hadir','tidak_hadir','izin','sakit') NOT NULL DEFAULT 'hadir'");
    }
}
