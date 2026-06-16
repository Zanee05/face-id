<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddFaceVerificationColumnsToAbsensiTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('absensi', function (Blueprint $table) {
            $table->float('confidence')->nullable()->after('metode');
            $table->enum('verification_status', ['auto_valid', 'pending_dosen', 'approved', 'rejected'])
                ->default('auto_valid')
                ->after('confidence');
            $table->foreignId('verified_by_dosen')->nullable()->after('verification_status')
                ->constrained('users')->nullOnDelete();
            $table->timestamp('verified_at')->nullable()->after('verified_by_dosen');
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
            $table->dropConstrainedForeignId('verified_by_dosen');
            $table->dropColumn(['confidence', 'verification_status', 'verified_at']);
        });
    }
}
