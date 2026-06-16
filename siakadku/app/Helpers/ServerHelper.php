<?php

namespace App\Helpers;

class ServerHelper
{
    /**
     * Deteksi base URL yang bisa diakses dari perangkat lain di jaringan yang sama.
     *
     * Prioritas:
     * 1. APP_PUBLIC_URL di .env (jika diisi manual, dipakai)
     * 2. IP LAN dari network interface (otomatis, cocok untuk IP dinamis)
     * 3. Fallback ke APP_URL
     *
     * @param  \Illuminate\Http\Request|null  $request
     * @return string  contoh: http://192.168.1.15:8000
     */
    public static function getLanBaseUrl($request = null): string
    {
        // Prioritas 1: APP_PUBLIC_URL manual di .env
        $manual = trim(env('APP_PUBLIC_URL', ''));
        if ($manual && !in_array(parse_url($manual, PHP_URL_HOST), ['localhost', '127.0.0.1', '::1'], true)) {
            return rtrim($manual, '/');
        }

        // Prioritas 2: Deteksi IP LAN dari network interface server
        $lanIp = self::detectLanIp();
        if ($lanIp) {
            $port = self::detectPort($request);
            $scheme = self::detectScheme($request);
            return $scheme . '://' . $lanIp . ($port && !in_array($port, [80, 443]) ? ':' . $port : '');
        }

        // Prioritas 3: Fallback APP_URL
        return rtrim(config('app.url', 'http://localhost'), '/');
    }

    /**
     * Deteksi IP LAN dari network interface (bukan loopback, bukan IPv6 link-local).
     * Bekerja di Windows (ipconfig) dan Linux/Mac (ip route / hostname -I).
     */
    private static function detectLanIp(): ?string
    {
        // Cara 1: socket trick — buka UDP ke luar, ambil IP lokal yang dipilih OS
        // Tidak ada paket yang dikirim, hanya untuk resolve interface
        try {
            $sock = @socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);
            if ($sock !== false) {
                @socket_connect($sock, '8.8.8.8', 80);
                @socket_getsockname($sock, $ip);
                @socket_close($sock);
                if ($ip && filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE) === false
                    && $ip !== '127.0.0.1' && self::isPrivateIp($ip)) {
                    return $ip;
                }
            }
        } catch (\Throwable $e) {
            // lanjut ke cara berikutnya
        }

        // Cara 2: hostname -I (Linux)
        if (PHP_OS_FAMILY !== 'Windows') {
            $output = @shell_exec('hostname -I 2>/dev/null');
            if ($output) {
                $ips = array_filter(explode(' ', trim($output)));
                foreach ($ips as $ip) {
                    $ip = trim($ip);
                    if (self::isPrivateIp($ip) && $ip !== '127.0.0.1') {
                        return $ip;
                    }
                }
            }

            // Cara 3: ip route (Linux)
            $route = @shell_exec('ip route get 8.8.8.8 2>/dev/null');
            if ($route && preg_match('/src\s+([\d.]+)/', $route, $m)) {
                $ip = $m[1];
                if (self::isPrivateIp($ip) && $ip !== '127.0.0.1') {
                    return $ip;
                }
            }
        } else {
            // Cara 4: ipconfig (Windows) — ambil IPv4 non-loopback pertama
            $output = @shell_exec('ipconfig 2>nul');
            if ($output && preg_match_all('/IPv4[^:]*:\s*([\d.]+)/', $output, $matches)) {
                foreach ($matches[1] as $ip) {
                    $ip = trim($ip);
                    if (self::isPrivateIp($ip) && $ip !== '127.0.0.1') {
                        return $ip;
                    }
                }
            }
        }

        return null;
    }

    /**
     * Cek apakah IP termasuk range private (RFC 1918):
     * 10.x.x.x, 172.16-31.x.x, 192.168.x.x
     */
    private static function isPrivateIp(string $ip): bool
    {
        return (bool) filter_var($ip, FILTER_VALIDATE_IP,
            FILTER_FLAG_IPV4 | FILTER_FLAG_NO_RES_RANGE
        ) && filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4) !== false
            && (
                str_starts_with($ip, '10.')
                || str_starts_with($ip, '192.168.')
                || preg_match('/^172\.(1[6-9]|2\d|3[01])\./', $ip)
            );
    }

    /**
     * Deteksi port dari SERVER_PORT atau request.
     */
    private static function detectPort($request = null): int
    {
        if ($request) {
            return (int) $request->getPort();
        }
        return (int) ($_SERVER['SERVER_PORT'] ?? 80);
    }

    /**
     * Deteksi scheme (http/https).
     */
    private static function detectScheme($request = null): string
    {
        if ($request) {
            return $request->getScheme();
        }
        return (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    }
}