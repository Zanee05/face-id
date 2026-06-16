<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ config('app.name', 'SIAKAD') }}</title>

    <script src="{{ asset('js/app.js') }}" defer></script>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- App CSS -->
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">

    <style>
        :root {
            --sidebar-width: 240px;
            --sidebar-collapsed-width: 64px;
            --sidebar-bg: #0f172a;
            --sidebar-hover: rgba(255,255,255,0.07);
            --sidebar-active: rgba(37,99,235,0.85);
            --sidebar-text: rgba(255,255,255,0.75);
            --sidebar-text-active: #ffffff;
            --topbar-height: 56px;
            --transition: 0.22s ease;
        }

        body { margin: 0; font-family: 'Plus Jakarta Sans', sans-serif; background: #f1f5f9; }

        .app-shell { display: flex; min-height: 100vh; }

        /* Sidebar */
        .app-sidebar {
            width: var(--sidebar-width);
            min-height: 100vh;
            background: var(--sidebar-bg);
            display: flex;
            flex-direction: column;
            position: fixed;
            top: 0; left: 0; bottom: 0;
            z-index: 1040;
            transition: width var(--transition);
            overflow: hidden;
        }
        .app-sidebar.collapsed { width: var(--sidebar-collapsed-width); }

        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 0 16px;
            height: var(--topbar-height);
            text-decoration: none;
            border-bottom: 1px solid rgba(255,255,255,0.06);
            flex-shrink: 0;
        }
        .sidebar-brand-icon {
            width: 34px; height: 34px;
            border-radius: 8px;
            background: linear-gradient(135deg, #1d4ed8, #0ea5e9);
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-weight: 800; font-size: 15px;
            flex-shrink: 0;
        }
        .sidebar-brand-text {
            color: #fff; font-weight: 700; font-size: 15px;
            white-space: nowrap; overflow: hidden;
            transition: opacity var(--transition), width var(--transition);
        }
        .app-sidebar.collapsed .sidebar-brand-text { opacity: 0; width: 0; }

        .sidebar-nav {
            flex: 1;
            overflow-y: auto;
            overflow-x: hidden;
            padding: 10px 0;
        }
        .sidebar-nav::-webkit-scrollbar { width: 4px; }
        .sidebar-nav::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 4px; }

        .sidebar-section-label {
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: rgba(255,255,255,0.3);
            padding: 14px 20px 4px;
            white-space: nowrap;
            overflow: hidden;
            transition: opacity var(--transition);
        }
        .app-sidebar.collapsed .sidebar-section-label { opacity: 0; }

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 9px 16px;
            margin: 1px 8px;
            border-radius: 8px;
            color: var(--sidebar-text);
            text-decoration: none;
            font-size: 13.5px;
            font-weight: 500;
            white-space: nowrap;
            transition: background var(--transition), color var(--transition);
            position: relative;
        }
        .sidebar-link:hover { background: var(--sidebar-hover); color: var(--sidebar-text-active); }
        .sidebar-link.active { background: var(--sidebar-active); color: var(--sidebar-text-active); }
        .sidebar-link i { font-size: 17px; flex-shrink: 0; width: 20px; text-align: center; }
        .sidebar-link-text { overflow: hidden; transition: opacity var(--transition), width var(--transition); }
        .app-sidebar.collapsed .sidebar-link-text { opacity: 0; width: 0; }

        .app-sidebar.collapsed .sidebar-link { justify-content: center; padding: 9px 0; margin: 1px 8px; }
        .app-sidebar.collapsed .sidebar-link::after {
            content: attr(data-label);
            position: absolute;
            left: calc(var(--sidebar-collapsed-width) - 4px);
            background: #1e293b;
            color: #fff;
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 6px;
            white-space: nowrap;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.15s;
            z-index: 9999;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }
        .app-sidebar.collapsed .sidebar-link:hover::after { opacity: 1; }

        .sidebar-footer { border-top: 1px solid rgba(255,255,255,0.06); padding: 10px 8px; flex-shrink: 0; }
        .sidebar-user { display: flex; align-items: center; gap: 10px; padding: 8px 10px; border-radius: 8px; color: var(--sidebar-text); overflow: hidden; }
        .sidebar-user-avatar {
            width: 32px; height: 32px; border-radius: 50%;
            background: rgba(37,99,235,0.8);
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-weight: 700; font-size: 13px; flex-shrink: 0;
        }
        .sidebar-user-info { overflow: hidden; transition: opacity var(--transition), width var(--transition); }
        .app-sidebar.collapsed .sidebar-user-info { opacity: 0; width: 0; }
        .sidebar-user-name { font-size: 13px; font-weight: 600; color: #fff; white-space: nowrap; }
        .sidebar-user-role { font-size: 11px; color: rgba(255,255,255,0.4); white-space: nowrap; }

        /* Toggle Button */
        .sidebar-toggle {
            position: fixed;
            top: 14px;
            left: calc(var(--sidebar-width) - 14px);
            z-index: 1050;
            width: 28px; height: 28px;
            border-radius: 50%;
            background: #1e293b;
            border: 2px solid rgba(255,255,255,0.1);
            color: rgba(255,255,255,0.7);
            display: flex; align-items: center; justify-content: center;
            cursor: pointer;
            transition: left var(--transition);
            font-size: 13px;
            padding: 0;
        }
        .sidebar-toggle:hover { background: #2563eb; color: #fff; border-color: #2563eb; }
        .app-sidebar.collapsed ~ .sidebar-toggle { left: calc(var(--sidebar-collapsed-width) - 14px); }
        .app-sidebar.collapsed ~ .sidebar-toggle .toggle-icon { transform: rotate(180deg); }
        .toggle-icon { transition: transform var(--transition); display: inline-flex; }

        /* Main Body */
        .app-body {
            margin-left: var(--sidebar-width);
            flex: 1;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            transition: margin-left var(--transition);
        }
        .app-body.sidebar-collapsed { margin-left: var(--sidebar-collapsed-width); }

        .app-topbar {
            height: var(--topbar-height);
            background: #fff;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            padding: 0 24px;
            position: sticky;
            top: 0;
            z-index: 1030;
            gap: 12px;
        }
        .topbar-page-title { font-size: 15px; font-weight: 600; color: #1e293b; flex: 1; }

        .app-main { flex: 1; padding: 20px 24px; }

        /* Mobile Overlay */
        .sidebar-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 1039; }
        .sidebar-overlay.show { display: block; }

        @media (max-width: 991px) {
            .app-sidebar { transform: translateX(-100%); width: var(--sidebar-width) !important; transition: transform var(--transition); }
            .app-sidebar.mobile-open { transform: translateX(0); }
            .app-body { margin-left: 0 !important; }
            .sidebar-toggle { display: none; }
            .app-topbar { padding: 0 16px; }
            .app-main { padding: 16px; }
        }
    </style>
</head>
<body>

@auth
<div class="sidebar-overlay" id="sidebarOverlay" onclick="closeMobileSidebar()"></div>

<aside class="app-sidebar" id="appSidebar">
    <a class="sidebar-brand" href="{{ url('/') }}">
        <div class="sidebar-brand-icon">S</div>
        <span class="sidebar-brand-text">{{ config('app.name', 'SIAKAD') }}</span>
    </a>

    <nav class="sidebar-nav">
        @if(auth()->user()->role === 'mahasiswa')
            <div class="sidebar-section-label">Menu</div>
            <a class="sidebar-link {{ request()->routeIs('mahasiswa.dashboard') ? 'active' : '' }}"
               href="{{ route('mahasiswa.dashboard') }}" data-label="Dashboard">
                <i class="bi bi-speedometer2"></i>
                <span class="sidebar-link-text">Dashboard</span>
            </a>
            <a class="sidebar-link {{ request()->routeIs('mahasiswa.mata-kuliah.*') ? 'active' : '' }}"
               href="{{ route('mahasiswa.mata-kuliah.index') }}" data-label="Susun Mata Kuliah">
                <i class="bi bi-journal-bookmark-fill"></i>
                <span class="sidebar-link-text">Susun Mata Kuliah</span>
            </a>
            <a class="sidebar-link {{ request()->routeIs('mahasiswa.absensi.index') ? 'active' : '' }}"
               href="{{ route('mahasiswa.absensi.index') }}" data-label="Registrasi Face ID">
                <i class="bi bi-person-bounding-box"></i>
                <span class="sidebar-link-text">Registrasi Face ID</span>
            </a>
            <a class="sidebar-link {{ request()->routeIs('mahasiswa.absensi.rekap') ? 'active' : '' }}"
               href="{{ route('mahasiswa.absensi.rekap') }}" data-label="Rekap Absensi">
                <i class="bi bi-clipboard2-data-fill"></i>
                <span class="sidebar-link-text">Rekap Absensi</span>
            </a>
        @endif

        @if(auth()->user()->role === 'dosen')
            <div class="sidebar-section-label">Menu</div>
            <a class="sidebar-link {{ request()->routeIs('dosen.dashboard') ? 'active' : '' }}"
               href="{{ route('dosen.dashboard') }}" data-label="Dashboard">
                <i class="bi bi-speedometer2"></i>
                <span class="sidebar-link-text">Dashboard</span>
            </a>
            <a class="sidebar-link {{ request()->routeIs('dosen.absensi.*') ? 'active' : '' }}"
               href="{{ route('dosen.absensi.index') }}" data-label="Rekap Absensi">
                <i class="bi bi-clipboard2-check-fill"></i>
                <span class="sidebar-link-text">Rekap Absensi</span>
            </a>
            <a class="sidebar-link {{ request()->routeIs('dosen.sessions.*') ? 'active' : '' }}"
               href="{{ route('dosen.sessions.index') }}" data-label="Sesi Absensi">
                <i class="bi bi-camera-video-fill"></i>
                <span class="sidebar-link-text">Sesi Absensi</span>
            </a>
        @endif

        @if(auth()->user()->role === 'admin')
            <div class="sidebar-section-label">Manajemen</div>
            <a class="sidebar-link {{ request()->routeIs('admin.dashboard') ? 'active' : '' }}"
               href="{{ route('admin.dashboard') }}" data-label="Dashboard">
                <i class="bi bi-speedometer2"></i>
                <span class="sidebar-link-text">Dashboard</span>
            </a>
            <a class="sidebar-link {{ request()->routeIs('admin.users.*') ? 'active' : '' }}"
               href="{{ route('admin.users.index') }}" data-label="Manajemen User">
                <i class="bi bi-people-fill"></i>
                <span class="sidebar-link-text">Manajemen User</span>
            </a>
            <div class="sidebar-section-label">Akademik</div>
            <a class="sidebar-link {{ request()->routeIs('admin.kelas.*') ? 'active' : '' }}"
               href="{{ route('admin.kelas.index') }}" data-label="Kelola Kelas">
                <i class="bi bi-building"></i>
                <span class="sidebar-link-text">Kelola Kelas</span>
            </a>
            <a class="sidebar-link {{ request()->routeIs('admin.mata-kuliah.*') ? 'active' : '' }}"
               href="{{ route('admin.mata-kuliah.index') }}" data-label="Mata Kuliah">
                <i class="bi bi-book-fill"></i>
                <span class="sidebar-link-text">Mata Kuliah</span>
            </a>
            <a class="sidebar-link {{ request()->routeIs('admin.jadwal.*') ? 'active' : '' }}"
               href="{{ route('admin.jadwal.index') }}" data-label="Kelola Jadwal">
                <i class="bi bi-calendar3-week-fill"></i>
                <span class="sidebar-link-text">Kelola Jadwal</span>
            </a>
        @endif
    </nav>

    <div class="sidebar-footer">
        <div class="sidebar-user">
            <div class="sidebar-user-avatar">{{ strtoupper(mb_substr(Auth::user()->name, 0, 1)) }}</div>
            <div class="sidebar-user-info">
                <div class="sidebar-user-name">{{ Auth::user()->name }}</div>
                <div class="sidebar-user-role">{{ ucfirst(Auth::user()->role) }}</div>
            </div>
        </div>
        <a class="sidebar-link mt-1" href="{{ route('logout') }}" data-label="Logout"
           onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
            <i class="bi bi-box-arrow-left"></i>
            <span class="sidebar-link-text">Logout</span>
        </a>
        <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">@csrf</form>
    </div>
</aside>

<button class="sidebar-toggle" id="sidebarToggle" onclick="toggleSidebar()" title="Toggle sidebar">
    <span class="toggle-icon"><i class="bi bi-chevron-left"></i></span>
</button>

<div class="app-body" id="appBody">
    <header class="app-topbar">
        <button class="btn btn-sm btn-light d-lg-none me-2" onclick="openMobileSidebar()">
            <i class="bi bi-list fs-5"></i>
        </button>
        <span class="topbar-page-title" id="topbarTitle">{{ config('app.name', 'SIAKAD') }}</span>
        <div class="d-flex align-items-center gap-2">
            <div class="d-inline-flex align-items-center justify-content-center rounded-circle text-white"
                 style="width:32px;height:32px;background:rgba(37,99,235,0.85);font-size:13px;font-weight:700;">
                {{ strtoupper(mb_substr(Auth::user()->name, 0, 1)) }}
            </div>
            <span class="d-none d-md-inline text-secondary" style="font-size:13px;">{{ Auth::user()->name }}</span>
        </div>
    </header>

    <div class="px-4 pt-3">
        @if(session('success'))
            <div class="alert alert-success alert-dismissible fade show mb-0" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>{{ session('success') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        @endif
        @if(session('error'))
            <div class="alert alert-danger alert-dismissible fade show mb-0" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>{{ session('error') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        @endif
        @if($errors->any())
            <div class="alert alert-danger alert-dismissible fade show mb-0" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>{{ $errors->first() }}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        @endif
    </div>

    <main class="app-main">
        @yield('content')
    </main>
</div>

@else
<div id="app">
    <main>@yield('content')</main>
</div>
@endauth

<script>
const sidebar   = document.getElementById('appSidebar');
const body      = document.getElementById('appBody');
const STORE_KEY = 'siakad_sidebar_collapsed';

if (localStorage.getItem(STORE_KEY) === '1') {
    sidebar?.classList.add('collapsed');
    body?.classList.add('sidebar-collapsed');
}

function toggleSidebar() {
    const isCollapsed = sidebar.classList.toggle('collapsed');
    body.classList.toggle('sidebar-collapsed', isCollapsed);
    localStorage.setItem(STORE_KEY, isCollapsed ? '1' : '0');
}

function openMobileSidebar() {
    sidebar?.classList.add('mobile-open');
    document.getElementById('sidebarOverlay')?.classList.add('show');
}
function closeMobileSidebar() {
    sidebar?.classList.remove('mobile-open');
    document.getElementById('sidebarOverlay')?.classList.remove('show');
}

document.addEventListener('DOMContentLoaded', () => {
    const heading = document.querySelector('.app-main h4, .app-main h3, .app-main h1');
    const titleEl = document.getElementById('topbarTitle');
    if (heading && titleEl) titleEl.textContent = heading.textContent.trim();
});
</script>

</body>
</html>
