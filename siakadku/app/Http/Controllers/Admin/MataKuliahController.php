<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Dosen;
use App\Models\MataKuliah;
use Illuminate\Http\Request;

class MataKuliahController extends Controller
{
    public function index()
    {
        $mataKuliah = MataKuliah::with('dosen')->latest()->paginate(10);
        return view('admin.mata_kuliah.index', compact('mataKuliah'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $dosen = Dosen::orderBy('nama')->get();
        return view('admin.mata_kuliah.create', compact('dosen'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'dosen_id' => 'required|exists:dosen,id',
            'kode_mk'  => 'required|string|unique:mata_kuliah,kode_mk',
            'nama_mk'  => 'required|string|max:100',
            'sks'      => 'required|integer|min:1|max:6',
        ]);
        $mk = MataKuliah::create($validated);
        $mk->load('dosen');

        if ($request->expectsJson() || $request->ajax()) {
            return response()->json([
                'success'    => true,
                'message'    => 'Mata kuliah berhasil ditambahkan.',
                'mataKuliah' => [
                    'id'         => $mk->id,
                    'kode_mk'    => $mk->kode_mk,
                    'nama_mk'    => $mk->nama_mk,
                    'sks'        => $mk->sks,
                    'dosen'      => optional($mk->dosen)->nama ?? '-',
                    'edit_url'   => route('admin.mata-kuliah.edit', $mk),
                    'delete_url' => route('admin.mata-kuliah.destroy', $mk),
                ],
            ]);
        }

        return redirect()->route('admin.mata-kuliah.index')->with('success', 'Mata kuliah berhasil ditambahkan.');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return redirect()->route('admin.mata-kuliah.edit', $id);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id) { $mataKuliah = MataKuliah::findOrFail($id); $dosen = Dosen::orderBy('nama')->get(); return view('admin.mata_kuliah.edit', compact('mataKuliah', 'dosen')); }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $mk = MataKuliah::findOrFail($id);
        $validated = $request->validate([
            'dosen_id' => 'required|exists:dosen,id',
            'kode_mk' => 'required|string|unique:mata_kuliah,kode_mk,' . $mk->id,
            'nama_mk' => 'required|string|max:100',
            'sks' => 'required|integer|min:1|max:6',
        ]);
        $mk->update($validated);
        return redirect()->route('admin.mata-kuliah.index')->with('success', 'Mata kuliah berhasil diupdate.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        MataKuliah::findOrFail($id)->delete();
        return redirect()->route('admin.mata-kuliah.index')->with('success', 'Mata kuliah berhasil dihapus.');
    }
}
