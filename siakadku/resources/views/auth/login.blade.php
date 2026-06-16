@extends('layouts.app')

@section('content')
<div class="container auth-page">
    <div class="row justify-content-center w-100">
        <div class="col-lg-10 col-xl-9">
            <div class="card auth-card">
                <div class="row g-0">
                    <div class="col-md-5 d-none d-md-flex auth-hero p-4 p-lg-5">
                        <div class="my-auto">
                            <h3 class="mb-3">SIAKAD</h3>
                            <p class="mb-0">
                                Sistem Informasi Akademik.
                            </p>
                        </div>
                    </div>
                    <div class="col-md-7 p-4 p-lg-5 bg-white">
                        <h4 class="mb-1">Masuk Akun</h4>
                        <p class="text-muted mb-4">Silakan login untuk melanjutkan.</p>

                        <form method="POST" action="{{ route('login') }}">
                            @csrf

                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input id="email" type="email" class="form-control @error('email') is-invalid @enderror"
                                    name="email" value="{{ old('email') }}" required autocomplete="email" autofocus
                                    placeholder="contoh@email.com">
                                @error('email')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input id="password" type="password"
                                    class="form-control @error('password') is-invalid @enderror"
                                    name="password" required autocomplete="current-password"
                                    placeholder="Masukkan password">
                                @error('password')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>

                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="remember" id="remember"
                                        {{ old('remember') ? 'checked' : '' }}>
                                    <label class="form-check-label" for="remember">Ingat saya</label>
                                </div>
                                @if (Route::has('password.request'))
                                    <a class="small text-decoration-none" href="{{ route('password.request') }}">
                                        Lupa password?
                                    </a>
                                @endif
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-2">
                                Login
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
