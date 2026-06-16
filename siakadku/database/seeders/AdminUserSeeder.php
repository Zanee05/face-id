<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $adminName = env('DEFAULT_ADMIN_NAME', 'Admin SIAKAD');
        $adminEmail = env('DEFAULT_ADMIN_EMAIL', 'admin@siakad.test');
        $adminPassword = env('DEFAULT_ADMIN_PASSWORD', 'admin12345');

        User::updateOrCreate(
            ['email' => $adminEmail],
            [
                'name' => $adminName,
                'password' => Hash::make($adminPassword),
                'role' => 'admin',
            ]
        );
    }
}
