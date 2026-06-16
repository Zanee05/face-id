<?php

namespace Database\Seeders;

use App\Models\Dosen;
use App\Models\JadwalKelas;
use App\Models\Kelas;
use App\Models\Mahasiswa;
use App\Models\MataKuliah;
use App\Models\User;
use Faker\Factory as FakerFactory;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $faker = FakerFactory::create('id_ID');
        $password = Hash::make('password');

        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        DB::table('jadwal_kelas')->truncate();
        DB::table('mahasiswa_mata_kuliah')->truncate();
        DB::table('mata_kuliah')->truncate();
        DB::table('mahasiswa')->truncate();
        DB::table('dosen')->truncate();
        DB::table('kelas')->truncate();
        DB::table('users')->truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        User::create([
            'name' => 'Administrator SIAKAD',
            'email' => 'admin@siakad.ac.id',
            'role' => 'admin',
            'password' => $password,
        ]);

        $dosenNames = [
            'Dr. Andi Pratama, M.Kom',
            'Nurul Hidayah, S.Kom., M.T.',
            'Rizky Saputra, M.Cs',
        ];

        $dosens = collect($dosenNames)->map(function ($name, $index) use ($password) {
            $user = User::create([
                'name' => $name,
                'email' => 'dosen' . ($index + 1) . '@siakad.ac.id',
                'role' => 'dosen',
                'password' => $password,
            ]);

            return Dosen::create([
                'user_id' => $user->id,
                'nidn' => '20260' . str_pad((string) ($index + 1), 5, '0', STR_PAD_LEFT),
                'nama' => $name,
            ]);
        });

        $kelasList = collect([
            ['nama_kelas' => 'TI-A'],
            ['nama_kelas' => 'TI-B'],
            ['nama_kelas' => 'TI-C'],
        ])->map(function ($kelasData) {
            return Kelas::create($kelasData);
        });

        $mataKuliahBlueprints = [
            ['kode_mk' => 'IF301', 'nama_mk' => 'Algoritma dan Pemrograman', 'sks' => 3],
            ['kode_mk' => 'IF302', 'nama_mk' => 'Struktur Data', 'sks' => 3],
            ['kode_mk' => 'IF303', 'nama_mk' => 'Basis Data', 'sks' => 3],
            ['kode_mk' => 'IF304', 'nama_mk' => 'Pemrograman Web', 'sks' => 3],
            ['kode_mk' => 'IF305', 'nama_mk' => 'Jaringan Komputer', 'sks' => 2],
        ];

        $mataKuliahs = collect($mataKuliahBlueprints)->map(function ($mk, $index) use ($dosens) {
            $dosen = $dosens[$index % $dosens->count()];

            return MataKuliah::create([
                'dosen_id' => $dosen->id,
                'kode_mk' => $mk['kode_mk'],
                'nama_mk' => $mk['nama_mk'],
                'sks' => $mk['sks'],
            ]);
        });

        $hariKuliah = ['senin', 'selasa', 'rabu', 'kamis', 'jumat'];
        $jamSlots = [
            ['07:30:00', '09:10:00'],
            ['09:30:00', '11:10:00'],
            ['13:00:00', '14:40:00'],
            ['15:00:00', '16:40:00'],
        ];

        foreach ($kelasList as $kelasIndex => $kelas) {
            foreach ($mataKuliahs as $mkIndex => $mataKuliah) {
                $slot = $jamSlots[($kelasIndex + $mkIndex) % count($jamSlots)];
                $hari = $hariKuliah[($mkIndex + ($kelasIndex * 2)) % count($hariKuliah)];

                JadwalKelas::create([
                    'kelas_id' => $kelas->id,
                    'mata_kuliah_id' => $mataKuliah->id,
                    'hari' => $hari,
                    'jam_mulai' => $slot[0],
                    'jam_selesai' => $slot[1],
                    'ruangan' => 'Lab-' . chr(65 + $kelasIndex) . '-' . ($mkIndex + 1),
                ]);
            }
        }

        for ($i = 1; $i <= 30; $i++) {
            $namaMahasiswa = $faker->name();
            $kelas = $kelasList[($i - 1) % $kelasList->count()];

            $user = User::create([
                'name' => $namaMahasiswa,
                'email' => 'mhs' . str_pad((string) $i, 3, '0', STR_PAD_LEFT) . '@siakad.ac.id',
                'role' => 'mahasiswa',
                'password' => $password,
            ]);

            $mahasiswa = Mahasiswa::create([
                'user_id' => $user->id,
                'kelas_id' => $kelas->id,
                'nim' => '2301' . str_pad((string) $i, 6, '0', STR_PAD_LEFT),
                'nama' => $namaMahasiswa,
            ]);

            $ambilMk = $mataKuliahs->random(random_int(3, 5))->pluck('id')->all();
            $mahasiswa->mataKuliahs()->sync($ambilMk);
        }
    }
}
