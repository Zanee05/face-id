<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Dosen;
use App\Models\Kelas;
use App\Models\Mahasiswa;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class UserController extends Controller
{
    public function index(Request $request)
    {
        $role = $request->get('role', 'mahasiswa');
        if (!in_array($role, ['admin', 'dosen', 'mahasiswa'])) {
            $role = 'mahasiswa';
        }

        $users = User::with(['mahasiswa.kelas', 'dosen'])
            ->where('role', $role)
            ->orderBy('name')
            ->paginate(15)
            ->withQueryString();

        $counts = [
            'admin'     => User::where('role', 'admin')->count(),
            'dosen'     => User::where('role', 'dosen')->count(),
            'mahasiswa' => User::where('role', 'mahasiswa')->count(),
        ];

        return view('admin.users.index', compact('users', 'role', 'counts'));
    }

    public function create(Request $request)
    {
        $role = $request->get('role', 'mahasiswa');
        if (!in_array($role, ['admin', 'dosen', 'mahasiswa'])) {
            $role = 'mahasiswa';
        }

        $kelas = Kelas::orderBy('nama_kelas')->get();

        return view('admin.users.create', compact('role', 'kelas'));
    }

    public function store(Request $request)
    {
        $role = $request->input('role');

        $validated = $request->validate([
            'name'      => 'required|string|max:100',
            'email'     => 'required|email|unique:users,email',
            'role'      => 'required|in:admin,dosen,mahasiswa',
            'nidn'      => 'required_if:role,dosen|nullable|string|unique:dosen,nidn',
            'nim'       => 'required_if:role,mahasiswa|nullable|string|unique:mahasiswa,nim',
            'kelas_id'  => 'required_if:role,mahasiswa|nullable|exists:kelas,id',
            'password'  => 'required|string|min:8|confirmed',
        ], [
            'nidn.required_if'     => 'NIDN wajib diisi untuk role Dosen.',
            'nim.required_if'      => 'NIM wajib diisi untuk role Mahasiswa.',
            'kelas_id.required_if' => 'Kelas wajib dipilih untuk role Mahasiswa.',
        ]);

        $user = User::create([
            'name'     => $validated['name'],
            'email'    => $validated['email'],
            'role'     => $validated['role'],
            'password' => Hash::make($validated['password']),
        ]);

        $this->syncRoleProfile(
            $user,
            $validated['nidn'] ?? null,
            $validated['nim'] ?? null,
            isset($validated['kelas_id']) ? (int) $validated['kelas_id'] : null
        );

        // AJAX request — kembalikan JSON dengan data user baru
        if ($request->expectsJson() || $request->ajax()) {
            $user->load(['mahasiswa.kelas', 'dosen']);
            return response()->json([
                'success' => true,
                'message' => 'User ' . strtoupper($role) . ' berhasil ditambahkan.',
                'user'    => [
                    'id'        => $user->id,
                    'name'      => $user->name,
                    'email'     => $user->email,
                    'role'      => $user->role,
                    'nim'       => optional($user->mahasiswa)->nim,
                    'nidn'      => optional($user->dosen)->nidn,
                    'kelas'     => optional(optional($user->mahasiswa)->kelas)->nama_kelas,
                    'mk_count'  => optional($user->dosen)?->mataKuliah()->count() ?? 0,
                    'edit_url'  => route('admin.users.edit', $user),
                    'delete_url'=> route('admin.users.destroy', $user),
                    'created_at'=> $user->created_at->format('d M Y'),
                ],
                'counts'  => [
                    'admin'     => User::where('role', 'admin')->count(),
                    'dosen'     => User::where('role', 'dosen')->count(),
                    'mahasiswa' => User::where('role', 'mahasiswa')->count(),
                ],
            ]);
        }

        return redirect()
            ->route('admin.users.index', ['role' => $role])
            ->with('success', 'User ' . strtoupper($role) . ' berhasil ditambahkan.');
    }

    public function edit(User $user)
    {
        $kelas = Kelas::orderBy('nama_kelas')->get();
        $user->load(['mahasiswa.kelas', 'dosen']);

        return view('admin.users.edit', compact('user', 'kelas'));
    }

    public function update(Request $request, User $user)
    {
        $validated = $request->validate([
            'name'      => 'required|string|max:100',
            'email'     => 'required|email|unique:users,email,' . $user->id,
            'role'      => 'required|in:admin,dosen,mahasiswa',
            'nidn'      => 'required_if:role,dosen|nullable|string|unique:dosen,nidn,' . optional($user->dosen)->id,
            'nim'       => 'required_if:role,mahasiswa|nullable|string|unique:mahasiswa,nim,' . optional($user->mahasiswa)->id,
            'kelas_id'  => 'required_if:role,mahasiswa|nullable|exists:kelas,id',
            'password'  => 'nullable|string|min:8|confirmed',
        ], [
            'nidn.required_if'     => 'NIDN wajib diisi untuk role Dosen.',
            'nim.required_if'      => 'NIM wajib diisi untuk role Mahasiswa.',
            'kelas_id.required_if' => 'Kelas wajib dipilih untuk role Mahasiswa.',
        ]);

        $payload = [
            'name'  => $validated['name'],
            'email' => $validated['email'],
            'role'  => $validated['role'],
        ];

        if (!empty($validated['password'])) {
            $payload['password'] = Hash::make($validated['password']);
        }

        $user->update($payload);

        $this->syncRoleProfile(
            $user,
            $validated['nidn'] ?? null,
            $validated['nim'] ?? null,
            isset($validated['kelas_id']) ? (int) $validated['kelas_id'] : null
        );

        return redirect()
            ->route('admin.users.index', ['role' => $user->role])
            ->with('success', 'User berhasil diperbarui.');
    }

    public function destroy(User $user)
    {
        $role = $user->role;
        $user->delete();

        return redirect()
            ->route('admin.users.index', ['role' => $role])
            ->with('success', 'User berhasil dihapus.');
    }

    private function syncRoleProfile(User $user, ?string $nidn = null, ?string $nim = null, ?int $kelasId = null): void
    {
        if ($user->role === 'dosen') {
            $currentNidn = Dosen::where('user_id', $user->id)->value('nidn');
            Dosen::updateOrCreate(
                ['user_id' => $user->id],
                [
                    'nidn' => $nidn ?: ($currentNidn ?? ('DSN' . str_pad((string) $user->id, 6, '0', STR_PAD_LEFT))),
                    'nama' => $user->name,
                ]
            );
            return;
        }

        if ($user->role === 'mahasiswa') {
            $existing        = Mahasiswa::where('user_id', $user->id)->first();
            $resolvedKelasId = $kelasId ?? optional($existing)->kelas_id;
            if (!$resolvedKelasId) {
                $resolvedKelasId = Kelas::query()->orderBy('id')->value('id');
            }
            if (!$resolvedKelasId) {
                throw ValidationException::withMessages([
                    'nim' => 'Belum ada data kelas. Tambah minimal satu kelas terlebih dahulu.',
                ]);
            }

            Mahasiswa::updateOrCreate(
                ['user_id' => $user->id],
                [
                    'kelas_id' => $resolvedKelasId,
                    'nim'      => $nim,
                    'nama'     => $user->name,
                ]
            );

            $dosen = Dosen::where('user_id', $user->id)->first();
            if (!$dosen) {
                return;
            }
            if ($dosen->mataKuliah()->exists()) {
                throw ValidationException::withMessages([
                    'role' => 'Role tidak bisa diubah karena dosen masih memiliki mata kuliah aktif.',
                ]);
            }
            $dosen->delete();
            return;
        }

        // role = admin — bersihkan profil lama jika ada
        $dosen = Dosen::where('user_id', $user->id)->first();
        if ($dosen) {
            if ($dosen->mataKuliah()->exists()) {
                throw ValidationException::withMessages([
                    'role' => 'Role tidak bisa diubah karena dosen masih memiliki mata kuliah aktif.',
                ]);
            }
            $dosen->delete();
        }

        $mahasiswa = Mahasiswa::where('user_id', $user->id)->first();
        if (!$mahasiswa) {
            return;
        }
        if ($mahasiswa->absensi()->exists() || $mahasiswa->mataKuliahs()->exists()) {
            throw ValidationException::withMessages([
                'role' => 'Role tidak bisa diubah karena mahasiswa masih memiliki data absensi/mata kuliah.',
            ]);
        }
        $mahasiswa->delete();
    }
}