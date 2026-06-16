<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\JadwalKelas;
use App\Models\Kelas;
use App\Models\MataKuliah;
use Illuminate\Http\Request;

class JadwalKelasController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $jadwal = JadwalKelas::with(['kelas', 'mataKuliah.dosen'])->latest()->paginate(10);
        return view('admin.jadwal.index', compact('jadwal'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $kelas = Kelas::orderBy('nama_kelas')->get();
        $mataKuliah = MataKuliah::with('dosen')->orderBy('nama_mk')->get();
        return view('admin.jadwal.create', compact('kelas', 'mataKuliah'));
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
            'kelas_id'       => 'required|exists:kelas,id',
            'mata_kuliah_id' => 'required|exists:mata_kuliah,id',
            'hari'           => 'required|in:senin,selasa,rabu,kamis,jumat,sabtu',
            'jam_mulai'      => 'required|date_format:H:i',
            'jam_selesai'    => 'required|date_format:H:i|after:jam_mulai',
            'ruangan'        => 'nullable|string|max:50',
        ]);
        $jadwal = JadwalKelas::create($validated);
        $jadwal->load(['kelas', 'mataKuliah.dosen']);

        if ($request->expectsJson() || $request->ajax()) {
            return response()->json([
                'success' => true,
                'message' => 'Jadwal berhasil ditambahkan.',
                'jadwal'  => [
                    'id'          => $jadwal->id,
                    'kelas'       => optional($jadwal->kelas)->nama_kelas ?? '-',
                    'mata_kuliah' => optional($jadwal->mataKuliah)->nama_mk ?? '-',
                    'dosen'       => optional(optional($jadwal->mataKuliah)->dosen)->nama ?? '-',
                    'hari'        => ucfirst($jadwal->hari),
                    'jam'         => $jadwal->jam_mulai . ' - ' . $jadwal->jam_selesai,
                    'ruangan'     => $jadwal->ruangan ?? optional($jadwal->kelas)->ruang_kelas ?? '-',
                    'edit_url'    => route('admin.jadwal.edit', $jadwal),
                    'delete_url'  => route('admin.jadwal.destroy', $jadwal),
                ],
            ]);
        }

        return redirect()->route('admin.jadwal.index')->with('success', 'Jadwal berhasil ditambahkan.');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return redirect()->route('admin.jadwal.edit', $id);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $jadwal = JadwalKelas::findOrFail($id);
        $kelas = Kelas::orderBy('nama_kelas')->get();
        $mataKuliah = MataKuliah::with('dosen')->orderBy('nama_mk')->get();
        return view('admin.jadwal.edit', compact('jadwal', 'kelas', 'mataKuliah'));
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
        $jadwal = JadwalKelas::findOrFail($id);
        $validated = $request->validate([
            'kelas_id' => 'required|exists:kelas,id',
            'mata_kuliah_id' => 'required|exists:mata_kuliah,id',
            'hari' => 'required|in:senin,selasa,rabu,kamis,jumat,sabtu',
            'jam_mulai' => 'required|date_format:H:i',
            'jam_selesai' => 'required|date_format:H:i|after:jam_mulai',
            'ruangan' => 'nullable|string|max:50',
        ]);
        $jadwal->update($validated);
        return redirect()->route('admin.jadwal.index')->with('success', 'Jadwal berhasil diupdate.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        JadwalKelas::findOrFail($id)->delete();
        return redirect()->route('admin.jadwal.index')->with('success', 'Jadwal berhasil dihapus.');
    }
}
