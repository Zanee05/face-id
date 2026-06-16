@extends('layouts.app')

@section('content')
<div class="container auth-page">
    <div class="row justify-content-center w-100">
        <div class="col-md-10 col-lg-7 col-xl-6">
            <div class="card auth-card">
                <div class="card-body p-4 p-lg-5 bg-white">
                    <h4 class="mb-2">{{ __('Verify Your Email Address') }}</h4>

                    @if (session('resent'))
                        <div class="alert alert-success" role="alert">
                            {{ __('A fresh verification link has been sent to your email address.') }}
                        </div>
                    @endif

                    <p class="text-muted mb-3">
                        {{ __('Before proceeding, please check your email for a verification link.') }}
                    </p>

                    <div class="d-flex flex-column gap-2">
                        <div>{{ __('If you did not receive the email') }},</div>
                        <form method="POST" action="{{ route('verification.resend') }}">
                            @csrf
                            <button type="submit" class="btn btn-outline-primary w-100">
                                {{ __('click here to request another') }}
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
