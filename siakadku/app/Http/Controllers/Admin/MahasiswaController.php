<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Kelas;
use App\Models\Mahasiswa;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class MahasiswaController extends Controller
{
    public function index()
    {
        $mahasiswa = Mahasiswa::with(['user', 'kelas'])->latest()->paginate(10);
        return response()->json($mahasiswa);
    }

    public function create()
    {
        return response()->json(Kelas::orderBy('nama_kelas')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:100',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
            'nim' => 'required|string|unique:mahasiswa,nim',
            'nama' => 'required|string|max:100',
            'kelas_id' => 'required|exists:kelas,id',
        ]);

        $user = User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
            'role' => 'mahasiswa',
        ]);

        Mahasiswa::create([
            'user_id' => $user->id,
            'kelas_id' => $validated['kelas_id'],
            'nim' => $validated['nim'],
            'nama' => $validated['nama'],
        ]);

        return response()->json(['message' => 'Mahasiswa berhasil ditambahkan.'], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return response()->json(Mahasiswa::with(['user', 'kelas'])->findOrFail($id));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        return $this->show($id);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $mahasiswa = Mahasiswa::with('user')->findOrFail($id);
        $validated = $request->validate([
            'name' => 'required|string|max:100',
            'email' => 'required|email|unique:users,email,' . $mahasiswa->user_id,
            'nim' => 'required|string|unique:mahasiswa,nim,' . $mahasiswa->id,
            'nama' => 'required|string|max:100',
            'kelas_id' => 'required|exists:kelas,id',
        ]);

        $mahasiswa->user->update([
            'name' => $validated['name'],
            'email' => $validated['email'],
        ]);

        $mahasiswa->update([
            'kelas_id' => $validated['kelas_id'],
            'nim' => $validated['nim'],
            'nama' => $validated['nama'],
        ]);

        return response()->json(['message' => 'Mahasiswa berhasil diupdate.']);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $mahasiswa = Mahasiswa::findOrFail($id);
        $mahasiswa->user()->delete();
        return response()->json(['message' => 'Mahasiswa berhasil dihapus.']);
    }
}
