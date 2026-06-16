<?php

namespace App\Http\Controllers;

class DashboardController extends Controller
{
    public function index()
    {
        $user = auth()->user();
        if ($user->role === 'admin') {
            return redirect()->route('admin.dashboard');
        }

        if ($user->role === 'dosen') {
            return redirect()->route('dosen.dashboard');
        }

        return redirect()->route('mahasiswa.dashboard');
    }
}
