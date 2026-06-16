@extends('layouts.app')

@section('content')
<div class="container auth-page">
    <div class="row justify-content-center w-100">
        <div class="col-md-10 col-lg-7 col-xl-6">
            <div class="card auth-card">
                <div class="card-body p-4 p-lg-5 bg-white">
                    <h4 class="mb-1">{{ __('Confirm Password') }}</h4>
                    <p class="text-muted mb-4">{{ __('Please confirm your password before continuing.') }}</p>

                    <form method="POST" action="{{ route('password.confirm') }}">
                        @csrf

                        <div class="mb-3">
                            <label for="password" class="form-label">{{ __('Password') }}</label>
                            <input id="password" type="password"
                                class="form-control @error('password') is-invalid @enderror"
                                name="password" required autocomplete="current-password">
                            @error('password')
                                <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                            @enderror
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2">
                            {{ __('Confirm Password') }}
                        </button>

                        @if (Route::has('password.request'))
                            <div class="mt-3 text-center">
                                <a class="small text-decoration-none" href="{{ route('password.request') }}">
                                    {{ __('Forgot Your Password?') }}
                                </a>
                            </div>
                        @endif
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
