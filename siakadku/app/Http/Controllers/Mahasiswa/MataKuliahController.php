<?php

namespace App\Http\Controllers\Mahasiswa;

use App\Http\Controllers\Controller;
use App\Models\MataKuliah;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class MataKuliahController extends Controller
{
    public function index()
    {
        $mahasiswa = optional(auth()->user())->mahasiswa;
        $profileMissing = !$mahasiswa;
        $pivotReady = Schema::hasTable('mahasiswa_mata_kuliah');

        $mataKuliah = MataKuliah::with('dosen')->orderBy('nama_mk')->get();
        $selected = [];
        if ($mahasiswa && $pivotReady) {
            $selected = DB::table('mahasiswa_mata_kuliah')
                ->where('mahasiswa_id', $mahasiswa->id)
                ->pluck('mata_kuliah_id')
                ->map(function ($id) {
                    return (int) $id;
                })
                ->all();
        }

        return view('mahasiswa.mata_kuliah', compact('mataKuliah', 'selected', 'profileMissing', 'pivotReady'));
    }

    public function update(Request $request)
    {
        $mahasiswa = optional(auth()->user())->mahasiswa;
        if (!$mahasiswa) {
            return redirect()
                ->route('mahasiswa.mata-kuliah.index')
                ->with('error', 'Profil mahasiswa belum tersedia. Hubungi admin untuk melengkapi data mahasiswa.');
        }
        if (!Schema::hasTable('mahasiswa_mata_kuliah')) {
            return redirect()
                ->route('mahasiswa.mata-kuliah.index')
                ->with('error', 'Fitur susun mata kuliah belum aktif di database. Jalankan migration terlebih dahulu.');
        }

        $validated = $request->validate([
            'mata_kuliah_ids' => 'nullable|array',
            'mata_kuliah_ids.*' => 'integer|exists:mata_kuliah,id',
        ]);

        $mahasiswa->mataKuliahs()->sync($validated['mata_kuliah_ids'] ?? []);

        return redirect()
            ->route('mahasiswa.mata-kuliah.index')
            ->with('success', 'Susunan mata kuliah berhasil disimpan.');
    }
}
