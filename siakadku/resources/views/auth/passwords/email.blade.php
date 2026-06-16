@extends('layouts.app')

@section('content')
<div class="container auth-page">
    <div class="row justify-content-center w-100">
        <div class="col-md-10 col-lg-7 col-xl-6">
            <div class="card auth-card">
                <div class="card-body p-4 p-lg-5 bg-white">
                    <h4 class="mb-1">{{ __('Reset Password') }}</h4>
                    <p class="text-muted mb-4">Kami akan mengirim tautan reset ke email kamu.</p>

                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif

                    <form method="POST" action="{{ route('password.email') }}">
                        @csrf

                        <div class="mb-3">
                            <label for="email" class="form-label">{{ __('E-Mail Address') }}</label>
                            <input id="email" type="email" class="form-control @error('email') is-invalid @enderror"
                                name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>
                            @error('email')
                                <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                            @enderror
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2">
                            {{ __('Send Password Reset Link') }}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
