-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2026 at 08:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsiakadku`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mahasiswa_id` bigint(20) UNSIGNED NOT NULL,
  `mata_kuliah_id` bigint(20) UNSIGNED NOT NULL,
  `attendance_session_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tanggal` date NOT NULL,
  `jam_masuk` time DEFAULT NULL,
  `status` enum('hadir','telat','tidak_hadir','izin','sakit') NOT NULL DEFAULT 'hadir',
  `metode` varchar(255) NOT NULL DEFAULT 'face_id',
  `confidence` double(8,2) DEFAULT NULL,
  `snapshot_path` varchar(255) DEFAULT NULL,
  `verification_status` enum('auto_valid','pending_dosen','approved','rejected') NOT NULL DEFAULT 'auto_valid',
  `verified_by_dosen` bigint(20) UNSIGNED DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `absensi`
--

INSERT INTO `absensi` (`id`, `mahasiswa_id`, `mata_kuliah_id`, `attendance_session_id`, `tanggal`, `jam_masuk`, `status`, `metode`, `confidence`, `snapshot_path`, `verification_status`, `verified_by_dosen`, `verified_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, '2026-04-10', '15:10:55', 'telat', 'faceid', 45.57, NULL, 'approved', 3, '2026-04-20 09:34:06', '2026-04-10 08:10:55', '2026-04-20 09:34:06'),
(2, 1, 1, 6, '2026-04-06', '18:44:25', 'hadir', 'manual', NULL, NULL, 'approved', 3, '2026-04-10 11:45:04', '2026-04-10 11:44:25', '2026-04-10 11:45:04'),
(3, 1, 1, 7, '2026-04-13', '18:53:29', 'hadir', 'manual', NULL, NULL, 'approved', 3, '2026-04-20 09:34:04', '2026-04-10 11:53:29', '2026-04-20 09:34:04'),
(4, 1, 2, 9, '2026-04-15', '19:17:57', 'hadir', 'manual', NULL, NULL, 'approved', 4, '2026-04-10 12:17:57', '2026-04-10 12:17:57', '2026-04-10 12:17:57'),
(5, 2, 2, 9, '2026-04-15', '19:17:57', 'hadir', 'manual', NULL, NULL, 'approved', 4, '2026-04-10 12:17:57', '2026-04-10 12:17:57', '2026-04-10 12:17:57'),
(6, 3, 2, 9, '2026-04-15', '19:17:57', 'hadir', 'manual', NULL, NULL, 'approved', 4, '2026-04-10 12:17:57', '2026-04-10 12:17:57', '2026-04-10 12:17:57'),
(7, 1, 5, 16, '2026-04-13', '13:34:34', 'telat', 'faceid', 40.34, NULL, 'approved', 8, '2026-04-20 10:19:22', '2026-04-10 12:19:03', '2026-04-20 10:19:22'),
(8, 2, 5, 12, '2026-04-13', '19:24:48', 'telat', 'faceid', 41.66, NULL, 'approved', 8, '2026-04-12 22:43:34', '2026-04-10 12:19:05', '2026-04-12 22:43:34'),
(9, 3, 5, 10, '2026-04-13', NULL, 'izin', 'manual', NULL, NULL, 'approved', 8, '2026-04-12 22:43:35', '2026-04-10 12:19:11', '2026-04-12 22:43:35'),
(32, 4, 5, 14, '2026-04-13', '05:29:13', 'hadir', 'faceid', 44.62, NULL, 'approved', 8, '2026-04-19 02:34:39', '2026-04-12 22:29:13', '2026-04-19 02:34:39'),
(33, 4, 2, 42, '2026-04-22', '16:33:45', 'telat', 'faceid', 6.69, NULL, 'auto_valid', NULL, NULL, '2026-04-19 02:41:20', '2026-04-22 09:33:45'),
(34, 1, 2, 42, '2026-04-22', '16:33:40', 'telat', 'faceid', 22.10, NULL, 'auto_valid', NULL, NULL, '2026-04-19 02:41:31', '2026-04-22 09:33:40'),
(35, 1, 5, 34, '2026-04-20', '07:30:58', 'telat', 'faceid', 6.20, NULL, 'auto_valid', 8, '2026-04-20 10:19:14', '2026-04-20 08:48:07', '2026-04-21 00:30:58'),
(36, 1, 1, 23, '2026-04-20', '17:04:01', 'telat', 'barcode', NULL, NULL, 'auto_valid', NULL, NULL, '2026-04-20 10:04:01', '2026-04-20 10:04:01'),
(41, 2, 5, 26, '2026-04-20', '17:18:38', 'telat', 'barcode', NULL, NULL, 'approved', 8, '2026-04-20 10:19:19', '2026-04-20 10:18:38', '2026-04-20 10:19:19'),
(42, 6, 2, 36, '2026-04-22', '07:34:10', 'hadir', 'faceid', 19.45, NULL, 'auto_valid', NULL, NULL, '2026-04-21 00:32:24', '2026-04-21 00:34:10'),
(43, 5, 2, 36, '2026-04-22', '07:34:10', 'hadir', 'faceid', 5.50, NULL, 'auto_valid', NULL, NULL, '2026-04-21 00:34:10', '2026-04-21 00:34:10'),
(44, 3, 5, 33, '2026-04-20', NULL, 'tidak_hadir', 'auto', NULL, NULL, 'auto_valid', NULL, NULL, '2026-04-21 01:38:03', '2026-04-21 01:38:03'),
(45, 4, 5, 33, '2026-04-20', NULL, 'tidak_hadir', 'auto', NULL, NULL, 'auto_valid', NULL, NULL, '2026-04-21 01:38:03', '2026-04-21 01:38:03'),
(46, 5, 5, 33, '2026-04-20', NULL, 'tidak_hadir', 'auto', NULL, NULL, 'auto_valid', NULL, NULL, '2026-04-21 01:38:03', '2026-04-21 01:38:03'),
(47, 6, 5, 33, '2026-04-20', NULL, 'tidak_hadir', 'auto', NULL, NULL, 'auto_valid', NULL, NULL, '2026-04-21 01:38:03', '2026-04-21 01:38:03'),
(48, 1, 4, 40, '2026-04-21', '15:42:28', 'hadir', 'barcode', NULL, NULL, 'auto_valid', NULL, NULL, '2026-04-21 08:42:28', '2026-04-21 08:42:28'),
(49, 2, 4, 40, '2026-04-21', '15:43:06', 'hadir', 'barcode', NULL, NULL, 'auto_valid', NULL, NULL, '2026-04-21 08:43:06', '2026-04-21 08:43:06'),
(56, 1, 5, 63, '2026-04-25', '06:08:39', 'hadir', 'faceid', 20.23, 'storage/snapshots/2026/04/mhs1_ses56_1777283593.jpg', 'auto_valid', 8, '2026-04-25 08:38:15', '2026-04-25 04:44:24', '2026-04-29 23:08:39'),
(57, 2, 5, 55, '2026-04-25', NULL, 'izin', 'manual', NULL, NULL, 'rejected', 8, '2026-04-27 12:46:20', '2026-04-25 04:45:15', '2026-04-27 12:46:20'),
(58, 3, 5, 55, '2026-04-25', NULL, 'sakit', 'manual', NULL, NULL, 'approved', 8, '2026-04-27 09:48:32', '2026-04-25 05:04:21', '2026-04-27 09:48:32'),
(60, 5, 5, 55, '2026-04-25', NULL, 'izin', 'manual', NULL, NULL, 'approved', 8, '2026-04-27 09:48:28', '2026-04-25 07:56:45', '2026-04-27 09:48:28'),
(61, 6, 5, 55, '2026-04-25', NULL, 'tidak_hadir', 'manual', NULL, NULL, 'approved', 8, '2026-04-27 09:48:29', '2026-04-25 07:56:53', '2026-04-27 09:48:29'),
(62, 4, 5, 55, '2026-04-25', NULL, 'sakit', 'manual', NULL, NULL, 'approved', 8, '2026-04-27 09:48:29', '2026-04-25 07:56:55', '2026-04-27 09:48:29'),
(63, 9, 2, 65, '2026-05-06', '12:45:13', 'hadir', 'faceid', 81.79, NULL, 'auto_valid', NULL, NULL, '2026-05-04 05:36:00', '2026-05-04 05:45:13'),
(64, 1, 2, 65, '2026-05-06', '12:45:27', 'hadir', 'faceid', 80.29, NULL, 'auto_valid', NULL, NULL, '2026-05-04 05:36:42', '2026-05-04 05:45:27'),
(65, 2, 2, 65, '2026-05-06', '12:45:11', 'hadir', 'faceid', 83.25, NULL, 'auto_valid', NULL, NULL, '2026-05-04 05:43:48', '2026-05-04 05:45:11'),
(66, 9, 5, 63, '2026-04-25', '07:18:44', 'hadir', 'faceid', 9.38, NULL, 'auto_valid', NULL, NULL, '2026-05-12 00:18:44', '2026-05-12 00:18:44'),
(67, 1, 5, 68, '2026-05-16', '17:50:02', 'hadir', 'faceid', 88.24, NULL, 'auto_valid', NULL, NULL, '2026-05-12 07:23:56', '2026-05-13 10:50:02'),
(68, 9, 5, 66, '2026-05-16', '14:25:33', 'hadir', 'faceid', 80.82, NULL, 'auto_valid', NULL, NULL, '2026-05-12 07:25:33', '2026-05-12 07:25:33'),
(69, 2, 5, 66, '2026-05-16', '14:26:56', 'hadir', 'faceid', 82.93, NULL, 'approved', 8, '2026-05-12 08:13:26', '2026-05-12 07:26:56', '2026-05-12 08:13:26'),
(70, 6, 5, 66, '2026-05-16', '14:47:44', 'hadir', 'faceid', 78.85, NULL, 'auto_valid', NULL, NULL, '2026-05-12 07:47:44', '2026-05-12 07:47:44'),
(71, 1, 7, 69, '2026-05-18', '19:23:09', 'hadir', 'faceid', 84.96, NULL, 'auto_valid', NULL, NULL, '2026-05-13 12:23:09', '2026-05-13 12:23:09'),
(72, 1, 7, 74, '2026-05-25', '14:01:54', 'hadir', 'faceid', 94.49, NULL, 'auto_valid', NULL, NULL, '2026-05-19 05:43:25', '2026-05-19 07:01:54'),
(73, 1, 5, 71, '2026-05-23', '13:06:23', 'hadir', 'faceid', 94.45, NULL, 'auto_valid', NULL, NULL, '2026-05-19 06:06:23', '2026-05-19 06:06:23'),
(74, 1, 8, 75, '2026-06-15', '14:12:53', 'hadir', 'faceid', 91.84, NULL, 'auto_valid', NULL, NULL, '2026-06-15 07:12:53', '2026-06-15 07:12:53');

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `activity_type` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `activity_type`, `description`, `ip_address`, `user_agent`, `meta`, `created_at`, `updated_at`) VALUES
(1, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 04:36:43', '2026-04-10 04:36:43'),
(2, 1, 'face_reset', 'Admin reset data wajah user: admin@siakad.test', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 04:36:57', '2026-04-10 04:36:57'),
(3, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 04:37:31', '2026-04-10 04:37:31'),
(4, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 04:38:39', '2026-04-10 04:38:39'),
(5, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 04:50:36', '2026-04-10 04:50:36'),
(6, 1, 'face_reset', 'Admin reset data wajah user: admin@siakad.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 04:51:13', '2026-04-10 04:51:13'),
(7, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 04:51:37', '2026-04-10 04:51:37'),
(8, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 04:55:23', '2026-04-10 04:55:23'),
(9, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 05:06:11', '2026-04-10 05:06:11'),
(10, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:21:45', '2026-04-10 07:21:45'),
(11, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:29:09', '2026-04-10 07:29:09'),
(12, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:31:59', '2026-04-10 07:31:59'),
(13, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:32:31', '2026-04-10 07:32:31'),
(14, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:38:41', '2026-04-10 07:38:41'),
(15, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:39:30', '2026-04-10 07:39:30'),
(16, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:48:58', '2026-04-10 07:48:58'),
(17, 1, 'face_reset', 'Admin reset data wajah user: andhika123@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:49:13', '2026-04-10 07:49:13'),
(18, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:49:36', '2026-04-10 07:49:36'),
(19, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:50:42', '2026-04-10 07:50:42'),
(20, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:50:51', '2026-04-10 07:50:51'),
(21, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:50:54', '2026-04-10 07:50:54'),
(22, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:51:17', '2026-04-10 07:51:17'),
(23, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 07:58:08', '2026-04-10 07:58:08'),
(24, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 08:07:22', '2026-04-10 08:07:22'),
(25, 3, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 08:10:55', '2026-04-10 08:10:55'),
(26, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #1 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 08:11:17', '2026-04-10 08:11:17'),
(27, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #1 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 08:11:52', '2026-04-10 08:11:52'),
(28, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #1 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 08:30:09', '2026-04-10 08:30:09'),
(29, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #1 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 08:37:34', '2026-04-10 08:37:34'),
(30, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 08:38:13', '2026-04-10 08:38:13'),
(31, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 10:12:22', '2026-04-10 10:12:22'),
(32, 6, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 10:14:55', '2026-04-10 10:14:55'),
(33, 6, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 10:15:06', '2026-04-10 10:15:06'),
(34, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 10:16:36', '2026-04-10 10:16:36'),
(35, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 10:48:09', '2026-04-10 10:48:09'),
(36, 6, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 10:49:16', '2026-04-10 10:49:16'),
(37, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:07:04', '2026-04-10 11:07:04'),
(38, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:13:19', '2026-04-10 11:13:19'),
(39, 6, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:14:50', '2026-04-10 11:14:50'),
(40, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:15:57', '2026-04-10 11:15:57'),
(41, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:22:13', '2026-04-10 11:22:13'),
(42, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:22:34', '2026-04-10 11:22:34'),
(43, 6, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:32:38', '2026-04-10 11:32:38'),
(44, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:33:16', '2026-04-10 11:33:16'),
(45, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:43:32', '2026-04-10 11:43:32'),
(46, 3, 'dosen_manual_absensi', 'Dosen menyimpan absensi manual untuk sesi #6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:44:25', '2026-04-10 11:44:25'),
(47, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #2 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:45:04', '2026-04-10 11:45:04'),
(48, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #1 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:45:05', '2026-04-10 11:45:05'),
(49, 3, 'dosen_manual_hadir', 'Dosen menyimpan absensi manual (ceklis hadir) untuk sesi #7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:53:29', '2026-04-10 11:53:29'),
(50, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:54:04', '2026-04-10 11:54:04'),
(51, 6, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:54:26', '2026-04-10 11:54:26'),
(52, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:55:11', '2026-04-10 11:55:11'),
(53, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 11:59:50', '2026-04-10 11:59:50'),
(54, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:02:55', '2026-04-10 12:02:55'),
(55, 6, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:04:18', '2026-04-10 12:04:18'),
(56, 7, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:04:50', '2026-04-10 12:04:50'),
(57, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:05:17', '2026-04-10 12:05:17'),
(58, 9, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:07:30', '2026-04-10 12:07:30'),
(59, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:10:48', '2026-04-10 12:10:48'),
(60, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:11:14', '2026-04-10 12:11:14'),
(61, 6, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:12:40', '2026-04-10 12:12:40'),
(62, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:13:24', '2026-04-10 12:13:24'),
(63, 4, 'dosen_manual_hadir', 'Dosen menyimpan absensi manual (ceklis hadir) untuk sesi #9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:17:57', '2026-04-10 12:17:57'),
(64, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:18:24', '2026-04-10 12:18:24'),
(65, 8, 'dosen_manual_hadir', 'Dosen menyimpan absensi manual (ceklis hadir) untuk sesi #10', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:03', '2026-04-10 12:19:03'),
(66, 8, 'dosen_manual_status', 'Dosen set status absensi manual tidak_hadir untuk mahasiswa #2 (sesi #10)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:05', '2026-04-10 12:19:05'),
(67, 8, 'dosen_manual_status', 'Dosen set status absensi manual tidak_hadir untuk mahasiswa #3 (sesi #10)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:11', '2026-04-10 12:19:11'),
(68, 8, 'dosen_manual_status', 'Dosen set status absensi manual sakit untuk mahasiswa #3 (sesi #10)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:13', '2026-04-10 12:19:13'),
(69, 8, 'dosen_manual_status', 'Dosen set status absensi manual izin untuk mahasiswa #3 (sesi #10)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:15', '2026-04-10 12:19:15'),
(70, 8, 'dosen_manual_status', 'Dosen set status absensi manual izin untuk mahasiswa #2 (sesi #10)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:17', '2026-04-10 12:19:17'),
(71, 8, 'dosen_manual_status', 'Dosen set status absensi manual tidak_hadir untuk mahasiswa #2 (sesi #10)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:19', '2026-04-10 12:19:19'),
(72, 8, 'dosen_manual_hadir', 'Dosen menyimpan absensi manual (ceklis hadir) untuk sesi #10', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:21', '2026-04-10 12:19:21'),
(73, 8, 'dosen_manual_hadir', 'Dosen menyimpan absensi manual (ceklis hadir) untuk sesi #10', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:19:24', '2026-04-10 12:19:24'),
(74, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Krisna Halim', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:24:48', '2026-04-10 12:24:48'),
(75, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 12:24:58', '2026-04-10 12:24:58'),
(76, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 21:42:40', '2026-04-10 21:42:40'),
(77, 1, 'face_reset', 'Admin reset data wajah user: halim123@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 21:42:51', '2026-04-10 21:42:51'),
(78, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-10 21:46:41', '2026-04-10 21:46:41'),
(79, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:05:54', '2026-04-12 22:05:54'),
(80, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:06:42', '2026-04-12 22:06:42'),
(81, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:08:02', '2026-04-12 22:08:02'),
(82, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #9 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:11:00', '2026-04-12 22:11:00'),
(83, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #8 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:11:01', '2026-04-12 22:11:01'),
(84, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #9 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:11:03', '2026-04-12 22:11:03'),
(85, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #9 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:11:10', '2026-04-12 22:11:10'),
(86, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #9 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:11:11', '2026-04-12 22:11:11'),
(87, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:24:06', '2026-04-12 22:24:06'),
(88, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:24:38', '2026-04-12 22:24:38'),
(89, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:24:58', '2026-04-12 22:24:58'),
(90, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:27:13', '2026-04-12 22:27:13'),
(91, 10, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:27:38', '2026-04-12 22:27:38'),
(92, 10, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:28:14', '2026-04-12 22:28:14'),
(93, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:28:45', '2026-04-12 22:28:45'),
(94, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:29:10', '2026-04-12 22:29:10'),
(95, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Irvin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:29:13', '2026-04-12 22:29:13'),
(96, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #7 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:20', '2026-04-12 22:43:20'),
(97, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #8 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:22', '2026-04-12 22:43:22'),
(98, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #32 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:24', '2026-04-12 22:43:24'),
(99, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #8 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:27', '2026-04-12 22:43:27'),
(100, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #32 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:28', '2026-04-12 22:43:28'),
(101, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #7 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:30', '2026-04-12 22:43:30'),
(102, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #9 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:31', '2026-04-12 22:43:31'),
(103, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #32 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:32', '2026-04-12 22:43:32'),
(104, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #7 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:33', '2026-04-12 22:43:33'),
(105, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #8 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:34', '2026-04-12 22:43:34'),
(106, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #9 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:43:35', '2026-04-12 22:43:35'),
(107, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 22:50:00', '2026-04-12 22:50:00'),
(108, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 23:41:50', '2026-04-12 23:41:50'),
(109, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 23:44:58', '2026-04-12 23:44:58'),
(110, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-12 23:46:14', '2026-04-12 23:46:14'),
(111, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-13 00:04:01', '2026-04-13 00:04:01'),
(112, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-13 01:44:44', '2026-04-13 01:44:44'),
(113, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-13 02:01:39', '2026-04-13 02:01:39'),
(114, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', NULL, '2026-04-13 04:01:00', '2026-04-13 04:01:00'),
(115, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-15 06:32:04', '2026-04-15 06:32:04'),
(116, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-15 06:32:55', '2026-04-15 06:32:55'),
(117, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-15 06:34:34', '2026-04-15 06:34:34'),
(118, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:33:49', '2026-04-19 02:33:49'),
(119, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #32 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:34:39', '2026-04-19 02:34:39'),
(120, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:35:29', '2026-04-19 02:35:29'),
(121, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #1 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:35:42', '2026-04-19 02:35:42'),
(122, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #1 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:35:44', '2026-04-19 02:35:44'),
(123, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:35:57', '2026-04-19 02:35:57'),
(124, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:36:20', '2026-04-19 02:36:20'),
(125, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Irvin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:41:20', '2026-04-19 02:41:20'),
(126, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:41:31', '2026-04-19 02:41:31'),
(127, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-19 02:42:37', '2026-04-19 02:42:37'),
(128, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 08:43:48', '2026-04-20 08:43:48'),
(129, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 08:47:33', '2026-04-20 08:47:33'),
(130, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 08:48:07', '2026-04-20 08:48:07'),
(131, 3, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 08:48:31', '2026-04-20 08:48:31'),
(132, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #3 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 09:14:31', '2026-04-20 09:14:31'),
(133, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #3 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 09:14:33', '2026-04-20 09:14:33'),
(134, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #3 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 09:33:52', '2026-04-20 09:33:52'),
(135, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #3 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 09:34:04', '2026-04-20 09:34:04'),
(136, 3, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #1 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 09:34:06', '2026-04-20 09:34:06'),
(137, 2, 'login', 'User login ke sistem.', '192.168.1.9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', NULL, '2026-04-20 10:04:00', '2026-04-20 10:04:00'),
(138, 2, 'barcode_scan_success', 'Absensi barcode berhasil untuk MK: Basis Data', '192.168.1.9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '{\"session_id\":23,\"mata_kuliah_id\":1}', '2026-04-20 10:04:01', '2026-04-20 10:04:01'),
(139, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 10:16:57', '2026-04-20 10:16:57'),
(140, 6, 'barcode_scan_success', 'Absensi barcode berhasil untuk MK: Pemrograman Bergerak', '192.168.1.9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '{\"session_id\":26,\"mata_kuliah_id\":5}', '2026-04-20 10:18:38', '2026-04-20 10:18:38'),
(141, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #35 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 10:19:14', '2026-04-20 10:19:14'),
(142, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #41 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 10:19:19', '2026-04-20 10:19:19'),
(143, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #7 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 10:19:22', '2026-04-20 10:19:22'),
(144, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 21:38:58', '2026-04-20 21:38:58'),
(145, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 21:44:28', '2026-04-20 21:44:28'),
(146, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 22:53:21', '2026-04-20 22:53:21'),
(147, 11, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 22:54:57', '2026-04-20 22:54:57'),
(148, 11, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 22:55:13', '2026-04-20 22:55:13'),
(149, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 22:55:27', '2026-04-20 22:55:27'),
(150, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 22:57:50', '2026-04-20 22:57:50'),
(151, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:01:59', '2026-04-20 23:01:59'),
(152, 12, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:03:31', '2026-04-20 23:03:31'),
(153, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:04:58', '2026-04-20 23:04:58'),
(154, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:06:46', '2026-04-20 23:06:46'),
(155, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:07:37', '2026-04-20 23:07:37'),
(156, 12, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:08:40', '2026-04-20 23:08:40'),
(157, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:10:51', '2026-04-20 23:10:51'),
(158, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:15:15', '2026-04-20 23:15:15'),
(159, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:46:32', '2026-04-20 23:46:32'),
(160, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-20 23:47:19', '2026-04-20 23:47:19'),
(161, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:05:29', '2026-04-21 00:05:29'),
(162, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:06:47', '2026-04-21 00:06:47'),
(163, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:08:12', '2026-04-21 00:08:12'),
(164, 12, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:29:59', '2026-04-21 00:29:59'),
(165, 12, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:30:11', '2026-04-21 00:30:11'),
(166, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:30:36', '2026-04-21 00:30:36'),
(167, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:30:58', '2026-04-21 00:30:58'),
(168, 12, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:31:17', '2026-04-21 00:31:17'),
(169, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:31:42', '2026-04-21 00:31:42'),
(170, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Febri Brilian Barkah', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:32:24', '2026-04-21 00:32:24'),
(171, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:32:24', '2026-04-21 00:32:24'),
(172, 11, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:32:51', '2026-04-21 00:32:51'),
(173, 9, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:33:17', '2026-04-21 00:33:17'),
(174, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:33:45', '2026-04-21 00:33:45'),
(175, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Febri Brilian Barkah', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:34:10', '2026-04-21 00:34:10'),
(176, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Ahmad Zam Zami', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:34:10', '2026-04-21 00:34:10'),
(177, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 00:34:10', '2026-04-21 00:34:10'),
(178, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 01:37:44', '2026-04-21 01:37:44'),
(179, 8, 'session_closed_auto_alpha', 'Sesi #33 ditutup. Auto alpha untuk 4 mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', '{\"session_id\":33,\"mata_kuliah_id\":5,\"tanggal\":\"2026-04-20\",\"auto_alpha_count\":4}', '2026-04-21 01:38:03', '2026-04-21 01:38:03'),
(180, 8, 'session_closed_auto_alpha', 'Sesi #34 ditutup. Auto alpha untuk 0 mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', '{\"session_id\":34,\"mata_kuliah_id\":5,\"tanggal\":\"2026-04-20\",\"auto_alpha_count\":0}', '2026-04-21 01:38:14', '2026-04-21 01:38:14'),
(181, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 02:01:18', '2026-04-21 02:01:18'),
(182, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 02:06:22', '2026-04-21 02:06:22'),
(183, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 02:07:42', '2026-04-21 02:07:42'),
(184, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 02:08:14', '2026-04-21 02:08:14'),
(185, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 02:16:39', '2026-04-21 02:16:39'),
(186, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 04:57:29', '2026-04-21 04:57:29'),
(187, 8, 'session_closed_auto_alpha', 'Sesi #37 ditutup. Auto alpha untuk 0 mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', '{\"session_id\":37,\"mata_kuliah_id\":5,\"tanggal\":\"2026-04-20\",\"auto_alpha_count\":0}', '2026-04-21 07:29:52', '2026-04-21 07:29:52'),
(188, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 07:30:12', '2026-04-21 07:30:12'),
(189, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:08:40', '2026-04-21 08:08:40'),
(190, 8, 'session_closed_auto_alpha', 'Sesi #38 ditutup. Auto alpha untuk 0 mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', '{\"session_id\":38,\"mata_kuliah_id\":5,\"tanggal\":\"2026-04-20\",\"auto_alpha_count\":0}', '2026-04-21 08:36:57', '2026-04-21 08:36:57'),
(191, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:37:13', '2026-04-21 08:37:13'),
(192, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:38:57', '2026-04-21 08:38:57'),
(193, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:39:30', '2026-04-21 08:39:30');
INSERT INTO `activity_logs` (`id`, `user_id`, `activity_type`, `description`, `ip_address`, `user_agent`, `meta`, `created_at`, `updated_at`) VALUES
(194, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:39:53', '2026-04-21 08:39:53'),
(195, 8, 'session_closed_auto_alpha', 'Sesi #39 ditutup. Auto alpha untuk 0 mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', '{\"session_id\":39,\"mata_kuliah_id\":5,\"tanggal\":\"2026-04-20\",\"auto_alpha_count\":0}', '2026-04-21 08:41:00', '2026-04-21 08:41:00'),
(196, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:41:10', '2026-04-21 08:41:10'),
(197, 9, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:41:38', '2026-04-21 08:41:38'),
(198, 2, 'barcode_scan_success', 'Absensi barcode berhasil untuk MK: Big Data', '192.168.1.9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '{\"session_id\":40,\"mata_kuliah_id\":4}', '2026-04-21 08:42:28', '2026-04-21 08:42:28'),
(199, 6, 'barcode_scan_success', 'Absensi barcode berhasil untuk MK: Big Data', '192.168.1.9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '{\"session_id\":40,\"mata_kuliah_id\":4}', '2026-04-21 08:43:06', '2026-04-21 08:43:06'),
(200, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:44:03', '2026-04-21 08:44:03'),
(201, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:53:30', '2026-04-21 08:53:30'),
(202, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:56:00', '2026-04-21 08:56:00'),
(203, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:57:02', '2026-04-21 08:57:02'),
(204, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 08:57:50', '2026-04-21 08:57:50'),
(205, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 22:28:16', '2026-04-21 22:28:16'),
(206, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 22:28:55', '2026-04-21 22:28:55'),
(207, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-21 22:29:41', '2026-04-21 22:29:41'),
(208, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-22 09:33:40', '2026-04-22 09:33:40'),
(209, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Irvin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-22 09:33:45', '2026-04-22 09:33:45'),
(210, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 04:31:22', '2026-04-25 04:31:22'),
(211, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 04:42:05', '2026-04-25 04:42:05'),
(212, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 04:42:55', '2026-04-25 04:42:55'),
(213, 2, 'login', 'User login ke sistem.', '36.73.209.97', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Mobile Safari/537.36', NULL, '2026-04-25 04:44:09', '2026-04-25 04:44:09'),
(214, 2, 'barcode_scan_success', 'Absensi barcode (HP) berhasil untuk MK: Pemrograman Bergerak', '36.73.209.97', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Mobile Safari/537.36', '{\"session_id\":44,\"mata_kuliah_id\":5}', '2026-04-25 04:44:24', '2026-04-25 04:44:24'),
(215, 6, 'barcode_scan_success', 'Absensi barcode (HP) berhasil untuk MK: Pemrograman Bergerak', '36.73.209.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', '{\"session_id\":44,\"mata_kuliah_id\":5}', '2026-04-25 04:45:15', '2026-04-25 04:45:15'),
(216, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 04:57:28', '2026-04-25 04:57:28'),
(217, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 04:58:09', '2026-04-25 04:58:09'),
(218, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 04:59:49', '2026-04-25 04:59:49'),
(219, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 05:03:38', '2026-04-25 05:03:38'),
(220, 7, 'login', 'User login ke sistem.', '36.73.209.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 05:04:15', '2026-04-25 05:04:15'),
(221, 7, 'barcode_scan_success', 'Absensi barcode (HP) berhasil untuk MK: Pemrograman Bergerak', '36.73.209.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', '{\"session_id\":44,\"mata_kuliah_id\":5}', '2026-04-25 05:04:21', '2026-04-25 05:04:21'),
(222, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 05:13:03', '2026-04-25 05:13:03'),
(223, NULL, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 05:14:25', '2026-04-25 05:14:25'),
(224, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 05:14:57', '2026-04-25 05:14:57'),
(225, NULL, 'barcode_scan_success', 'Absensi barcode (HP) berhasil untuk MK: Pemrograman Bergerak', '2404:c0:3477:7788:f92b:89a4:d882:35d', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '{\"session_id\":44,\"mata_kuliah_id\":5}', '2026-04-25 05:17:30', '2026-04-25 05:17:30'),
(226, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:52:10', '2026-04-25 07:52:10'),
(227, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:56:21', '2026-04-25 07:56:21'),
(228, 8, 'dosen_status_pasca_tutup', 'Dosen set status izin pasca-tutup untuk mahasiswa #5 (sesi #49)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:56:45', '2026-04-25 07:56:45'),
(229, 8, 'dosen_status_pasca_tutup', 'Dosen set status sakit pasca-tutup untuk mahasiswa #7 (sesi #49)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:56:47', '2026-04-25 07:56:47'),
(230, 8, 'dosen_status_pasca_tutup', 'Dosen set status izin pasca-tutup untuk mahasiswa #6 (sesi #49)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:56:53', '2026-04-25 07:56:53'),
(231, 8, 'dosen_status_pasca_tutup', 'Dosen set status izin pasca-tutup untuk mahasiswa #4 (sesi #49)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:56:55', '2026-04-25 07:56:55'),
(232, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #4 (sesi #49)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:56:57', '2026-04-25 07:56:57'),
(233, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #2 (sesi #49)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:56:59', '2026-04-25 07:56:59'),
(234, 8, 'dosen_status_pasca_tutup', 'Dosen set status izin pasca-tutup untuk mahasiswa #3 (sesi #49)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 07:57:00', '2026-04-25 07:57:00'),
(235, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:04:19', '2026-04-25 08:04:19'),
(236, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #61 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:13:00', '2026-04-25 08:13:00'),
(237, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:13:45', '2026-04-25 08:13:45'),
(238, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:33:28', '2026-04-25 08:33:28'),
(239, 8, 'dosen_status_pasca_tutup', 'Dosen set status izin pasca-tutup untuk mahasiswa #5 (sesi #50)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:34:51', '2026-04-25 08:34:51'),
(240, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #5 (sesi #50)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:34:54', '2026-04-25 08:34:54'),
(241, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #7 (sesi #50)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:34:56', '2026-04-25 08:34:56'),
(242, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #6 (sesi #50)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:34:59', '2026-04-25 08:34:59'),
(243, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #4 (sesi #50)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:35:00', '2026-04-25 08:35:00'),
(244, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #2 (sesi #50)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:35:00', '2026-04-25 08:35:00'),
(245, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #3 (sesi #50)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:35:01', '2026-04-25 08:35:01'),
(246, 8, 'dosen_manual_hadir', 'Dosen menyimpan absensi manual (ceklis hadir) untuk sesi #51', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:38:15', '2026-04-25 08:38:15'),
(247, 8, 'dosen_manual_status', 'Dosen set status absensi manual izin untuk mahasiswa #5 (sesi #51)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:40:58', '2026-04-25 08:40:58'),
(248, 8, 'dosen_manual_status', 'Dosen set status absensi manual sakit untuk mahasiswa #6 (sesi #51)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:41:01', '2026-04-25 08:41:01'),
(249, 8, 'dosen_manual_status', 'Dosen set status absensi manual tidak_hadir untuk mahasiswa #4 (sesi #51)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:41:02', '2026-04-25 08:41:02'),
(250, 8, 'dosen_manual_status', 'Dosen set status absensi manual telat untuk mahasiswa #2 (sesi #51)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:41:02', '2026-04-25 08:41:02'),
(251, 8, 'dosen_manual_status', 'Dosen set status absensi manual telat untuk mahasiswa #3 (sesi #51)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 08:41:03', '2026-04-25 08:41:03'),
(252, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 09:26:37', '2026-04-25 09:26:37'),
(253, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 09:31:37', '2026-04-25 09:31:37'),
(254, 8, 'login', 'User login ke sistem.', '110.136.117.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-25 15:33:36', '2026-04-25 15:33:36'),
(255, 2, 'login', 'User login ke sistem.', '114.10.155.51', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Mobile Safari/537.36', NULL, '2026-04-25 15:34:26', '2026-04-25 15:34:26'),
(256, 8, 'login', 'User login ke sistem.', '182.253.32.250', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:35:27', '2026-04-27 09:35:27'),
(257, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:38:41', '2026-04-27 09:38:41'),
(258, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:38:55', '2026-04-27 09:38:55'),
(259, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:44:36', '2026-04-27 09:44:36'),
(260, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:46:56', '2026-04-27 09:46:56'),
(261, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:47:41', '2026-04-27 09:47:41'),
(262, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:48:01', '2026-04-27 09:48:01'),
(263, 8, 'dosen_status_pasca_tutup', 'Dosen set status izin pasca-tutup untuk mahasiswa #5 (sesi #55)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:48:28', '2026-04-27 09:48:28'),
(264, 8, 'dosen_status_pasca_tutup', 'Dosen set status sakit pasca-tutup untuk mahasiswa #7 (sesi #55)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:48:28', '2026-04-27 09:48:28'),
(265, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #6 (sesi #55)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:48:29', '2026-04-27 09:48:29'),
(266, 8, 'dosen_status_pasca_tutup', 'Dosen set status tidak_hadir pasca-tutup untuk mahasiswa #4 (sesi #55)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:48:29', '2026-04-27 09:48:29'),
(267, 8, 'dosen_status_pasca_tutup', 'Dosen set status sakit pasca-tutup untuk mahasiswa #4 (sesi #55)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:48:29', '2026-04-27 09:48:29'),
(268, 8, 'dosen_status_pasca_tutup', 'Dosen set status izin pasca-tutup untuk mahasiswa #2 (sesi #55)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:48:31', '2026-04-27 09:48:31'),
(269, 8, 'dosen_status_pasca_tutup', 'Dosen set status sakit pasca-tutup untuk mahasiswa #3 (sesi #55)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:48:32', '2026-04-27 09:48:32'),
(270, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:53:13', '2026-04-27 09:53:13'),
(271, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:54:10', '2026-04-27 09:54:10'),
(272, 15, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 09:57:22', '2026-04-27 09:57:22'),
(273, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:06:54', '2026-04-27 10:06:54'),
(274, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:07:23', '2026-04-27 10:07:23'),
(275, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-27 10:08:52', '2026-04-27 10:08:52'),
(276, 1, 'admin_force_close_session', 'Admin menutup paksa sesi #56 (Pemrograman Bergerak)', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:09:12', '2026-04-27 10:09:12'),
(277, 1, 'face_reset', 'Admin reset data wajah user: andhika123@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:09:16', '2026-04-27 10:09:16'),
(278, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-27 10:23:43', '2026-04-27 10:23:43'),
(279, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:26:49', '2026-04-27 10:26:49'),
(280, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:47:33', '2026-04-27 10:47:33'),
(281, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:47:54', '2026-04-27 10:47:54'),
(282, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:48:35', '2026-04-27 10:48:35'),
(283, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:49:02', '2026-04-27 10:49:02'),
(284, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 10:49:21', '2026-04-27 10:49:21'),
(285, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 11:18:05', '2026-04-27 11:18:05'),
(286, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 11:18:32', '2026-04-27 11:18:32'),
(287, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-27 11:19:22', '2026-04-27 11:19:22'),
(288, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 12:03:57', '2026-04-27 12:03:57'),
(289, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #57 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-27 12:46:15', '2026-04-27 12:46:15'),
(290, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #57 sebagai rejected', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-27 12:46:20', '2026-04-27 12:46:20'),
(291, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:25:08', '2026-04-27 14:25:08'),
(292, 1, 'face_normalize', 'Admin normalisasi embedding: 0 diproses, 4 dilewati.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:30:05', '2026-04-27 14:30:05'),
(293, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:37:50', '2026-04-27 14:37:50'),
(294, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:38:33', '2026-04-27 14:38:33'),
(295, 1, 'face_reset', 'Admin reset data wajah user: andhika123@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:38:46', '2026-04-27 14:38:46'),
(296, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:39:06', '2026-04-27 14:39:06'),
(297, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:39:43', '2026-04-27 14:39:43'),
(298, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:40:08', '2026-04-27 14:40:08'),
(299, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:41:09', '2026-04-27 14:41:09'),
(300, 1, 'face_normalize', 'Admin normalisasi embedding: 0 diproses, 4 dilewati.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:41:13', '2026-04-27 14:41:13'),
(301, 1, 'face_normalize', 'Admin normalisasi embedding: 0 diproses, 4 dilewati.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:42:06', '2026-04-27 14:42:06'),
(302, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-27 14:42:26', '2026-04-27 14:42:26'),
(303, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-27 14:53:13', '2026-04-27 14:53:13'),
(304, 11, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-29 22:58:38', '2026-04-29 22:58:38'),
(305, 11, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-29 23:05:48', '2026-04-29 23:05:48'),
(306, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-29 23:06:23', '2026-04-29 23:06:23'),
(307, 1, 'face_reset', 'Admin reset data wajah user: zami@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-29 23:06:28', '2026-04-29 23:06:28'),
(308, NULL, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-29 23:07:11', '2026-04-29 23:07:11'),
(309, NULL, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-29 23:07:49', '2026-04-29 23:07:49'),
(310, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-29 23:08:15', '2026-04-29 23:08:15'),
(311, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-29 23:08:39', '2026-04-29 23:08:39'),
(312, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Azimah Ayu Octaviani', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-29 23:08:50', '2026-04-29 23:08:50'),
(313, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-04-30 06:10:01', '2026-04-30 06:10:01'),
(314, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-04 05:27:37', '2026-05-04 05:27:37'),
(315, 4, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-05-04 05:28:12', '2026-05-04 05:28:12'),
(316, 16, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-04 05:32:58', '2026-05-04 05:32:58'),
(317, 16, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-04 05:34:30', '2026-05-04 05:34:30'),
(318, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Zidan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-05-04 05:36:00', '2026-05-04 05:36:00'),
(319, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-05-04 05:36:42', '2026-05-04 05:36:42'),
(320, 6, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-04 05:40:24', '2026-05-04 05:40:24'),
(321, 6, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-04 05:43:13', '2026-05-04 05:43:13'),
(322, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Krisna Halim', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-05-04 05:43:48', '2026-05-04 05:43:48'),
(323, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Krisna Halim', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-05-04 05:45:11', '2026-05-04 05:45:11'),
(324, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Zidan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-05-04 05:45:13', '2026-05-04 05:45:13'),
(325, 4, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', NULL, '2026-05-04 05:45:27', '2026-05-04 05:45:27'),
(326, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.119.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', NULL, '2026-05-12 00:15:16', '2026-05-12 00:15:16'),
(327, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.119.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', NULL, '2026-05-12 00:16:04', '2026-05-12 00:16:04'),
(328, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 00:17:45', '2026-05-12 00:17:45'),
(329, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Zidan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 00:18:44', '2026-05-12 00:18:44'),
(330, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.119.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', NULL, '2026-05-12 07:19:29', '2026-05-12 07:19:29'),
(331, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 07:19:53', '2026-05-12 07:19:53'),
(332, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.119.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', NULL, '2026-05-12 07:20:54', '2026-05-12 07:20:54'),
(333, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 07:21:12', '2026-05-12 07:21:12'),
(334, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 07:23:56', '2026-05-12 07:23:56'),
(335, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Zidan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 07:25:33', '2026-05-12 07:25:33'),
(336, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Krisna Halim', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 07:26:56', '2026-05-12 07:26:56'),
(337, 1, 'face_reset', 'Admin reset data wajah user: halim123@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.119.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', NULL, '2026-05-12 07:27:27', '2026-05-12 07:27:27'),
(338, 1, 'face_reset', 'Admin reset data wajah user: andhika123@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.119.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', NULL, '2026-05-12 07:47:36', '2026-05-12 07:47:36'),
(339, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Febri Brilian Barkah', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 07:47:44', '2026-05-12 07:47:44'),
(340, 1, 'face_reset', 'Admin reset data wajah user: febri123@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.119.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', NULL, '2026-05-12 07:48:59', '2026-05-12 07:48:59'),
(341, 1, 'face_reset', 'Admin reset data wajah user: Zidan@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.119.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', NULL, '2026-05-12 07:49:03', '2026-05-12 07:49:03'),
(342, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-12 07:50:19', '2026-05-12 07:50:19'),
(343, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-12 08:08:10', '2026-05-12 08:08:10'),
(344, 12, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-12 08:10:14', '2026-05-12 08:10:14'),
(345, 12, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-12 08:11:06', '2026-05-12 08:11:06'),
(346, 8, 'dosen_verifikasi_absensi', 'Dosen memverifikasi absensi #69 sebagai approved', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-12 08:13:26', '2026-05-12 08:13:26'),
(347, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-12 09:04:58', '2026-05-12 09:04:58'),
(348, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 03:00:13', '2026-05-13 03:00:13'),
(349, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 03:27:54', '2026-05-13 03:27:54'),
(350, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-13 03:45:00', '2026-05-13 03:45:00'),
(351, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-05-13 03:47:12', '2026-05-13 03:47:12'),
(352, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 10:49:34', '2026-05-13 10:49:34'),
(353, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 10:50:02', '2026-05-13 10:50:02'),
(354, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 11:04:33', '2026-05-13 11:04:33'),
(355, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 11:05:20', '2026-05-13 11:05:20'),
(356, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 11:09:37', '2026-05-13 11:09:37'),
(357, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 11:15:19', '2026-05-13 11:15:19'),
(358, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 12:01:22', '2026-05-13 12:01:22'),
(359, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 12:14:00', '2026-05-13 12:14:00'),
(360, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 12:21:07', '2026-05-13 12:21:07'),
(361, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 12:22:36', '2026-05-13 12:22:36'),
(362, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 12:22:54', '2026-05-13 12:22:54'),
(363, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-13 12:23:09', '2026-05-13 12:23:09'),
(364, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-19 05:41:43', '2026-05-19 05:41:43'),
(365, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-19 05:42:36', '2026-05-19 05:42:36'),
(366, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-19 05:43:25', '2026-05-19 05:43:25'),
(367, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-19 05:44:13', '2026-05-19 05:44:13'),
(368, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-19 06:06:01', '2026-05-19 06:06:01'),
(369, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-19 06:06:23', '2026-05-19 06:06:23'),
(370, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-19 06:12:45', '2026-05-19 06:12:45'),
(371, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', NULL, '2026-05-19 07:01:54', '2026-05-19 07:01:54'),
(372, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.124.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36', NULL, '2026-06-15 00:01:44', '2026-06-15 00:01:44'),
(373, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.124.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36', NULL, '2026-06-15 07:04:27', '2026-06-15 07:04:27'),
(374, 1, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', NULL, '2026-06-15 07:05:23', '2026-06-15 07:05:23'),
(375, 8, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', NULL, '2026-06-15 07:08:37', '2026-06-15 07:08:37'),
(376, 2, 'login', 'User login ke sistem.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', NULL, '2026-06-15 07:09:54', '2026-06-15 07:09:54'),
(377, 2, 'face_enroll', 'Registrasi/update Face ID via halaman mahasiswa.', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', NULL, '2026-06-15 07:11:39', '2026-06-15 07:11:39'),
(378, 8, 'kiosk_face_checkin', 'Dosen melakukan check-in Face ID kiosk untuk Andhika Kurniawan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', NULL, '2026-06-15 07:12:53', '2026-06-15 07:12:53');

-- --------------------------------------------------------

--
-- Table structure for table `attendance_sessions`
--

CREATE TABLE `attendance_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dosen_id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `mata_kuliah_id` bigint(20) UNSIGNED NOT NULL,
  `method` enum('manual','barcode','faceid') NOT NULL,
  `session_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `barcode_token` varchar(255) DEFAULT NULL,
  `host_ip` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `faceid_opened_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendance_sessions`
--

INSERT INTO `attendance_sessions` (`id`, `dosen_id`, `kelas_id`, `mata_kuliah_id`, `method`, `session_date`, `start_time`, `end_time`, `barcode_token`, `host_ip`, `is_active`, `faceid_opened_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'faceid', '2026-04-10', '09:30:00', '12:00:00', NULL, NULL, 0, NULL, '2026-04-10 07:40:07', '2026-04-10 07:57:44'),
(2, 1, 1, 1, 'faceid', '2026-04-10', '09:30:00', '12:00:00', NULL, NULL, 0, NULL, '2026-04-10 08:08:19', '2026-04-10 08:29:59'),
(3, 1, 1, 1, 'barcode', '2026-04-10', '22:30:00', '23:59:00', 'QN6MFS5DYJ', NULL, 0, NULL, '2026-04-10 08:31:30', '2026-04-10 08:31:57'),
(4, 1, 1, 1, 'manual', '2026-04-10', '22:30:00', '23:59:00', NULL, NULL, 0, NULL, '2026-04-10 08:36:41', '2026-04-10 08:37:20'),
(5, 4, 7, 5, 'manual', '2026-04-06', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-10 11:40:55', '2026-04-10 11:43:19'),
(6, 1, 1, 1, 'manual', '2026-04-06', '09:30:00', '12:03:00', NULL, NULL, 0, NULL, '2026-04-10 11:44:08', '2026-04-10 11:44:41'),
(7, 1, 1, 1, 'manual', '2026-04-13', '09:30:00', '12:03:00', NULL, NULL, 0, NULL, '2026-04-10 11:53:16', '2026-04-10 11:53:39'),
(8, 2, 3, 2, 'manual', '2026-04-15', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-10 12:11:55', '2026-04-10 12:15:58'),
(9, 2, 3, 2, 'manual', '2026-04-15', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-10 12:16:27', '2026-04-10 12:18:10'),
(10, 4, 7, 5, 'manual', '2026-04-13', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-10 12:19:00', '2026-04-10 12:19:31'),
(11, 4, 7, 5, 'faceid', '2026-04-13', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-10 12:20:04', '2026-04-10 12:22:01'),
(12, 4, 7, 5, 'faceid', '2026-04-13', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-10 12:24:43', '2026-04-10 12:25:09'),
(13, 4, 7, 5, 'faceid', '2026-04-13', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-12 22:07:48', '2026-04-12 22:09:04'),
(14, 4, 7, 5, 'faceid', '2026-04-13', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-12 22:29:00', '2026-04-12 22:29:47'),
(15, 2, 3, 2, 'barcode', '2026-04-15', '07:00:00', '09:30:00', 'YI6VUGMMNI', NULL, 0, NULL, '2026-04-12 23:35:40', '2026-04-12 23:36:29'),
(16, 4, 7, 5, 'faceid', '2026-04-13', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-15 06:33:28', '2026-04-15 06:34:59'),
(17, 2, 3, 2, 'manual', '2026-04-22', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-19 02:39:48', '2026-04-19 02:40:01'),
(18, 2, 3, 2, 'faceid', '2026-04-22', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-19 02:40:18', '2026-04-21 00:31:50'),
(19, 4, 7, 5, 'faceid', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-20 08:47:56', '2026-04-20 08:48:17'),
(20, 1, 1, 1, 'barcode', '2026-04-20', '09:30:00', '12:03:00', 'KNJ1MIRDEY', NULL, 0, NULL, '2026-04-20 08:56:46', '2026-04-20 09:02:13'),
(21, 1, 1, 1, 'barcode', '2026-04-20', '09:30:00', '12:03:00', 'BAJHZSYNSX', NULL, 0, NULL, '2026-04-20 09:02:24', '2026-04-20 09:32:31'),
(22, 1, 1, 1, 'barcode', '2026-04-20', '09:30:00', '12:03:00', 'UKEB5DLNEN', NULL, 0, NULL, '2026-04-20 09:32:43', '2026-04-20 09:33:41'),
(23, 1, 1, 1, 'barcode', '2026-04-20', '09:30:00', '12:03:00', 'NPY3ONDZYY', NULL, 0, NULL, '2026-04-20 09:57:13', '2026-04-20 10:15:35'),
(24, 1, 1, 1, 'barcode', '2026-04-20', '09:30:00', '12:03:00', 'L7UMMXY1IE', NULL, 1, NULL, '2026-04-20 10:16:01', '2026-04-20 10:16:01'),
(25, 4, 7, 5, 'manual', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-20 10:17:27', '2026-04-20 10:17:33'),
(26, 4, 7, 5, 'barcode', '2026-04-20', '07:00:00', '09:30:00', 'SIQI2LCSVP', NULL, 0, NULL, '2026-04-20 10:17:43', '2026-04-20 21:39:24'),
(27, 4, 7, 5, 'barcode', '2026-04-20', '07:00:00', '09:30:00', 'OQOSBNOIBV', NULL, 0, NULL, '2026-04-20 21:40:05', '2026-04-20 21:42:57'),
(28, 4, 7, 5, 'faceid', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-20 21:44:17', '2026-04-20 21:44:38'),
(29, 4, 7, 5, 'faceid', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-20 22:55:43', '2026-04-20 22:58:38'),
(30, 4, 7, 5, 'faceid', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-20 23:06:36', '2026-04-20 23:46:02'),
(31, 4, 7, 5, 'faceid', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-20 23:15:09', '2026-04-20 23:15:39'),
(32, 4, 7, 5, 'faceid', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-21 00:08:53', '2026-04-21 00:16:20'),
(33, 4, 7, 5, 'faceid', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-21 00:23:06', '2026-04-21 01:38:03'),
(34, 4, 7, 5, 'faceid', '2026-04-20', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-21 00:30:52', '2026-04-21 01:38:14'),
(35, 2, 3, 2, 'faceid', '2026-04-22', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-21 00:32:18', '2026-04-21 00:32:41'),
(36, 2, 3, 2, 'faceid', '2026-04-22', '07:00:00', '09:30:00', NULL, NULL, 0, NULL, '2026-04-21 00:34:02', '2026-04-22 09:34:37'),
(37, 4, 7, 5, 'barcode', '2026-04-20', '07:00:00', '09:30:00', 'AX2GDHWCY9', NULL, 0, NULL, '2026-04-21 02:17:01', '2026-04-21 07:29:52'),
(38, 4, 7, 5, 'barcode', '2026-04-20', '07:00:00', '09:30:00', 'GTCQGJTVPP', NULL, 0, NULL, '2026-04-21 08:36:09', '2026-04-21 08:36:57'),
(39, 4, 5, 5, 'barcode', '2026-04-20', '21:00:00', '23:59:00', 'CDCVGBRVJA', NULL, 0, NULL, '2026-04-21 08:40:29', '2026-04-21 08:41:00'),
(40, 5, 5, 4, 'barcode', '2026-04-21', '21:00:00', '23:59:00', '42HRAFDNE1', NULL, 1, NULL, '2026-04-21 08:41:56', '2026-04-21 08:41:56'),
(41, 2, 3, 2, 'barcode', '2026-04-22', '12:00:00', '15:30:00', '17U6TGVICZ', NULL, 0, NULL, '2026-04-21 22:30:03', '2026-04-22 09:34:31'),
(42, 2, 3, 2, 'faceid', '2026-04-22', '12:00:00', '15:30:00', NULL, NULL, 0, NULL, '2026-04-22 09:33:22', '2026-04-22 09:34:13'),
(43, 4, 7, 5, 'barcode', '2026-04-27', '07:00:00', '09:30:00', 'LMOXD1DNDS', NULL, 0, NULL, '2026-04-25 04:31:48', '2026-04-25 04:41:44'),
(44, 4, 7, 5, 'barcode', '2026-04-25', '11:00:00', '14:30:00', 'W6MJVOKAHU', NULL, 0, NULL, '2026-04-25 04:43:09', '2026-04-25 07:49:16'),
(45, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-25 07:49:42', '2026-04-25 07:53:04'),
(46, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-25 07:49:54', '2026-04-25 07:52:58'),
(47, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-25 07:50:03', '2026-04-25 07:52:52'),
(48, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-25 07:51:45', '2026-04-25 07:52:33'),
(49, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-25 07:56:12', '2026-04-25 07:56:28'),
(50, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, '2026-04-25 08:04:14', '2026-04-25 08:04:09', '2026-04-25 08:09:35'),
(51, 4, 7, 5, 'manual', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-25 08:35:36', '2026-04-25 08:41:25'),
(52, 4, 7, 5, 'barcode', '2026-04-25', '11:00:00', '14:30:00', 'ZXNPGDZHFU', NULL, 0, NULL, '2026-04-25 09:26:49', '2026-04-25 09:27:06'),
(53, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, '2026-04-27 09:37:24', '2026-04-27 09:37:12', '2026-04-27 09:40:02'),
(54, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, '2026-04-27 09:44:32', '2026-04-27 09:44:30', '2026-04-27 09:46:42'),
(55, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, '2026-04-27 09:47:58', '2026-04-27 09:47:56', '2026-04-27 09:48:25'),
(56, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, '2026-04-27 09:53:09', '2026-04-27 09:53:07', '2026-04-27 10:09:12'),
(57, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-27 10:49:16', '2026-04-27 10:49:32'),
(58, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-27 11:13:39', '2026-04-27 11:45:08'),
(59, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-27 11:52:18', '2026-04-27 12:21:04'),
(60, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-27 12:25:29', '2026-04-27 12:40:58'),
(61, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-04-27 12:41:07', '2026-04-27 15:01:13'),
(62, 4, 7, 5, 'barcode', '2026-05-02', '11:00:00', '14:30:00', 'ZSDFMU2IQS', NULL, 0, NULL, '2026-04-27 12:48:44', '2026-04-27 12:49:18'),
(63, 4, 7, 5, 'faceid', '2026-04-25', '11:00:00', '14:30:00', NULL, NULL, 0, '2026-05-12 07:20:00', '2026-04-27 15:01:39', '2026-05-12 07:22:46'),
(64, 2, 3, 2, 'faceid', '2026-05-06', '12:00:00', '15:30:00', NULL, NULL, 1, NULL, '2026-05-04 05:35:42', '2026-05-04 05:35:42'),
(65, 2, 3, 2, 'faceid', '2026-05-06', '12:00:00', '15:30:00', NULL, NULL, 1, NULL, '2026-05-04 05:45:05', '2026-05-04 05:45:05'),
(66, 4, 7, 5, 'faceid', '2026-05-16', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-05-12 07:23:49', '2026-05-12 08:11:57'),
(67, 4, 7, 5, 'faceid', '2026-05-16', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-05-13 03:45:22', '2026-05-13 10:49:40'),
(68, 4, 7, 5, 'faceid', '2026-05-16', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-05-13 10:49:52', '2026-05-13 12:23:31'),
(69, 4, 7, 7, 'faceid', '2026-05-18', '12:00:00', '15:30:00', NULL, NULL, 0, NULL, '2026-05-13 12:21:43', '2026-05-13 12:23:21'),
(70, 4, 7, 7, 'faceid', '2026-05-25', '12:00:00', '15:30:00', NULL, NULL, 0, NULL, '2026-05-19 05:43:12', '2026-05-19 05:43:36'),
(71, 4, 7, 5, 'faceid', '2026-05-23', '11:00:00', '14:30:00', NULL, NULL, 0, NULL, '2026-05-19 06:06:12', '2026-05-19 06:08:55'),
(72, 4, 7, 7, 'barcode', '2026-05-25', '12:00:00', '15:30:00', 'CWZ1OVOCM7', NULL, 0, NULL, '2026-05-19 06:09:18', '2026-05-19 06:09:26'),
(73, 4, 7, 7, 'faceid', '2026-05-25', '12:00:00', '15:30:00', NULL, NULL, 0, NULL, '2026-05-19 06:12:35', '2026-05-19 06:13:34'),
(74, 4, 7, 7, 'faceid', '2026-05-25', '12:00:00', '15:30:00', NULL, NULL, 0, NULL, '2026-05-19 07:01:31', '2026-05-19 07:02:08'),
(75, 4, 5, 8, 'faceid', '2026-06-15', '13:00:00', '15:30:00', NULL, NULL, 0, NULL, '2026-06-15 07:12:08', '2026-06-15 07:13:16');

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `nidn` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dosen`
--

INSERT INTO `dosen` (`id`, `user_id`, `nidn`, `nama`, `created_at`, `updated_at`) VALUES
(1, 3, 'DSN000006', 'ZIdan S.Kom, M.Kom', '2026-04-10 04:51:53', '2026-04-21 07:59:52'),
(2, 4, 'DSN000001', 'Pandu Arta S.Kom, M.Kom', '2026-04-10 08:54:43', '2026-04-21 07:58:45'),
(3, 5, 'DSN000004', 'Agus S.Kom, M.Kom', '2026-04-10 08:58:20', '2026-04-21 07:59:35'),
(4, 8, 'DSN000005', 'Zami S.Kom, M.Kom', '2026-04-10 11:25:26', '2026-04-21 07:59:44'),
(5, 9, 'DSN000002', 'Gilang S.Kom, M.Kom', '2026-04-10 11:26:29', '2026-04-21 07:59:26'),
(6, 13, 'DSN000003', 'Wahyu S.Kom M.Kom', '2026-04-21 07:49:43', '2026-04-21 07:49:43');

-- --------------------------------------------------------

--
-- Table structure for table `face_data`
--

CREATE TABLE `face_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `embedding` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`embedding`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `face_data`
--

INSERT INTO `face_data` (`id`, `user_id`, `embedding`, `created_at`, `updated_at`) VALUES
(4, 10, '[-0.10769205871912453,0.045590362770948044,0.025332919911684456,-0.03216749081286681,-0.017597656610143706,-0.06448365337529761,-0.02256783045510407,-0.09510268695430263,0.11177607321710065,-0.04269209827204281,0.15022095356095552,-0.07049151633296989,-0.11770116626958282,-0.08754915065171186,-0.033253311827955025,0.10950574863842505,-0.14408517447542674,-0.10183726023518713,0.02423143608947439,-0.006007795694083415,0.04511299719893892,-0.040855785823262186,0.00628778244183113,0.07133201468492396,-0.08247483492574366,-0.24072840077827312,-0.0662812110150805,-0.1415467180133596,0.014971757482549686,-0.019877156491431274,-0.04369165167531983,0.024527708862085707,-0.13940888897748868,-0.011586725609183316,-0.05409120376825563,0.05085606674358958,0.008071822845704395,-0.020203066424933105,0.14502522842980897,0.048735111259440085,-0.12200072076081439,-0.024378639021893734,0.009101311977842924,0.20243651901729057,0.14723842563064207,0.05386222752994245,0.037364953815513476,-0.04600708129487272,0.06131983771845127,-0.13960368433084708,0.029131736792865133,0.12300968557562757,0.0942323345507021,0.03880488056237545,0.03078919673157511,-0.09579711075485876,0.03360961666726685,0.005199715989692124,-0.15341757188554803,0.06261400015005988,0.04176270765558543,0.05444807966170967,0.02273344439270468,-0.018176657464930635,0.21495793533918872,0.08024460493693791,-0.06445128448906332,-0.04132651014541543,0.11855853817325836,-0.12609345481626974,-0.06503974480080701,0.020993998375523834,-0.11244942292344692,-0.17135096714952594,-0.2023166415746668,0.029672975319771693,0.2670868103840111,0.12764321888557237,-0.11631402084908676,0.03566961486718733,-0.07389759072784116,-0.0603286908910563,0.1018870737272851,0.05005868847027806,-0.04017691226627102,0.029782200406281028,-0.06878482219266198,-0.011142194963988494,0.1568851663824327,-0.027653999672702163,0.0035977872913153675,0.15151362246634603,-0.02512371642304552,-0.001269064962398847,-0.028356975558128515,-0.00486733776984865,-0.025261216925952394,0.0766960415517732,-0.0666615330737967,-0.018932722167414876,0.03360837846814117,-0.04035942171921394,0.023698005629781603,0.05536400108767804,-0.16961248066803117,0.044413324092998564,0.019881357033919692,-0.02393100670161637,-0.040654999892315725,0.03220401905980042,-0.11438840431791182,-0.025336741581713135,0.11065771858862174,-0.1434632855327425,0.1615563892657638,0.14054971239010172,0.03441737275143211,0.08080410621458498,0.05275347100377695,0.05196024385480692,-0.004038306143888488,-0.034226939922265935,-0.08835914153429907,-0.010822631830550457,0.054192543914878204,-0.002379240286994313,0.053920875888529125,0.05045681753460203]', '2026-04-12 22:28:14', '2026-04-27 12:03:11'),
(12, 2, '[-0.0650256300761584,0.051779729478061365,0.00983829895993583,-0.04454769832309784,-0.08585101884694378,0.004930932191724817,-0.03611030058155092,-0.07627768617091216,0.15807886164688148,-0.06259320324721206,0.1597121958669088,-0.028444749280309215,-0.11609956345860632,-0.03558110011008202,-0.07041633895003874,0.11508169832653659,-0.12758042253051716,-0.10373867839674396,0.03299162917630917,-0.013267863966506416,0.03299798817108288,0.009572742927972491,-0.03250344463149713,0.05271398206246178,-0.07942580709415388,-0.22495411221419678,-0.06453571960457154,-0.10039890295770136,0.025465935417478717,-0.04074807516703373,-0.03564607351270058,0.038717069507999954,-0.12204757018635506,-0.025652499679148167,0.016293634819535174,0.0640465219125499,0.013036842614842213,0.01014113391447025,0.091100934291768,0.013833337351424143,-0.14205262648404215,-0.0025047084072599536,0.028527890608107512,0.17918315507095336,0.13089335462664464,0.07416738612927515,0.0033289982903503754,-0.10366649816824161,0.05215122380470854,-0.08732697900618339,0.04606828204215024,0.07352093260613504,0.08184290115804525,0.030685657082057637,-0.010406915810199499,-0.1192780150996731,0.010890267566962455,0.04840056127475662,-0.11502807592218231,0.03785825479848335,0.05081054792901626,-0.048774336949621036,0.011911567445817416,-0.013141831657017714,0.214742311518405,0.03500221339656473,-0.06238419181063225,-0.10419179000096503,0.1364780386677035,-0.12063746086490973,-0.08264433456662346,0.036711865858153545,-0.07061758830278118,-0.10486633127904635,-0.21506043922278412,0.009918895143150754,0.3333451990843765,0.0848418903121738,-0.13915272578909482,0.04365913682607331,-0.055590164316999216,-0.027120227818954463,0.0811091959370305,0.07919991674344516,-0.03362416055215637,-0.011061340601319693,-0.0850005645143547,-0.04587749736207149,0.18565266368847136,-0.012563302118590806,-0.0065866550958697785,0.11257480793901592,-0.027610655451761466,0.04107184631100878,0.010558185190394921,0.019788135831404093,-0.06378832486124143,0.04058907698756183,-0.07036905106921701,-0.07657865838173465,-0.009135125304588383,-0.017040255748772867,-0.001259027173224756,0.10482147986437002,-0.16547533108176243,0.10624092539482599,0.005446204078651592,-0.016948767631845413,-0.005225413611430882,0.03488629978912245,-0.04411145713777378,-0.031855562238172756,0.13768120086921826,-0.16100192989207437,0.15216017996554645,0.09488225113762012,0.08566532793268056,0.1202212955951193,0.06067168978732253,0.060815922882667156,-0.021335366068452658,-0.044483610295308215,-0.14161451049726484,-0.017023612340788235,0.03910309193403872,-0.07432903996844319,0.09637494623151405,0.044774279380174364]', '2026-05-12 08:08:10', '2026-06-15 07:11:39'),
(13, 12, '[-0.07037341070798833,0.07590571296362167,0.0739660749020469,-0.010674694268888691,-0.007966019022394957,-0.08584663134741648,-0.012881921163111891,-0.0999955914300967,0.11905637006688279,-0.05872745650174431,0.1552312765074963,-0.06528638044565613,-0.12621436773002526,-0.08998428302534599,-0.0006903915558604504,0.12804627835696192,-0.13856842694862656,-0.0998401396643347,-0.03827357312631195,-0.04221856899905024,0.04306141331571598,-0.0019109059216841453,0.024674886126269713,0.011825505281813416,-0.054701791073725164,-0.27413702354176583,-0.07562613651733957,-0.0942205291275731,0.013121569138031664,-0.021353329629510465,-0.025283962688430195,0.05699357490410134,-0.12918574149117928,-0.039449180142703884,-0.03635646462117255,0.025210968108435036,-0.02197609315996772,-0.03918468178634731,0.14086770551992983,0.019465295634824974,-0.14564089697840085,-0.013688104880918149,-0.009358994644503082,0.2031118634031949,0.1335364356805236,0.031043008110074256,0.03829609844831041,-0.0458692585367302,0.021886327815026006,-0.1181042541848815,0.023286389206838936,0.12428166833377777,0.07327014337569912,0.04838039907241409,-0.0007617186488900447,-0.0815938223178104,0.012035548697967247,-0.007151959495899307,-0.10149810846652536,0.006402436893394923,0.08518589759478827,-0.05021485844368184,-0.04844484845366041,-0.016102839204441118,0.21961743300986733,0.07494683650429695,-0.08621154097579033,-0.08441824780961814,0.0789230320235691,-0.08947849525829588,-0.06835037176021096,-0.0012882656356389627,-0.12215411530394903,-0.11202358199441523,-0.2156687764873231,0.04024594651904663,0.2887294385612414,0.03303017477525426,-0.16110020487203106,0.03223806940510073,-0.11003707151163489,0.007170725777242649,0.10455387199829135,0.10728353554888338,-0.03846043414110281,0.043134180943786384,-0.07873556269168232,-0.013846027090092168,0.11518600387956542,-0.07283622688993996,-0.05119799853055055,0.1503324817765481,-0.011220016822993893,0.03034352382932745,-0.009180541414894612,-0.013873078102266628,-0.011968521806024413,0.05153214967672844,-0.06511534771105852,-0.01878293242859999,0.09932662940674038,-0.010328213742772931,-0.020150887709086837,0.07298492756640397,-0.12082892713465426,0.09081535260473556,0.03797660284432133,0.03317039620914531,0.04940633059443391,0.016931608377032083,-0.09601273265227099,-0.09828316567497382,0.09154924688568243,-0.14338041359549636,0.1193885896553529,0.14440047024537567,0.004541300706865526,0.09821334265642254,0.0798608468624385,0.09607033766064994,-0.010918968250642194,0.007012338775442906,-0.12889420279879804,0.004784230341590554,0.08594238768879743,0.05589809980015982,0.020070618567655192,0.0348551678890047]', '2026-05-12 08:11:06', '2026-05-12 08:11:06');

-- --------------------------------------------------------

--
-- Table structure for table `face_logs`
--

CREATE TABLE `face_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `absensi_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('success','failed') NOT NULL,
  `distance` double(8,2) DEFAULT NULL,
  `confidence` double(8,2) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `face_logs`
--

INSERT INTO `face_logs` (`id`, `user_id`, `absensi_id`, `status`, `distance`, `confidence`, `message`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'success', 0.41, 45.57, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-10 08:10:55', '2026-04-10 08:10:55'),
(2, 6, 8, 'success', 0.44, 41.66, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-10 12:24:48', '2026-04-10 12:24:48'),
(3, 2, 7, 'success', 0.29, 61.44, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-10 12:24:58', '2026-04-10 12:24:58'),
(4, 2, 7, 'success', 0.63, 15.54, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-12 22:08:02', '2026-04-12 22:08:02'),
(5, 2, 7, 'success', 0.44, 41.13, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-12 22:29:10', '2026-04-12 22:29:10'),
(6, 10, 32, 'success', 0.42, 44.62, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-12 22:29:13', '2026-04-12 22:29:13'),
(7, 2, 7, 'success', 0.45, 40.34, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-15 06:34:34', '2026-04-15 06:34:34'),
(8, 10, 33, 'success', 0.73, 3.23, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-19 02:41:20', '2026-04-19 02:41:20'),
(9, 2, 34, 'success', 0.37, 50.72, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-19 02:41:31', '2026-04-19 02:41:31'),
(10, 2, 35, 'success', 0.61, 18.74, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-20 08:48:07', '2026-04-20 08:48:07'),
(11, 2, 35, 'success', 0.38, 15.97, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-20 21:44:28', '2026-04-20 21:44:28'),
(12, 2, 35, 'success', 0.27, 40.91, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-20 22:57:50', '2026-04-20 22:57:50'),
(13, 2, 35, 'success', 0.31, 30.17, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-20 23:06:46', '2026-04-20 23:06:46'),
(14, 2, 35, 'success', 0.37, 18.82, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-20 23:15:15', '2026-04-20 23:15:15'),
(15, 2, 35, 'success', 0.42, 6.20, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-21 00:30:58', '2026-04-21 00:30:58'),
(16, 12, 42, 'success', 0.24, 46.30, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-21 00:32:24', '2026-04-21 00:32:24'),
(17, 2, 34, 'success', 0.40, 10.86, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-21 00:32:24', '2026-04-21 00:32:24'),
(18, 12, 42, 'success', 0.36, 19.45, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-21 00:34:10', '2026-04-21 00:34:10'),
(19, 11, 43, 'success', 0.43, 5.50, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-21 00:34:10', '2026-04-21 00:34:10'),
(20, 2, 34, 'success', 0.44, 3.19, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-21 00:34:10', '2026-04-21 00:34:10'),
(21, 2, 34, 'success', 0.35, 22.10, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-22 09:33:40', '2026-04-22 09:33:40'),
(22, 10, 33, 'success', 0.42, 6.69, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-22 09:33:45', '2026-04-22 09:33:45'),
(23, 2, 56, 'success', 0.42, 7.26, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-25 07:52:10', '2026-04-25 07:52:10'),
(24, 2, 56, 'success', 0.45, 1.05, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-25 07:56:21', '2026-04-25 07:56:21'),
(25, 2, 56, 'success', 0.32, 28.93, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-25 08:04:19', '2026-04-25 08:04:19'),
(26, 2, 56, 'success', 0.31, 1.71, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-27 09:38:55', '2026-04-27 09:38:55'),
(27, 2, 56, 'success', 0.36, 2.52, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-27 09:44:36', '2026-04-27 09:44:36'),
(28, 2, 56, 'success', 0.32, 3.67, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-27 09:48:01', '2026-04-27 09:48:01'),
(29, 2, 56, 'success', 0.39, 78.50, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-27 09:53:13', '2026-04-27 09:53:13'),
(30, 2, 56, 'success', 0.33, 26.34, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-27 10:49:21', '2026-04-27 10:49:21'),
(31, 2, NULL, 'failed', 0.31, 48.37, 'Confidence terlalu rendah (48.37%, minimum 80%). (kiosk)', '2026-04-27 14:21:19', '2026-04-27 14:21:19'),
(32, 2, NULL, 'failed', 0.32, 47.44, 'Confidence terlalu rendah (47.44%, minimum 80%). (kiosk)', '2026-04-27 14:21:23', '2026-04-27 14:21:23'),
(33, 2, NULL, 'failed', 0.25, 58.35, 'Confidence terlalu rendah (58.35%, minimum 80%). (kiosk)', '2026-04-27 14:21:32', '2026-04-27 14:21:32'),
(34, 2, NULL, 'failed', 0.29, 51.51, 'Confidence terlalu rendah (51.51%, minimum 80%). (kiosk)', '2026-04-27 14:21:36', '2026-04-27 14:21:36'),
(35, 2, NULL, 'failed', 0.29, 51.91, 'Confidence terlalu rendah (51.91%, minimum 80%). (kiosk)', '2026-04-27 14:21:41', '2026-04-27 14:21:41'),
(36, 2, NULL, 'failed', 0.26, 57.39, 'Confidence terlalu rendah (57.39%, minimum 80%). (kiosk)', '2026-04-27 14:24:36', '2026-04-27 14:24:36'),
(37, 2, NULL, 'failed', 0.27, 54.44, 'Confidence terlalu rendah (54.44%, minimum 80%). (kiosk)', '2026-04-27 14:24:40', '2026-04-27 14:24:40'),
(38, 2, NULL, 'failed', 0.61, 0.00, 'Wajah tidak cocok. (kiosk)', '2026-04-27 14:24:47', '2026-04-27 14:24:47'),
(39, 2, NULL, 'failed', 0.28, 52.62, 'Confidence terlalu rendah (52.62%, minimum 80%). (kiosk)', '2026-04-27 14:38:00', '2026-04-27 14:38:00'),
(40, 2, NULL, 'failed', 0.32, 47.30, 'Confidence terlalu rendah (47.3%, minimum 80%). (kiosk)', '2026-04-27 14:38:05', '2026-04-27 14:38:05'),
(41, 2, NULL, 'failed', 0.26, 56.19, 'Confidence terlalu rendah (56.19%, minimum 80%). (kiosk)', '2026-04-27 14:38:10', '2026-04-27 14:38:10'),
(42, 2, NULL, 'failed', 0.27, 55.33, 'Confidence terlalu rendah (55.33%, minimum 80%). (kiosk)', '2026-04-27 14:38:15', '2026-04-27 14:38:15'),
(43, 2, NULL, 'failed', 0.27, 54.63, 'Confidence terlalu rendah (54.63%, minimum 80%). (kiosk)', '2026-04-27 14:38:20', '2026-04-27 14:38:20'),
(44, 2, NULL, 'failed', 0.14, 77.05, 'Confidence terlalu rendah (77.05%, minimum 80%). (kiosk)', '2026-04-27 14:40:16', '2026-04-27 14:40:16'),
(45, 2, NULL, 'failed', 0.19, 68.63, 'Confidence terlalu rendah (68.63%, minimum 80%). (kiosk)', '2026-04-27 14:40:21', '2026-04-27 14:40:21'),
(46, 2, NULL, 'failed', 0.18, 70.37, 'Confidence terlalu rendah (70.37%, minimum 80%). (kiosk)', '2026-04-27 14:40:26', '2026-04-27 14:40:26'),
(47, 2, NULL, 'failed', 0.14, 76.56, 'Confidence terlalu rendah (76.56%, minimum 80%). (kiosk)', '2026-04-27 14:40:31', '2026-04-27 14:40:31'),
(48, 2, NULL, 'failed', 0.16, 73.52, 'Confidence terlalu rendah (73.52%, minimum 80%). (kiosk)', '2026-04-27 14:40:36', '2026-04-27 14:40:36'),
(49, 2, NULL, 'failed', 0.18, 70.16, 'Confidence terlalu rendah (70.16%, minimum 80%). (kiosk)', '2026-04-27 14:42:41', '2026-04-27 14:42:41'),
(50, 2, NULL, 'failed', 0.21, 65.30, 'Confidence terlalu rendah (65.3%, minimum 80%). (kiosk)', '2026-04-27 14:42:46', '2026-04-27 14:42:46'),
(51, 2, NULL, 'failed', 0.19, 68.00, 'Confidence terlalu rendah (68%, minimum 80%). (kiosk)', '2026-04-27 14:42:51', '2026-04-27 14:42:51'),
(52, 2, NULL, 'failed', 0.21, 64.94, 'Confidence terlalu rendah (64.94%, minimum 80%). (kiosk)', '2026-04-27 14:42:59', '2026-04-27 14:42:59'),
(53, 2, NULL, 'failed', 0.21, 64.58, 'Confidence terlalu rendah (64.58%, minimum 80%). (kiosk)', '2026-04-27 14:43:04', '2026-04-27 14:43:04'),
(54, 2, NULL, 'failed', 0.24, 60.04, 'Confidence terlalu rendah (60.04%, minimum 80%). (kiosk)', '2026-04-27 14:43:09', '2026-04-27 14:43:09'),
(55, 2, NULL, 'failed', 0.20, 66.11, 'Confidence terlalu rendah (66.11%, minimum 80%). (kiosk)', '2026-04-27 14:43:15', '2026-04-27 14:43:15'),
(56, 2, NULL, 'failed', 0.18, 70.10, 'Confidence terlalu rendah (70.1%, minimum 80%). (kiosk)', '2026-04-27 14:43:20', '2026-04-27 14:43:20'),
(57, 2, NULL, 'failed', 0.20, 66.88, 'Confidence terlalu rendah (66.88%, minimum 80%). (kiosk)', '2026-04-27 14:43:25', '2026-04-27 14:43:25'),
(58, 2, NULL, 'failed', 0.21, 65.64, 'Confidence terlalu rendah (65.64%, minimum 80%). (kiosk)', '2026-04-27 14:43:30', '2026-04-27 14:43:30'),
(59, 2, NULL, 'failed', 0.22, 63.72, 'Confidence terlalu rendah (63.72%, minimum 80%). (kiosk)', '2026-04-27 14:43:35', '2026-04-27 14:43:35'),
(60, 2, NULL, 'failed', 0.21, 65.79, 'Confidence terlalu rendah (65.79%, minimum 80%). (kiosk)', '2026-04-27 14:43:40', '2026-04-27 14:43:40'),
(61, 2, NULL, 'failed', 0.31, 48.29, 'Confidence terlalu rendah (48.29%, minimum 80%). (kiosk)', '2026-04-27 14:43:48', '2026-04-27 14:43:48'),
(62, 2, NULL, 'failed', 0.29, 51.30, 'Confidence terlalu rendah (51.3%, minimum 80%). (kiosk)', '2026-04-27 14:43:53', '2026-04-27 14:43:53'),
(63, 2, NULL, 'failed', 0.35, 41.70, 'Confidence terlalu rendah (41.7%, minimum 80%). (kiosk)', '2026-04-27 14:43:58', '2026-04-27 14:43:58'),
(64, 2, NULL, 'failed', 0.25, 58.31, 'Confidence terlalu rendah (58.31%, minimum 80%). (kiosk)', '2026-04-27 14:44:03', '2026-04-27 14:44:03'),
(65, 10, NULL, 'failed', 0.54, 10.75, 'Confidence terlalu rendah (10.75%, minimum 80%). (kiosk)', '2026-04-27 14:44:04', '2026-04-27 14:44:04'),
(66, 2, NULL, 'failed', 0.25, 58.32, 'Confidence terlalu rendah (58.32%, minimum 80%). (kiosk)', '2026-04-27 14:44:08', '2026-04-27 14:44:08'),
(67, 2, NULL, 'failed', 0.23, 62.14, 'Confidence terlalu rendah (62.14%, minimum 80%). (kiosk)', '2026-04-27 14:44:13', '2026-04-27 14:44:13'),
(68, 2, NULL, 'failed', 0.31, 49.09, 'Confidence terlalu rendah (49.09%, minimum 80%). (kiosk)', '2026-04-27 14:44:18', '2026-04-27 14:44:18'),
(69, 2, NULL, 'failed', 0.23, 61.67, 'Confidence terlalu rendah (61.67%, minimum 80%). (kiosk)', '2026-04-27 14:44:23', '2026-04-27 14:44:23'),
(70, 2, NULL, 'failed', 0.23, 61.89, 'Confidence terlalu rendah (61.89%, minimum 80%). (kiosk)', '2026-04-27 14:44:28', '2026-04-27 14:44:28'),
(71, 2, NULL, 'failed', 0.50, 17.44, 'Confidence terlalu rendah (17.44%, minimum 80%). (kiosk)', '2026-04-27 14:44:30', '2026-04-27 14:44:30'),
(72, 2, NULL, 'failed', 0.24, 59.21, 'Confidence terlalu rendah (59.21%, minimum 80%). (kiosk)', '2026-04-27 14:44:33', '2026-04-27 14:44:33'),
(73, 2, NULL, 'failed', 0.26, 56.26, 'Confidence terlalu rendah (56.26%, minimum 80%). (kiosk)', '2026-04-27 14:44:38', '2026-04-27 14:44:38'),
(74, 2, NULL, 'failed', 0.23, 62.28, 'Confidence terlalu rendah (62.28%, minimum 80%). (kiosk)', '2026-04-27 14:44:43', '2026-04-27 14:44:43'),
(75, 2, NULL, 'failed', 0.22, 62.91, 'Confidence terlalu rendah (62.91%, minimum 80%). (kiosk)', '2026-04-27 14:44:48', '2026-04-27 14:44:48'),
(76, 2, NULL, 'failed', 0.31, 48.74, 'Confidence terlalu rendah (48.74%, minimum 80%). (kiosk)', '2026-04-27 14:44:53', '2026-04-27 14:44:53'),
(77, 2, NULL, 'failed', 0.33, 44.19, 'Confidence terlalu rendah (44.19%, minimum 80%). (kiosk)', '2026-04-27 14:45:55', '2026-04-27 14:45:55'),
(78, 2, NULL, 'failed', 0.36, 39.41, 'Confidence terlalu rendah (39.41%, minimum 80%). (kiosk)', '2026-04-27 14:46:00', '2026-04-27 14:46:00'),
(79, 2, NULL, 'failed', 0.40, 32.78, 'Confidence terlalu rendah (32.78%, minimum 80%). (kiosk)', '2026-04-27 14:46:05', '2026-04-27 14:46:05'),
(80, 2, NULL, 'failed', 0.39, 19.56, 'Confidence terlalu rendah (19.56%, minimum 70%). (kiosk)', '2026-04-27 14:46:48', '2026-04-27 14:46:48'),
(81, 2, NULL, 'failed', 0.22, 38.89, 'Confidence terlalu rendah (38.89%, minimum 70%). (kiosk)', '2026-04-27 14:46:53', '2026-04-27 14:46:53'),
(82, 2, NULL, 'failed', 0.21, 41.30, 'Confidence terlalu rendah (41.3%, minimum 70%). (kiosk)', '2026-04-27 14:46:58', '2026-04-27 14:46:58'),
(83, 2, NULL, 'failed', 0.22, 38.98, 'Confidence terlalu rendah (38.98%, minimum 70%). (kiosk)', '2026-04-27 14:47:04', '2026-04-27 14:47:04'),
(84, 2, NULL, 'failed', 0.23, 37.93, 'Confidence terlalu rendah (37.93%, minimum 70%). (kiosk)', '2026-04-27 14:47:09', '2026-04-27 14:47:09'),
(85, 2, NULL, 'failed', 0.21, 40.74, 'Confidence terlalu rendah (40.74%, minimum 70%). (kiosk)', '2026-04-27 14:47:15', '2026-04-27 14:47:15'),
(86, 10, NULL, 'failed', 0.51, 8.17, 'Confidence terlalu rendah (8.17%, minimum 70%). (kiosk)', '2026-04-27 14:47:18', '2026-04-27 14:47:18'),
(87, 2, NULL, 'failed', 0.21, 40.98, 'Confidence terlalu rendah (40.98%, minimum 70%). (kiosk)', '2026-04-27 14:47:21', '2026-04-27 14:47:21'),
(88, 2, NULL, 'failed', 0.35, 23.52, 'Confidence terlalu rendah (23.52%, minimum 70%). (kiosk)', '2026-04-27 14:47:26', '2026-04-27 14:47:26'),
(89, 10, NULL, 'failed', 0.49, 9.20, 'Confidence terlalu rendah (9.2%, minimum 70%). (kiosk)', '2026-04-27 14:47:28', '2026-04-27 14:47:28'),
(90, 12, NULL, 'failed', 0.54, 5.50, 'Confidence terlalu rendah (5.5%, minimum 70%). (kiosk)', '2026-04-27 14:47:30', '2026-04-27 14:47:30'),
(91, 2, NULL, 'failed', 0.26, 34.27, 'Confidence terlalu rendah (34.27%, minimum 70%). (kiosk)', '2026-04-27 14:47:31', '2026-04-27 14:47:31'),
(92, 2, NULL, 'failed', 0.28, 31.13, 'Confidence terlalu rendah (31.13%, minimum 70%). (kiosk)', '2026-04-27 14:47:36', '2026-04-27 14:47:36'),
(93, 2, NULL, 'failed', 0.19, 43.57, 'Confidence terlalu rendah (43.57%, minimum 70%). (kiosk)', '2026-04-27 14:47:41', '2026-04-27 14:47:41'),
(94, 2, NULL, 'failed', 0.22, 39.45, 'Confidence terlalu rendah (39.45%, minimum 70%). (kiosk)', '2026-04-27 14:47:46', '2026-04-27 14:47:46'),
(95, 2, NULL, 'failed', 0.19, 43.62, 'Confidence terlalu rendah (43.62%, minimum 70%). (kiosk)', '2026-04-27 14:47:51', '2026-04-27 14:47:51'),
(96, 2, NULL, 'failed', 0.20, 42.20, 'Confidence terlalu rendah (42.2%, minimum 70%). (kiosk)', '2026-04-27 14:47:56', '2026-04-27 14:47:56'),
(97, 2, NULL, 'failed', 0.22, 40.02, 'Confidence terlalu rendah (40.02%, minimum 70%). (kiosk)', '2026-04-27 14:48:01', '2026-04-27 14:48:01'),
(98, 2, NULL, 'failed', 0.24, 36.87, 'Confidence terlalu rendah (36.87%, minimum 70%). (kiosk)', '2026-04-27 14:48:06', '2026-04-27 14:48:06'),
(99, 10, NULL, 'failed', 0.35, 23.23, 'Confidence terlalu rendah (23.23%, minimum 70%). (kiosk)', '2026-04-27 14:48:11', '2026-04-27 14:48:11'),
(100, 10, NULL, 'failed', 0.41, 17.71, 'Confidence terlalu rendah (17.71%, minimum 70%). (kiosk)', '2026-04-27 14:48:36', '2026-04-27 14:48:36'),
(101, 2, NULL, 'failed', 0.31, 68.20, 'Confidence terlalu rendah (68.2%, minimum 70%). (kiosk)', '2026-04-27 14:50:01', '2026-04-27 14:50:01'),
(102, 11, NULL, 'failed', 0.48, 31.69, 'Confidence terlalu rendah (31.69%, minimum 70%). (kiosk)', '2026-04-27 14:50:10', '2026-04-27 14:50:10'),
(103, 2, NULL, 'failed', 0.36, 58.00, 'Confidence terlalu rendah (58%, minimum 80%). (kiosk)', '2026-04-27 14:50:15', '2026-04-27 14:50:15'),
(104, 10, NULL, 'failed', 0.37, 57.49, 'Confidence terlalu rendah (57.49%, minimum 80%). (kiosk)', '2026-04-27 14:50:20', '2026-04-27 14:50:20'),
(105, 10, NULL, 'failed', 0.35, 59.94, 'Confidence terlalu rendah (59.94%, minimum 80%). (kiosk)', '2026-04-27 14:51:06', '2026-04-27 14:51:06'),
(106, 2, NULL, 'failed', 0.25, 79.43, 'Confidence terlalu rendah (79.43%, minimum 80%). (kiosk)', '2026-04-27 14:51:11', '2026-04-27 14:51:11'),
(107, 2, NULL, 'failed', 0.25, 79.58, 'Confidence terlalu rendah (79.58%, minimum 80%). (kiosk)', '2026-04-27 14:51:21', '2026-04-27 14:51:21'),
(108, 2, NULL, 'failed', 0.25, 79.03, 'Confidence terlalu rendah (79.03%, minimum 80%). (kiosk)', '2026-04-27 14:51:37', '2026-04-27 14:51:37'),
(109, 2, NULL, 'failed', 0.37, 57.05, 'Confidence terlalu rendah (57.05%, minimum 80%). (kiosk)', '2026-04-27 14:52:11', '2026-04-27 14:52:11'),
(110, 2, NULL, 'failed', 0.34, 63.53, 'Confidence terlalu rendah (63.53%, minimum 80%). (kiosk)', '2026-04-27 14:52:16', '2026-04-27 14:52:16'),
(111, 2, NULL, 'failed', 0.35, 60.82, 'Confidence terlalu rendah (60.82%, minimum 80%). (kiosk)', '2026-04-27 14:52:21', '2026-04-27 14:52:21'),
(112, 2, NULL, 'failed', 0.35, 60.72, 'Confidence terlalu rendah (60.72%, minimum 80%). (kiosk)', '2026-04-27 14:52:26', '2026-04-27 14:52:26'),
(113, 2, NULL, 'failed', 0.28, 73.74, 'Confidence terlalu rendah (73.74%, minimum 80%). (kiosk)', '2026-04-27 14:52:31', '2026-04-27 14:52:31'),
(114, 2, NULL, 'failed', 0.33, 64.80, 'Confidence terlalu rendah (64.8%, minimum 80%). (kiosk)', '2026-04-27 14:52:36', '2026-04-27 14:52:36'),
(115, 2, NULL, 'failed', 0.37, 57.41, 'Confidence terlalu rendah (57.41%, minimum 80%). (kiosk)', '2026-04-27 14:52:43', '2026-04-27 14:52:43'),
(116, 2, NULL, 'failed', 0.39, 52.35, 'Confidence terlalu rendah (52.35%, minimum 80%). (kiosk)', '2026-04-27 14:52:48', '2026-04-27 14:52:48'),
(117, 2, NULL, 'failed', 0.39, 52.56, 'Confidence terlalu rendah (52.56%, minimum 80%). (kiosk)', '2026-04-27 14:52:55', '2026-04-27 14:52:55'),
(118, 2, NULL, 'failed', 0.39, 52.19, 'Confidence terlalu rendah (52.19%, minimum 80%). (kiosk)', '2026-04-27 14:53:00', '2026-04-27 14:53:00'),
(119, 2, NULL, 'failed', 0.38, 54.37, 'Confidence terlalu rendah (54.37%, minimum 80%). (kiosk)', '2026-04-27 14:53:05', '2026-04-27 14:53:05'),
(120, 2, NULL, 'success', 0.22, 83.91, 'Wajah cocok. (kiosk)', '2026-04-27 14:53:13', '2026-04-27 14:53:13'),
(121, 2, 56, 'success', 0.22, 83.91, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-27 14:53:13', '2026-04-27 14:53:13'),
(122, 2, NULL, 'failed', 0.26, 77.92, 'Confidence terlalu rendah (77.92%, minimum 80%). (kiosk)', '2026-04-27 14:53:17', '2026-04-27 14:53:17'),
(123, 2, NULL, 'success', 0.17, 90.63, 'Wajah cocok. (kiosk)', '2026-04-27 14:53:22', '2026-04-27 14:53:22'),
(124, 2, NULL, 'failed', 0.28, 73.58, 'Confidence terlalu rendah (73.58%, minimum 80%). (kiosk)', '2026-04-27 14:53:27', '2026-04-27 14:53:27'),
(125, 2, NULL, 'failed', 0.33, 65.41, 'Confidence terlalu rendah (65.41%, minimum 80%). (kiosk)', '2026-04-27 14:53:34', '2026-04-27 14:53:34'),
(126, 10, NULL, 'failed', 0.38, 55.27, 'Confidence terlalu rendah (55.27%, minimum 80%). (kiosk)', '2026-04-27 14:53:39', '2026-04-27 14:53:39'),
(127, 10, NULL, 'failed', 0.37, 56.11, 'Confidence terlalu rendah (56.11%, minimum 80%). (kiosk)', '2026-04-27 14:53:45', '2026-04-27 14:53:45'),
(128, 10, NULL, 'failed', 0.36, 58.67, 'Confidence terlalu rendah (58.67%, minimum 80%). (kiosk)', '2026-04-27 14:54:08', '2026-04-27 14:54:08'),
(129, 10, NULL, 'failed', 0.39, 52.91, 'Confidence terlalu rendah (52.91%, minimum 80%). (kiosk)', '2026-04-27 14:54:15', '2026-04-27 14:54:15'),
(130, 2, NULL, 'failed', 0.25, 78.61, 'Confidence terlalu rendah (78.61%, minimum 80%). (kiosk)', '2026-04-27 14:54:30', '2026-04-27 14:54:30'),
(131, 10, NULL, 'failed', 0.38, 55.17, 'Confidence terlalu rendah (55.17%, minimum 80%). (kiosk)', '2026-04-27 14:54:39', '2026-04-27 14:54:39'),
(132, 2, NULL, 'failed', 0.31, 68.20, 'Confidence terlalu rendah (68.2%, minimum 80%). (kiosk)', '2026-04-27 14:54:48', '2026-04-27 14:54:48'),
(133, 2, NULL, 'success', 0.22, 83.76, 'Wajah cocok. (kiosk)', '2026-04-27 14:54:53', '2026-04-27 14:54:53'),
(134, 2, NULL, 'success', 0.21, 85.81, 'Wajah cocok. (kiosk)', '2026-04-27 14:54:58', '2026-04-27 14:54:58'),
(135, 2, NULL, 'failed', 0.33, 64.14, 'Confidence terlalu rendah (64.14%, minimum 80%). (kiosk)', '2026-04-27 14:55:06', '2026-04-27 14:55:06'),
(136, 2, NULL, 'failed', 0.29, 72.38, 'Confidence terlalu rendah (72.38%, minimum 80%). (kiosk)', '2026-04-27 14:55:11', '2026-04-27 14:55:11'),
(137, 2, NULL, 'failed', 0.27, 76.20, 'Confidence terlalu rendah (76.2%, minimum 80%). (kiosk)', '2026-04-27 14:55:16', '2026-04-27 14:55:16'),
(138, 2, NULL, 'failed', 0.41, 47.70, 'Confidence terlalu rendah (47.7%, minimum 80%). (kiosk)', '2026-04-27 14:55:18', '2026-04-27 14:55:18'),
(139, 2, NULL, 'failed', 0.43, 43.16, 'Confidence terlalu rendah (43.16%, minimum 80%). (kiosk)', '2026-04-27 14:55:23', '2026-04-27 14:55:23'),
(140, 10, NULL, 'failed', 0.44, 40.74, 'Confidence terlalu rendah (40.74%, minimum 80%). (kiosk)', '2026-04-27 14:55:34', '2026-04-27 14:55:34'),
(141, 10, NULL, 'failed', 0.42, 45.79, 'Confidence terlalu rendah (45.79%, minimum 80%). (kiosk)', '2026-04-27 14:55:41', '2026-04-27 14:55:41'),
(142, 2, NULL, 'failed', 0.34, 62.71, 'Confidence terlalu rendah (62.71%, minimum 80%). (kiosk)', '2026-04-27 14:55:46', '2026-04-27 14:55:46'),
(143, 2, NULL, 'failed', 0.28, 74.67, 'Confidence terlalu rendah (74.67%, minimum 80%). (kiosk)', '2026-04-27 15:00:48', '2026-04-27 15:00:48'),
(144, 2, NULL, 'success', 0.24, 81.51, 'Wajah cocok. (kiosk)', '2026-04-27 15:00:53', '2026-04-27 15:00:53'),
(145, 2, NULL, 'success', 0.24, 81.20, 'Wajah cocok. (kiosk)', '2026-04-27 15:00:58', '2026-04-27 15:00:58'),
(146, 2, 56, 'success', 0.60, 20.23, 'Identifikasi kiosk Face ID oleh dosen.', '2026-04-29 23:08:39', '2026-04-29 23:08:39'),
(148, 2, NULL, 'failed', 0.32, 66.07, 'Confidence terlalu rendah (66.07%, minimum 80%). (kiosk)', '2026-04-30 06:10:16', '2026-04-30 06:10:16'),
(150, 2, NULL, 'failed', 0.30, 70.67, 'Confidence terlalu rendah (70.67%, minimum 80%). (kiosk)', '2026-04-30 06:10:21', '2026-04-30 06:10:21'),
(154, 2, NULL, 'failed', 0.28, 73.96, 'Confidence terlalu rendah (73.96%, minimum 80%). (kiosk)', '2026-04-30 06:10:38', '2026-04-30 06:10:38'),
(156, 2, NULL, 'failed', 0.26, 77.45, 'Confidence terlalu rendah (77.45%, minimum 80%). (kiosk)', '2026-04-30 06:10:43', '2026-04-30 06:10:43'),
(157, 2, NULL, 'failed', 0.25, 79.36, 'Confidence terlalu rendah (79.36%, minimum 80%). (kiosk)', '2026-04-30 06:10:48', '2026-04-30 06:10:48'),
(158, 2, NULL, 'failed', 0.26, 78.24, 'Confidence terlalu rendah (78.24%, minimum 80%). (kiosk)', '2026-04-30 06:10:53', '2026-04-30 06:10:53'),
(159, 2, NULL, 'failed', 0.26, 77.04, 'Confidence terlalu rendah (77.04%, minimum 80%). (kiosk)', '2026-04-30 06:10:58', '2026-04-30 06:10:58'),
(160, 10, NULL, 'failed', 0.54, 16.38, 'Confidence terlalu rendah (16.38%, minimum 80%). (kiosk)', '2026-04-30 06:10:59', '2026-04-30 06:10:59'),
(161, 2, NULL, 'failed', 0.26, 78.27, 'Confidence terlalu rendah (78.27%, minimum 80%). (kiosk)', '2026-04-30 06:11:03', '2026-04-30 06:11:03'),
(162, 2, NULL, 'failed', 0.33, 65.85, 'Confidence terlalu rendah (65.85%, minimum 80%). (kiosk)', '2026-04-30 06:11:08', '2026-04-30 06:11:08'),
(163, 2, NULL, 'failed', 0.32, 66.82, 'Confidence terlalu rendah (66.82%, minimum 80%). (kiosk)', '2026-04-30 06:11:13', '2026-04-30 06:11:13'),
(164, 2, NULL, 'failed', 0.26, 77.82, 'Confidence terlalu rendah (77.82%, minimum 80%). (kiosk)', '2026-04-30 06:11:18', '2026-04-30 06:11:18'),
(166, 2, NULL, 'failed', 0.27, 75.24, 'Confidence terlalu rendah (75.24%, minimum 80%). (kiosk)', '2026-04-30 06:11:24', '2026-04-30 06:11:24'),
(167, 2, NULL, 'failed', 0.29, 71.95, 'Confidence terlalu rendah (71.95%, minimum 80%). (kiosk)', '2026-04-30 06:11:29', '2026-04-30 06:11:29'),
(168, 2, NULL, 'failed', 0.27, 75.44, 'Confidence terlalu rendah (75.44%, minimum 80%). (kiosk)', '2026-04-30 06:11:34', '2026-04-30 06:11:34'),
(169, 2, NULL, 'failed', 0.50, 26.03, 'Confidence terlalu rendah (26.03%, minimum 80%). (kiosk)', '2026-04-30 06:11:38', '2026-04-30 06:11:38'),
(172, 12, NULL, 'failed', 0.50, 26.92, 'Confidence terlalu rendah (26.92%, minimum 80%). (kiosk)', '2026-04-30 06:11:52', '2026-04-30 06:11:52'),
(174, 2, NULL, 'failed', 0.50, 27.06, 'Confidence terlalu rendah (27.06%, minimum 80%). (kiosk)', '2026-04-30 06:11:58', '2026-04-30 06:11:58'),
(175, 10, NULL, 'failed', 0.50, 25.84, 'Confidence terlalu rendah (25.84%, minimum 80%). (kiosk)', '2026-04-30 06:11:59', '2026-04-30 06:11:59'),
(177, 2, NULL, 'failed', 0.40, 49.56, 'Confidence terlalu rendah (49.56%, minimum 80%). (kiosk)', '2026-04-30 06:12:17', '2026-04-30 06:12:17'),
(178, 2, NULL, 'failed', 0.36, 58.99, 'Confidence terlalu rendah (58.99%, minimum 80%). (kiosk)', '2026-04-30 06:12:18', '2026-04-30 06:12:18'),
(179, 10, NULL, 'failed', 0.56, 9.46, 'Confidence terlalu rendah (9.46%, minimum 80%). (kiosk)', '2026-04-30 06:12:21', '2026-04-30 06:12:21'),
(180, 2, NULL, 'failed', 0.32, 67.27, 'Confidence terlalu rendah (67.27%, minimum 80%). (kiosk)', '2026-04-30 06:12:23', '2026-04-30 06:12:23'),
(181, 2, NULL, 'failed', 0.56, 11.00, 'Confidence terlalu rendah (11%, minimum 80%). (kiosk)', '2026-04-30 06:12:25', '2026-04-30 06:12:25'),
(182, 2, NULL, 'failed', 0.32, 66.73, 'Confidence terlalu rendah (66.73%, minimum 80%). (kiosk)', '2026-04-30 06:12:28', '2026-04-30 06:12:28'),
(183, 2, NULL, 'failed', 0.54, 14.73, 'Confidence terlalu rendah (14.73%, minimum 80%). (kiosk)', '2026-04-30 06:12:28', '2026-04-30 06:12:28'),
(184, 2, NULL, 'failed', 0.34, 62.15, 'Confidence terlalu rendah (62.15%, minimum 80%). (kiosk)', '2026-04-30 06:12:37', '2026-04-30 06:12:37'),
(185, 2, NULL, 'failed', 0.29, 71.94, 'Confidence terlalu rendah (71.94%, minimum 80%). (kiosk)', '2026-04-30 06:12:45', '2026-04-30 06:12:45'),
(186, 2, NULL, 'failed', 0.30, 69.88, 'Confidence terlalu rendah (69.88%, minimum 80%). (kiosk)', '2026-04-30 06:12:50', '2026-04-30 06:12:50'),
(187, 2, NULL, 'failed', 0.31, 69.01, 'Confidence terlalu rendah (69.01%, minimum 80%). (kiosk)', '2026-04-30 06:12:55', '2026-04-30 06:12:55'),
(188, 10, NULL, 'failed', 0.48, 30.05, 'Confidence terlalu rendah (30.05%, minimum 80%). (kiosk)', '2026-04-30 06:12:55', '2026-04-30 06:12:55'),
(189, 2, NULL, 'failed', 0.26, 76.98, 'Confidence terlalu rendah (76.98%, minimum 80%). (kiosk)', '2026-04-30 06:13:00', '2026-04-30 06:13:00'),
(190, 10, NULL, 'failed', 0.50, 25.05, 'Confidence terlalu rendah (25.05%, minimum 80%). (kiosk)', '2026-04-30 06:13:00', '2026-04-30 06:13:00'),
(191, 2, NULL, 'failed', 0.27, 75.53, 'Confidence terlalu rendah (75.53%, minimum 80%). (kiosk)', '2026-04-30 06:13:05', '2026-04-30 06:13:05'),
(193, 2, NULL, 'failed', 0.29, 73.36, 'Confidence terlalu rendah (73.36%, minimum 80%). (kiosk)', '2026-04-30 06:13:10', '2026-04-30 06:13:10'),
(196, 2, NULL, 'failed', 0.35, 61.72, 'Confidence terlalu rendah (61.72%, minimum 80%). (kiosk)', '2026-04-30 06:13:15', '2026-04-30 06:13:15'),
(197, 10, NULL, 'failed', 0.50, 27.10, 'Confidence terlalu rendah (27.1%, minimum 80%). (kiosk)', '2026-04-30 06:13:20', '2026-04-30 06:13:20'),
(198, 2, NULL, 'failed', 0.29, 72.46, 'Confidence terlalu rendah (72.46%, minimum 80%). (kiosk)', '2026-04-30 06:13:20', '2026-04-30 06:13:20'),
(199, 2, NULL, 'failed', 0.27, 75.24, 'Confidence terlalu rendah (75.24%, minimum 80%). (kiosk)', '2026-04-30 06:13:25', '2026-04-30 06:13:25'),
(200, 10, NULL, 'failed', 0.52, 21.36, 'Confidence terlalu rendah (21.36%, minimum 80%). (kiosk)', '2026-04-30 06:13:25', '2026-04-30 06:13:25'),
(202, 2, NULL, 'failed', 0.34, 63.12, 'Confidence terlalu rendah (63.12%, minimum 80%). (kiosk)', '2026-04-30 06:13:30', '2026-04-30 06:13:30'),
(203, 2, NULL, 'failed', 0.37, 57.63, 'Confidence terlalu rendah (57.63%, minimum 80%). (kiosk)', '2026-04-30 06:13:35', '2026-04-30 06:13:35'),
(205, 2, NULL, 'failed', 0.31, 69.11, 'Confidence terlalu rendah (69.11%, minimum 80%). (kiosk)', '2026-04-30 06:13:40', '2026-04-30 06:13:40'),
(207, 2, NULL, 'failed', 0.28, 74.76, 'Confidence terlalu rendah (74.76%, minimum 80%). (kiosk)', '2026-04-30 06:13:45', '2026-04-30 06:13:45'),
(209, 2, NULL, 'failed', 0.33, 64.90, 'Confidence terlalu rendah (64.9%, minimum 80%). (kiosk)', '2026-04-30 06:13:50', '2026-04-30 06:13:50'),
(211, 2, NULL, 'failed', 0.33, 64.86, 'Confidence terlalu rendah (64.86%, minimum 80%). (kiosk)', '2026-04-30 06:13:55', '2026-04-30 06:13:55'),
(212, 2, NULL, 'failed', 0.46, 35.81, 'Confidence terlalu rendah (35.81%, minimum 80%). (kiosk)', '2026-04-30 06:13:58', '2026-04-30 06:13:58'),
(214, 2, NULL, 'failed', 0.31, 68.11, 'Confidence terlalu rendah (68.11%, minimum 80%). (kiosk)', '2026-04-30 06:14:00', '2026-04-30 06:14:00'),
(215, 2, NULL, 'failed', 0.27, 76.40, 'Confidence terlalu rendah (76.4%, minimum 80%). (kiosk)', '2026-04-30 06:14:05', '2026-04-30 06:14:05'),
(217, 2, NULL, 'failed', 0.26, 78.49, 'Confidence terlalu rendah (78.49%, minimum 80%). (kiosk)', '2026-04-30 06:14:10', '2026-04-30 06:14:10'),
(219, 2, NULL, 'failed', 0.27, 76.60, 'Confidence terlalu rendah (76.6%, minimum 80%). (kiosk)', '2026-04-30 06:14:15', '2026-04-30 06:14:15'),
(222, 2, NULL, 'failed', 0.30, 70.52, 'Confidence terlalu rendah (70.52%, minimum 80%). (kiosk)', '2026-04-30 06:14:20', '2026-04-30 06:14:20'),
(224, 2, NULL, 'failed', 0.29, 73.43, 'Confidence terlalu rendah (73.43%, minimum 80%). (kiosk)', '2026-04-30 06:14:25', '2026-04-30 06:14:25'),
(227, 2, NULL, 'failed', 0.34, 63.51, 'Confidence terlalu rendah (63.51%, minimum 80%). (kiosk)', '2026-04-30 06:14:30', '2026-04-30 06:14:30'),
(229, 2, NULL, 'failed', 0.54, 14.79, 'Confidence terlalu rendah (14.79%, minimum 80%). (kiosk)', '2026-04-30 06:14:34', '2026-04-30 06:14:34'),
(230, 2, NULL, 'failed', 0.27, 76.85, 'Confidence terlalu rendah (76.85%, minimum 80%). (kiosk)', '2026-04-30 06:14:35', '2026-04-30 06:14:35'),
(231, 10, NULL, 'failed', 0.50, 25.49, 'Confidence terlalu rendah (25.49%, minimum 80%). (kiosk)', '2026-04-30 06:14:35', '2026-04-30 06:14:35'),
(234, 2, NULL, 'failed', 0.29, 71.93, 'Confidence terlalu rendah (71.93%, minimum 80%). (kiosk)', '2026-04-30 06:14:40', '2026-04-30 06:14:40'),
(236, 2, NULL, 'failed', 0.30, 71.22, 'Confidence terlalu rendah (71.22%, minimum 80%). (kiosk)', '2026-04-30 06:14:45', '2026-04-30 06:14:45'),
(238, 2, NULL, 'failed', 0.30, 69.94, 'Confidence terlalu rendah (69.94%, minimum 80%). (kiosk)', '2026-04-30 06:14:50', '2026-04-30 06:14:50'),
(240, 2, NULL, 'failed', 0.30, 71.42, 'Confidence terlalu rendah (71.42%, minimum 80%). (kiosk)', '2026-04-30 06:14:57', '2026-04-30 06:14:57'),
(243, 2, NULL, 'failed', 0.29, 71.65, 'Confidence terlalu rendah (71.65%, minimum 80%). (kiosk)', '2026-04-30 06:15:02', '2026-04-30 06:15:02'),
(245, 2, NULL, 'failed', 0.27, 75.35, 'Confidence terlalu rendah (75.35%, minimum 80%). (kiosk)', '2026-04-30 06:15:07', '2026-04-30 06:15:07'),
(247, 2, NULL, 'failed', 0.27, 75.73, 'Confidence terlalu rendah (75.73%, minimum 80%). (kiosk)', '2026-04-30 06:15:12', '2026-04-30 06:15:12'),
(248, 2, NULL, 'failed', 0.28, 73.95, 'Confidence terlalu rendah (73.95%, minimum 80%). (kiosk)', '2026-04-30 06:15:17', '2026-04-30 06:15:17'),
(251, 2, NULL, 'failed', 0.25, 79.24, 'Confidence terlalu rendah (79.24%, minimum 80%). (kiosk)', '2026-04-30 06:15:22', '2026-04-30 06:15:22'),
(253, 2, NULL, 'failed', 0.30, 70.00, 'Confidence terlalu rendah (70%, minimum 80%). (kiosk)', '2026-04-30 06:15:27', '2026-04-30 06:15:27'),
(255, 2, NULL, 'failed', 0.32, 67.33, 'Confidence terlalu rendah (67.33%, minimum 80%). (kiosk)', '2026-04-30 06:15:32', '2026-04-30 06:15:32'),
(256, 2, NULL, 'failed', 0.30, 70.08, 'Confidence terlalu rendah (70.08%, minimum 80%). (kiosk)', '2026-04-30 06:15:40', '2026-04-30 06:15:40'),
(258, 10, NULL, 'failed', 0.52, 20.00, 'Confidence terlalu rendah (20%, minimum 80%). (kiosk)', '2026-04-30 06:15:42', '2026-04-30 06:15:42'),
(259, 2, NULL, 'failed', 0.29, 73.07, 'Confidence terlalu rendah (73.07%, minimum 80%). (kiosk)', '2026-04-30 06:15:49', '2026-04-30 06:15:49'),
(261, 2, NULL, 'failed', 0.32, 66.77, 'Confidence terlalu rendah (66.77%, minimum 80%). (kiosk)', '2026-04-30 06:15:54', '2026-04-30 06:15:54'),
(263, 2, NULL, 'failed', 0.29, 71.87, 'Confidence terlalu rendah (71.87%, minimum 80%). (kiosk)', '2026-04-30 06:15:59', '2026-04-30 06:15:59'),
(264, 2, NULL, 'failed', 0.36, 59.55, 'Confidence terlalu rendah (59.55%, minimum 80%). (kiosk)', '2026-04-30 06:16:04', '2026-04-30 06:16:04'),
(266, 2, NULL, 'failed', 0.36, 58.30, 'Confidence terlalu rendah (58.3%, minimum 80%). (kiosk)', '2026-04-30 06:16:09', '2026-04-30 06:16:09'),
(267, 12, NULL, 'failed', 0.53, 19.45, 'Confidence terlalu rendah (19.45%, minimum 80%). (kiosk)', '2026-04-30 06:16:09', '2026-04-30 06:16:09'),
(271, 2, NULL, 'failed', 0.34, 63.83, 'Confidence terlalu rendah (63.83%, minimum 80%). (kiosk)', '2026-04-30 06:16:24', '2026-04-30 06:16:24'),
(273, 2, NULL, 'failed', 0.33, 65.44, 'Confidence terlalu rendah (65.44%, minimum 80%). (kiosk)', '2026-04-30 06:16:29', '2026-04-30 06:16:29'),
(274, 2, NULL, 'failed', 0.36, 59.45, 'Confidence terlalu rendah (59.45%, minimum 80%). (kiosk)', '2026-04-30 06:16:34', '2026-04-30 06:16:34'),
(277, 2, NULL, 'failed', 0.32, 67.54, 'Confidence terlalu rendah (67.54%, minimum 80%). (kiosk)', '2026-04-30 06:16:39', '2026-04-30 06:16:39'),
(279, 2, NULL, 'failed', 0.33, 65.07, 'Confidence terlalu rendah (65.07%, minimum 80%). (kiosk)', '2026-04-30 06:16:44', '2026-04-30 06:16:44'),
(281, 2, NULL, 'failed', 0.29, 73.03, 'Confidence terlalu rendah (73.03%, minimum 80%). (kiosk)', '2026-04-30 06:16:49', '2026-04-30 06:16:49'),
(283, 2, NULL, 'failed', 0.31, 69.20, 'Confidence terlalu rendah (69.2%, minimum 80%). (kiosk)', '2026-04-30 06:16:59', '2026-04-30 06:16:59'),
(286, 2, NULL, 'failed', 0.39, 52.33, 'Confidence terlalu rendah (52.33%, minimum 80%). (kiosk)', '2026-04-30 06:17:04', '2026-04-30 06:17:04'),
(287, 10, NULL, 'failed', 0.53, 17.35, 'Confidence terlalu rendah (17.35%, minimum 80%). (kiosk)', '2026-04-30 06:17:06', '2026-04-30 06:17:06'),
(289, 2, NULL, 'failed', 0.35, 61.71, 'Confidence terlalu rendah (61.71%, minimum 80%). (kiosk)', '2026-04-30 06:17:09', '2026-04-30 06:17:09'),
(294, 2, NULL, 'failed', 0.54, 15.33, 'Confidence terlalu rendah (15.33%, minimum 80%). (kiosk)', '2026-04-30 06:17:26', '2026-04-30 06:17:26'),
(295, 2, NULL, 'failed', 0.39, 52.11, 'Confidence terlalu rendah (52.11%, minimum 80%). (kiosk)', '2026-04-30 06:17:27', '2026-04-30 06:17:27'),
(298, 2, NULL, 'failed', 0.39, 52.68, 'Confidence terlalu rendah (52.68%, minimum 80%). (kiosk)', '2026-04-30 06:17:34', '2026-04-30 06:17:34'),
(299, 2, NULL, 'failed', 0.31, 68.66, 'Confidence terlalu rendah (68.66%, minimum 80%). (kiosk)', '2026-04-30 06:17:40', '2026-04-30 06:17:40'),
(300, 2, NULL, 'failed', 0.29, 72.15, 'Confidence terlalu rendah (72.15%, minimum 80%). (kiosk)', '2026-04-30 06:17:45', '2026-04-30 06:17:45'),
(301, 2, NULL, 'failed', 0.30, 70.45, 'Confidence terlalu rendah (70.45%, minimum 80%). (kiosk)', '2026-04-30 06:17:50', '2026-04-30 06:17:50'),
(302, 12, NULL, 'failed', 0.43, 42.72, 'Confidence terlalu rendah (42.72%, minimum 80%). (kiosk)', '2026-04-30 06:17:50', '2026-04-30 06:17:50'),
(303, 2, NULL, 'failed', 0.31, 69.69, 'Confidence terlalu rendah (69.69%, minimum 80%). (kiosk)', '2026-04-30 06:17:57', '2026-04-30 06:17:57'),
(304, 10, NULL, 'failed', 0.54, 14.38, 'Confidence terlalu rendah (14.38%, minimum 80%). (kiosk)', '2026-04-30 06:17:57', '2026-04-30 06:17:57'),
(307, 2, NULL, 'failed', 0.32, 66.82, 'Confidence terlalu rendah (66.82%, minimum 80%). (kiosk)', '2026-04-30 06:18:10', '2026-04-30 06:18:10'),
(309, 2, NULL, 'failed', 0.46, 36.08, 'Confidence terlalu rendah (36.08%, minimum 80%). (kiosk)', '2026-04-30 06:18:14', '2026-04-30 06:18:14'),
(310, 10, NULL, 'failed', 0.51, 22.68, 'Confidence terlalu rendah (22.68%, minimum 80%). (kiosk)', '2026-04-30 06:18:17', '2026-04-30 06:18:17'),
(312, 2, NULL, 'failed', 0.46, 35.52, 'Confidence terlalu rendah (35.52%, minimum 80%). (kiosk)', '2026-04-30 06:18:19', '2026-04-30 06:18:19'),
(314, 2, NULL, 'failed', 0.47, 33.84, 'Confidence terlalu rendah (33.84%, minimum 80%). (kiosk)', '2026-04-30 06:18:24', '2026-04-30 06:18:24'),
(315, 12, NULL, 'failed', 0.38, 53.71, 'Confidence terlalu rendah (53.71%, minimum 80%). (kiosk)', '2026-04-30 06:18:26', '2026-04-30 06:18:26'),
(317, 2, NULL, 'failed', 0.38, 55.50, 'Confidence terlalu rendah (55.5%, minimum 80%). (kiosk)', '2026-04-30 06:18:30', '2026-04-30 06:18:30'),
(319, 2, NULL, 'failed', 0.36, 58.59, 'Confidence terlalu rendah (58.59%, minimum 80%). (kiosk)', '2026-04-30 06:18:35', '2026-04-30 06:18:35'),
(321, 2, NULL, 'failed', 0.31, 68.62, 'Confidence terlalu rendah (68.62%, minimum 80%). (kiosk)', '2026-04-30 06:18:40', '2026-04-30 06:18:40'),
(322, 10, NULL, 'failed', 0.52, 22.02, 'Confidence terlalu rendah (22.02%, minimum 80%). (kiosk)', '2026-04-30 06:18:42', '2026-04-30 06:18:42'),
(323, 10, NULL, 'failed', 0.58, 6.35, 'Confidence terlalu rendah (6.35%, minimum 80%). (kiosk)', '2026-04-30 06:18:43', '2026-04-30 06:18:43'),
(325, 2, NULL, 'failed', 0.36, 58.70, 'Confidence terlalu rendah (58.7%, minimum 80%). (kiosk)', '2026-04-30 06:18:45', '2026-04-30 06:18:45'),
(326, 2, NULL, 'failed', 0.52, 21.05, 'Confidence terlalu rendah (21.05%, minimum 80%). (kiosk)', '2026-04-30 06:18:46', '2026-04-30 06:18:46'),
(328, 2, NULL, 'failed', 0.32, 66.07, 'Confidence terlalu rendah (66.07%, minimum 80%). (kiosk)', '2026-04-30 06:18:50', '2026-04-30 06:18:50'),
(330, 2, NULL, 'failed', 0.38, 54.07, 'Confidence terlalu rendah (54.07%, minimum 80%). (kiosk)', '2026-04-30 06:18:55', '2026-04-30 06:18:55'),
(331, 2, NULL, 'failed', 0.50, 25.01, 'Confidence terlalu rendah (25.01%, minimum 80%). (kiosk)', '2026-04-30 06:18:56', '2026-04-30 06:18:56'),
(332, 10, NULL, 'failed', 0.48, 31.78, 'Confidence terlalu rendah (31.78%, minimum 80%). (kiosk)', '2026-04-30 06:18:57', '2026-04-30 06:18:57'),
(334, 2, NULL, 'failed', 0.37, 56.61, 'Confidence terlalu rendah (56.61%, minimum 80%). (kiosk)', '2026-04-30 06:19:00', '2026-04-30 06:19:00'),
(335, 10, NULL, 'failed', 0.50, 25.02, 'Confidence terlalu rendah (25.02%, minimum 80%). (kiosk)', '2026-04-30 06:19:02', '2026-04-30 06:19:02'),
(337, 10, NULL, 'failed', 0.51, 24.09, 'Confidence terlalu rendah (24.09%, minimum 80%). (kiosk)', '2026-04-30 06:19:04', '2026-04-30 06:19:04'),
(338, 2, NULL, 'failed', 0.43, 43.15, 'Confidence terlalu rendah (43.15%, minimum 80%). (kiosk)', '2026-04-30 06:19:07', '2026-04-30 06:19:07'),
(339, 2, NULL, 'failed', 0.54, 16.26, 'Confidence terlalu rendah (16.26%, minimum 80%). (kiosk)', '2026-04-30 06:19:08', '2026-04-30 06:19:08'),
(342, 10, NULL, 'failed', 0.43, 43.29, 'Confidence terlalu rendah (43.29%, minimum 80%). (kiosk)', '2026-04-30 06:19:16', '2026-04-30 06:19:16'),
(344, 2, NULL, 'failed', 0.35, 61.69, 'Confidence terlalu rendah (61.69%, minimum 80%). (kiosk)', '2026-04-30 06:19:19', '2026-04-30 06:19:19'),
(346, 2, NULL, 'failed', 0.30, 71.39, 'Confidence terlalu rendah (71.39%, minimum 80%). (kiosk)', '2026-04-30 06:19:24', '2026-04-30 06:19:24'),
(347, 10, NULL, 'failed', 0.57, 9.11, 'Confidence terlalu rendah (9.11%, minimum 80%). (kiosk)', '2026-04-30 06:19:25', '2026-04-30 06:19:25'),
(348, 2, NULL, 'failed', 0.31, 68.01, 'Confidence terlalu rendah (68.01%, minimum 80%). (kiosk)', '2026-04-30 06:19:29', '2026-04-30 06:19:29'),
(350, 2, NULL, 'failed', 0.48, 29.68, 'Confidence terlalu rendah (29.68%, minimum 80%). (kiosk)', '2026-04-30 06:19:34', '2026-04-30 06:19:34'),
(351, 2, NULL, 'failed', 0.31, 68.74, 'Confidence terlalu rendah (68.74%, minimum 80%). (kiosk)', '2026-04-30 06:19:35', '2026-04-30 06:19:35'),
(352, 2, NULL, 'failed', 0.55, 14.04, 'Confidence terlalu rendah (14.04%, minimum 80%). (kiosk)', '2026-04-30 06:19:36', '2026-04-30 06:19:36'),
(354, 2, NULL, 'failed', 0.31, 69.68, 'Confidence terlalu rendah (69.68%, minimum 80%). (kiosk)', '2026-04-30 06:19:40', '2026-04-30 06:19:40'),
(356, 2, NULL, 'failed', 0.33, 65.45, 'Confidence terlalu rendah (65.45%, minimum 80%). (kiosk)', '2026-04-30 06:19:45', '2026-04-30 06:19:45'),
(359, 2, NULL, 'failed', 0.34, 63.05, 'Confidence terlalu rendah (63.05%, minimum 80%). (kiosk)', '2026-04-30 06:19:50', '2026-04-30 06:19:50'),
(360, 12, NULL, 'failed', 0.56, 10.77, 'Confidence terlalu rendah (10.77%, minimum 80%). (kiosk)', '2026-04-30 06:19:54', '2026-04-30 06:19:54'),
(361, 2, NULL, 'failed', 0.36, 59.67, 'Confidence terlalu rendah (59.67%, minimum 80%). (kiosk)', '2026-04-30 06:19:55', '2026-04-30 06:19:55'),
(363, 2, NULL, 'failed', 0.34, 63.42, 'Confidence terlalu rendah (63.42%, minimum 80%). (kiosk)', '2026-04-30 06:20:00', '2026-04-30 06:20:00'),
(366, 2, NULL, 'failed', 0.31, 69.03, 'Confidence terlalu rendah (69.03%, minimum 80%). (kiosk)', '2026-04-30 06:20:05', '2026-04-30 06:20:05'),
(368, 2, NULL, 'failed', 0.31, 68.16, 'Confidence terlalu rendah (68.16%, minimum 80%). (kiosk)', '2026-04-30 06:20:13', '2026-04-30 06:20:13'),
(369, 2, NULL, 'failed', 0.43, 42.83, 'Confidence terlalu rendah (42.83%, minimum 80%). (kiosk)', '2026-04-30 06:20:18', '2026-04-30 06:20:18'),
(370, 2, NULL, 'failed', 0.38, 53.63, 'Confidence terlalu rendah (53.63%, minimum 80%). (kiosk)', '2026-04-30 06:20:18', '2026-04-30 06:20:18'),
(371, 2, NULL, 'failed', 0.34, 62.13, 'Confidence terlalu rendah (62.13%, minimum 80%). (kiosk)', '2026-04-30 06:20:23', '2026-04-30 06:20:23'),
(372, 2, NULL, 'failed', 0.45, 37.53, 'Confidence terlalu rendah (37.53%, minimum 80%). (kiosk)', '2026-04-30 06:20:23', '2026-04-30 06:20:23'),
(373, 2, NULL, 'failed', 0.29, 72.02, 'Confidence terlalu rendah (72.02%, minimum 80%). (kiosk)', '2026-04-30 06:20:28', '2026-04-30 06:20:28'),
(374, 2, NULL, 'failed', 0.47, 32.27, 'Confidence terlalu rendah (32.27%, minimum 80%). (kiosk)', '2026-04-30 06:20:28', '2026-04-30 06:20:28'),
(375, 2, NULL, 'failed', 0.33, 64.50, 'Confidence terlalu rendah (64.5%, minimum 80%). (kiosk)', '2026-04-30 06:20:33', '2026-04-30 06:20:33'),
(378, 2, NULL, 'failed', 0.28, 73.86, 'Confidence terlalu rendah (73.86%, minimum 80%). (kiosk)', '2026-04-30 06:20:38', '2026-04-30 06:20:38'),
(380, 2, NULL, 'failed', 0.33, 64.98, 'Confidence terlalu rendah (64.98%, minimum 80%). (kiosk)', '2026-04-30 06:20:43', '2026-04-30 06:20:43'),
(381, 2, NULL, 'failed', 0.31, 69.29, 'Confidence terlalu rendah (69.29%, minimum 80%). (kiosk)', '2026-04-30 06:20:48', '2026-04-30 06:20:48'),
(383, 2, NULL, 'failed', 0.34, 62.64, 'Confidence terlalu rendah (62.64%, minimum 80%). (kiosk)', '2026-04-30 06:20:53', '2026-04-30 06:20:53'),
(385, 12, NULL, 'failed', 0.45, 38.70, 'Confidence terlalu rendah (38.7%, minimum 80%). (kiosk)', '2026-04-30 06:20:58', '2026-04-30 06:20:58'),
(386, 2, NULL, 'failed', 0.34, 62.81, 'Confidence terlalu rendah (62.81%, minimum 80%). (kiosk)', '2026-04-30 06:20:58', '2026-04-30 06:20:58'),
(387, 2, NULL, 'failed', 0.29, 71.69, 'Confidence terlalu rendah (71.69%, minimum 80%). (kiosk)', '2026-04-30 06:21:03', '2026-04-30 06:21:03'),
(390, 2, NULL, 'failed', 0.29, 73.27, 'Confidence terlalu rendah (73.27%, minimum 80%). (kiosk)', '2026-04-30 06:21:08', '2026-04-30 06:21:08'),
(391, 2, NULL, 'failed', 0.29, 73.29, 'Confidence terlalu rendah (73.29%, minimum 80%). (kiosk)', '2026-04-30 06:21:13', '2026-04-30 06:21:13'),
(393, 2, NULL, 'failed', 0.30, 70.03, 'Confidence terlalu rendah (70.03%, minimum 80%). (kiosk)', '2026-04-30 06:21:18', '2026-04-30 06:21:18'),
(395, 2, NULL, 'failed', 0.38, 55.26, 'Confidence terlalu rendah (55.26%, minimum 80%). (kiosk)', '2026-04-30 06:21:23', '2026-04-30 06:21:23'),
(397, 2, NULL, 'failed', 0.33, 64.50, 'Confidence terlalu rendah (64.5%, minimum 80%). (kiosk)', '2026-04-30 06:21:30', '2026-04-30 06:21:30'),
(398, 2, NULL, 'failed', 0.33, 65.55, 'Confidence terlalu rendah (65.55%, minimum 80%). (kiosk)', '2026-04-30 06:21:37', '2026-04-30 06:21:37'),
(400, 2, NULL, 'failed', 0.29, 73.36, 'Confidence terlalu rendah (73.36%, minimum 80%). (kiosk)', '2026-04-30 06:21:49', '2026-04-30 06:21:49'),
(403, 2, NULL, 'failed', 0.31, 69.11, 'Confidence terlalu rendah (69.11%, minimum 80%). (kiosk)', '2026-04-30 06:21:54', '2026-04-30 06:21:54'),
(404, 2, NULL, 'failed', 0.36, 58.08, 'Confidence terlalu rendah (58.08%, minimum 80%). (kiosk)', '2026-04-30 06:21:59', '2026-04-30 06:21:59'),
(405, 2, NULL, 'failed', 0.33, 65.68, 'Confidence terlalu rendah (65.68%, minimum 80%). (kiosk)', '2026-04-30 06:22:04', '2026-04-30 06:22:04'),
(407, 2, NULL, 'failed', 0.36, 58.59, 'Confidence terlalu rendah (58.59%, minimum 80%). (kiosk)', '2026-04-30 06:22:09', '2026-04-30 06:22:09'),
(409, 2, NULL, 'failed', 0.30, 71.12, 'Confidence terlalu rendah (71.12%, minimum 80%). (kiosk)', '2026-04-30 06:22:14', '2026-04-30 06:22:14'),
(412, 2, NULL, 'failed', 0.29, 73.40, 'Confidence terlalu rendah (73.4%, minimum 80%). (kiosk)', '2026-04-30 06:22:19', '2026-04-30 06:22:19'),
(414, 2, NULL, 'failed', 0.31, 69.30, 'Confidence terlalu rendah (69.3%, minimum 80%). (kiosk)', '2026-04-30 06:22:24', '2026-04-30 06:22:24'),
(416, 2, NULL, 'failed', 0.32, 66.69, 'Confidence terlalu rendah (66.69%, minimum 80%). (kiosk)', '2026-04-30 06:22:29', '2026-04-30 06:22:29'),
(418, 2, NULL, 'failed', 0.32, 66.24, 'Confidence terlalu rendah (66.24%, minimum 80%). (kiosk)', '2026-04-30 06:22:34', '2026-04-30 06:22:34'),
(420, 2, NULL, 'failed', 0.33, 64.61, 'Confidence terlalu rendah (64.61%, minimum 80%). (kiosk)', '2026-04-30 06:22:39', '2026-04-30 06:22:39'),
(422, 12, NULL, 'failed', 0.41, 48.59, 'Confidence terlalu rendah (48.59%, minimum 80%). (kiosk)', '2026-04-30 06:22:44', '2026-04-30 06:22:44'),
(424, 12, NULL, 'failed', 0.46, 36.90, 'Confidence terlalu rendah (36.9%, minimum 80%). (kiosk)', '2026-04-30 06:22:54', '2026-04-30 06:22:54'),
(426, 12, NULL, 'failed', 0.40, 49.81, 'Confidence terlalu rendah (49.81%, minimum 80%). (kiosk)', '2026-04-30 06:22:59', '2026-04-30 06:22:59'),
(428, 12, NULL, 'failed', 0.39, 51.93, 'Confidence terlalu rendah (51.93%, minimum 80%). (kiosk)', '2026-04-30 06:23:04', '2026-04-30 06:23:04'),
(430, 12, NULL, 'failed', 0.38, 53.80, 'Confidence terlalu rendah (53.8%, minimum 80%). (kiosk)', '2026-04-30 06:23:09', '2026-04-30 06:23:09'),
(431, 12, NULL, 'failed', 0.43, 42.94, 'Confidence terlalu rendah (42.94%, minimum 80%). (kiosk)', '2026-04-30 06:23:14', '2026-04-30 06:23:14'),
(434, 12, NULL, 'failed', 0.38, 54.89, 'Confidence terlalu rendah (54.89%, minimum 80%). (kiosk)', '2026-04-30 06:23:19', '2026-04-30 06:23:19'),
(436, 10, NULL, 'failed', 0.53, 17.50, 'Confidence terlalu rendah (17.5%, minimum 80%). (kiosk)', '2026-04-30 06:23:29', '2026-04-30 06:23:29'),
(438, 2, NULL, 'failed', 0.45, 38.74, 'Confidence terlalu rendah (38.74%, minimum 80%). (kiosk)', '2026-04-30 06:23:29', '2026-04-30 06:23:29'),
(440, 2, NULL, 'failed', 0.43, 43.93, 'Confidence terlalu rendah (43.93%, minimum 80%). (kiosk)', '2026-04-30 06:23:34', '2026-04-30 06:23:34'),
(441, 2, NULL, 'failed', 0.36, 58.36, 'Confidence terlalu rendah (58.36%, minimum 80%). (kiosk)', '2026-04-30 06:23:34', '2026-04-30 06:23:34'),
(443, 2, NULL, 'failed', 0.32, 66.74, 'Confidence terlalu rendah (66.74%, minimum 80%). (kiosk)', '2026-04-30 06:23:39', '2026-04-30 06:23:39'),
(445, 12, NULL, 'failed', 0.40, 50.67, 'Confidence terlalu rendah (50.67%, minimum 80%). (kiosk)', '2026-04-30 06:23:44', '2026-04-30 06:23:44'),
(447, 12, NULL, 'failed', 0.48, 30.55, 'Confidence terlalu rendah (30.55%, minimum 80%). (kiosk)', '2026-04-30 06:23:49', '2026-04-30 06:23:49'),
(449, 2, NULL, 'failed', 0.35, 60.00, 'Confidence terlalu rendah (60%, minimum 80%). (kiosk)', '2026-04-30 06:23:54', '2026-04-30 06:23:54'),
(451, 2, NULL, 'failed', 0.33, 65.66, 'Confidence terlalu rendah (65.66%, minimum 80%). (kiosk)', '2026-04-30 06:23:59', '2026-04-30 06:23:59'),
(452, 2, NULL, 'failed', 0.51, 24.42, 'Confidence terlalu rendah (24.42%, minimum 80%). (kiosk)', '2026-04-30 06:24:04', '2026-04-30 06:24:04'),
(453, 10, NULL, 'failed', 0.50, 26.12, 'Confidence terlalu rendah (26.12%, minimum 80%). (kiosk)', '2026-04-30 06:24:04', '2026-04-30 06:24:04'),
(456, 2, NULL, 'failed', 0.37, 56.55, 'Confidence terlalu rendah (56.55%, minimum 80%). (kiosk)', '2026-04-30 06:24:14', '2026-04-30 06:24:14'),
(457, 2, NULL, 'failed', 0.38, 53.47, 'Confidence terlalu rendah (53.47%, minimum 80%). (kiosk)', '2026-04-30 06:24:19', '2026-04-30 06:24:19'),
(459, 2, NULL, 'failed', 0.38, 54.63, 'Confidence terlalu rendah (54.63%, minimum 80%). (kiosk)', '2026-04-30 06:24:24', '2026-04-30 06:24:24'),
(460, 12, NULL, 'failed', 0.36, 59.50, 'Confidence terlalu rendah (59.5%, minimum 80%). (kiosk)', '2026-04-30 06:24:29', '2026-04-30 06:24:29'),
(461, 2, NULL, 'failed', 0.30, 69.85, 'Confidence terlalu rendah (69.85%, minimum 80%). (kiosk)', '2026-04-30 06:24:34', '2026-04-30 06:24:34'),
(462, 10, NULL, 'failed', 0.43, 43.52, 'Confidence terlalu rendah (43.52%, minimum 80%). (kiosk)', '2026-04-30 06:24:34', '2026-04-30 06:24:34'),
(463, 2, NULL, 'failed', 0.30, 71.32, 'Confidence terlalu rendah (71.32%, minimum 80%). (kiosk)', '2026-04-30 06:24:39', '2026-04-30 06:24:39'),
(465, 2, NULL, 'failed', 0.47, 33.87, 'Confidence terlalu rendah (33.87%, minimum 80%). (kiosk)', '2026-04-30 06:24:51', '2026-04-30 06:24:51'),
(466, 12, NULL, 'failed', 0.57, 8.45, 'Confidence terlalu rendah (8.45%, minimum 80%). (kiosk)', '2026-04-30 06:24:56', '2026-04-30 06:24:56'),
(467, 2, NULL, 'failed', 0.31, 68.80, 'Confidence terlalu rendah (68.8%, minimum 80%). (kiosk)', '2026-04-30 06:25:01', '2026-04-30 06:25:01'),
(469, 2, NULL, 'failed', 0.35, 61.69, 'Confidence terlalu rendah (61.69%, minimum 80%). (kiosk)', '2026-04-30 06:25:06', '2026-04-30 06:25:06'),
(470, 10, NULL, 'failed', 0.49, 29.45, 'Confidence terlalu rendah (29.45%, minimum 80%). (kiosk)', '2026-04-30 06:25:07', '2026-04-30 06:25:07'),
(471, 10, NULL, 'failed', 0.54, 14.81, 'Confidence terlalu rendah (14.81%, minimum 80%). (kiosk)', '2026-04-30 06:25:10', '2026-04-30 06:25:10'),
(472, 2, NULL, 'failed', 0.34, 62.86, 'Confidence terlalu rendah (62.86%, minimum 80%). (kiosk)', '2026-04-30 06:25:11', '2026-04-30 06:25:11'),
(473, 10, NULL, 'failed', 0.48, 30.71, 'Confidence terlalu rendah (30.71%, minimum 80%). (kiosk)', '2026-04-30 06:25:12', '2026-04-30 06:25:12'),
(474, 10, NULL, 'failed', 0.51, 24.18, 'Confidence terlalu rendah (24.18%, minimum 80%). (kiosk)', '2026-04-30 06:25:15', '2026-04-30 06:25:15'),
(475, 2, NULL, 'failed', 0.34, 62.82, 'Confidence terlalu rendah (62.82%, minimum 80%). (kiosk)', '2026-04-30 06:25:15', '2026-04-30 06:25:15'),
(476, 12, NULL, 'failed', 0.45, 39.11, 'Confidence terlalu rendah (39.11%, minimum 80%). (kiosk)', '2026-04-30 06:25:18', '2026-04-30 06:25:18'),
(477, 2, NULL, 'failed', 0.35, 60.10, 'Confidence terlalu rendah (60.1%, minimum 80%). (kiosk)', '2026-04-30 06:25:21', '2026-04-30 06:25:21'),
(479, 2, NULL, 'success', 0.27, 86.23, 'Wajah cocok. (kiosk)', '2026-04-30 06:25:27', '2026-04-30 06:25:27'),
(485, 10, NULL, 'failed', 0.43, 65.76, 'Confidence terlalu rendah (65.76%, minimum 80%). (kiosk)', '2026-04-30 06:25:49', '2026-04-30 06:25:49'),
(486, 10, NULL, 'failed', 0.50, 54.75, 'Confidence terlalu rendah (54.75%, minimum 80%). (kiosk)', '2026-04-30 06:25:49', '2026-04-30 06:25:49'),
(488, 2, NULL, 'success', 0.31, 81.58, 'Wajah cocok. (kiosk)', '2026-04-30 06:25:53', '2026-04-30 06:25:53'),
(489, 2, NULL, 'failed', 0.57, 44.50, 'Confidence terlalu rendah (44.5%, minimum 80%). (kiosk)', '2026-04-30 06:25:53', '2026-04-30 06:25:53'),
(490, 12, NULL, 'failed', 0.40, 71.14, 'Confidence terlalu rendah (71.14%, minimum 80%). (kiosk)', '2026-04-30 06:25:54', '2026-04-30 06:25:54'),
(495, 12, NULL, 'failed', 0.52, 51.56, 'Confidence terlalu rendah (51.56%, minimum 80%). (kiosk)', '2026-04-30 06:26:14', '2026-04-30 06:26:14'),
(496, 2, NULL, 'failed', 0.57, 43.68, 'Confidence terlalu rendah (43.68%, minimum 80%). (kiosk)', '2026-04-30 06:26:14', '2026-04-30 06:26:14');
INSERT INTO `face_logs` (`id`, `user_id`, `absensi_id`, `status`, `distance`, `confidence`, `message`, `created_at`, `updated_at`) VALUES
(497, 2, NULL, 'failed', 0.54, 49.59, 'Confidence terlalu rendah (49.59%, minimum 80%). (kiosk)', '2026-04-30 06:26:15', '2026-04-30 06:26:15'),
(498, 2, NULL, 'failed', 0.46, 61.50, 'Confidence terlalu rendah (61.5%, minimum 80%). (kiosk)', '2026-04-30 06:26:16', '2026-04-30 06:26:16'),
(499, 2, NULL, 'failed', 0.38, 73.07, 'Confidence terlalu rendah (73.07%, minimum 80%). (kiosk)', '2026-04-30 06:26:16', '2026-04-30 06:26:16'),
(500, 12, NULL, 'failed', 0.49, 57.90, 'Confidence terlalu rendah (57.9%, minimum 80%). (kiosk)', '2026-04-30 06:26:20', '2026-04-30 06:26:20'),
(501, 2, NULL, 'failed', 0.53, 50.60, 'Confidence terlalu rendah (50.6%, minimum 80%). (kiosk)', '2026-04-30 06:26:20', '2026-04-30 06:26:20'),
(502, 2, NULL, 'failed', 0.38, 72.80, 'Confidence terlalu rendah (72.8%, minimum 80%). (kiosk)', '2026-04-30 06:26:21', '2026-04-30 06:26:21'),
(503, 12, NULL, 'failed', 0.46, 62.60, 'Confidence terlalu rendah (62.6%, minimum 80%). (kiosk)', '2026-04-30 06:26:21', '2026-04-30 06:26:21'),
(504, 10, NULL, 'failed', 0.55, 47.77, 'Confidence terlalu rendah (47.77%, minimum 80%). (kiosk)', '2026-04-30 06:26:21', '2026-04-30 06:26:21'),
(506, 2, NULL, 'failed', 0.55, 47.21, 'Confidence terlalu rendah (47.21%, minimum 80%). (kiosk)', '2026-04-30 06:26:25', '2026-04-30 06:26:25'),
(507, 12, NULL, 'failed', 0.49, 57.10, 'Confidence terlalu rendah (57.1%, minimum 80%). (kiosk)', '2026-04-30 06:26:26', '2026-04-30 06:26:26'),
(508, 2, NULL, 'failed', 0.51, 53.28, 'Confidence terlalu rendah (53.28%, minimum 80%). (kiosk)', '2026-04-30 06:26:26', '2026-04-30 06:26:26'),
(509, 2, NULL, 'failed', 0.39, 72.69, 'Confidence terlalu rendah (72.69%, minimum 80%). (kiosk)', '2026-04-30 06:26:27', '2026-04-30 06:26:27'),
(512, 2, NULL, 'failed', 0.48, 59.22, 'Confidence terlalu rendah (59.22%, minimum 80%). (kiosk)', '2026-04-30 06:26:37', '2026-04-30 06:26:37'),
(513, 12, NULL, 'failed', 0.51, 53.58, 'Confidence terlalu rendah (53.58%, minimum 80%). (kiosk)', '2026-04-30 06:26:42', '2026-04-30 06:26:42'),
(515, 2, NULL, 'failed', 0.48, 58.56, 'Confidence terlalu rendah (58.56%, minimum 80%). (kiosk)', '2026-04-30 06:26:45', '2026-04-30 06:26:45'),
(516, 2, NULL, 'failed', 0.38, 74.04, 'Confidence terlalu rendah (74.04%, minimum 80%). (kiosk)', '2026-04-30 06:26:50', '2026-04-30 06:26:50'),
(519, 10, NULL, 'failed', 0.55, 47.98, 'Confidence terlalu rendah (47.98%, minimum 80%). (kiosk)', '2026-04-30 06:26:53', '2026-04-30 06:26:53'),
(520, 2, NULL, 'success', 0.33, 80.06, 'Wajah cocok. (kiosk)', '2026-04-30 06:26:56', '2026-04-30 06:26:56'),
(521, 10, NULL, 'failed', 0.49, 56.91, 'Confidence terlalu rendah (56.91%, minimum 80%). (kiosk)', '2026-04-30 06:26:57', '2026-04-30 06:26:57'),
(522, 2, NULL, 'failed', 0.33, 79.96, 'Confidence terlalu rendah (79.96%, minimum 80%). (kiosk)', '2026-04-30 06:27:02', '2026-04-30 06:27:02'),
(524, 2, NULL, 'success', 0.32, 80.35, 'Wajah cocok. (kiosk)', '2026-04-30 06:27:07', '2026-04-30 06:27:07'),
(525, 10, NULL, 'failed', 0.40, 70.03, 'Confidence terlalu rendah (70.03%, minimum 80%). (kiosk)', '2026-04-30 06:27:07', '2026-04-30 06:27:07'),
(527, 2, NULL, 'failed', 0.51, 54.57, 'Confidence terlalu rendah (54.57%, minimum 80%). (kiosk)', '2026-04-30 06:27:09', '2026-04-30 06:27:09'),
(528, 2, NULL, 'failed', 0.37, 75.25, 'Confidence terlalu rendah (75.25%, minimum 80%). (kiosk)', '2026-04-30 06:27:11', '2026-04-30 06:27:11'),
(529, 2, NULL, 'failed', 0.51, 54.01, 'Confidence terlalu rendah (54.01%, minimum 80%). (kiosk)', '2026-04-30 06:27:15', '2026-04-30 06:27:15'),
(530, 2, NULL, 'failed', 0.35, 77.73, 'Confidence terlalu rendah (77.73%, minimum 80%). (kiosk)', '2026-04-30 06:27:16', '2026-04-30 06:27:16'),
(531, 10, NULL, 'failed', 0.52, 52.27, 'Confidence terlalu rendah (52.27%, minimum 80%). (kiosk)', '2026-04-30 06:27:17', '2026-04-30 06:27:17'),
(532, 10, NULL, 'failed', 0.43, 66.96, 'Confidence terlalu rendah (66.96%, minimum 80%). (kiosk)', '2026-04-30 06:27:17', '2026-04-30 06:27:17'),
(534, 10, NULL, 'failed', 0.45, 63.77, 'Confidence terlalu rendah (63.77%, minimum 80%). (kiosk)', '2026-04-30 06:27:18', '2026-04-30 06:27:18'),
(535, 12, NULL, 'failed', 0.45, 64.01, 'Confidence terlalu rendah (64.01%, minimum 80%). (kiosk)', '2026-04-30 06:27:22', '2026-04-30 06:27:22'),
(537, 2, NULL, 'failed', 0.43, 66.48, 'Confidence terlalu rendah (66.48%, minimum 80%). (kiosk)', '2026-04-30 06:27:24', '2026-04-30 06:27:24'),
(538, 2, NULL, 'success', 0.32, 80.57, 'Wajah cocok. (kiosk)', '2026-04-30 06:27:24', '2026-04-30 06:27:24'),
(539, 12, NULL, 'failed', 0.55, 47.55, 'Confidence terlalu rendah (47.55%, minimum 80%). (kiosk)', '2026-04-30 06:27:25', '2026-04-30 06:27:25'),
(541, 2, NULL, 'failed', 0.36, 76.26, 'Confidence terlalu rendah (76.26%, minimum 80%). (kiosk)', '2026-04-30 06:27:29', '2026-04-30 06:27:29'),
(543, 2, NULL, 'failed', 0.36, 75.88, 'Confidence terlalu rendah (75.88%, minimum 80%). (kiosk)', '2026-04-30 06:27:34', '2026-04-30 06:27:34'),
(545, 2, NULL, 'success', 0.32, 80.52, 'Wajah cocok. (kiosk)', '2026-04-30 06:27:39', '2026-04-30 06:27:39'),
(548, 2, NULL, 'success', 0.29, 83.82, 'Wajah cocok. (kiosk)', '2026-04-30 06:27:44', '2026-04-30 06:27:44'),
(550, 2, NULL, 'failed', 0.34, 78.91, 'Confidence terlalu rendah (78.91%, minimum 80%). (kiosk)', '2026-04-30 06:27:50', '2026-04-30 06:27:50'),
(552, 2, NULL, 'success', 0.30, 82.81, 'Wajah cocok. (kiosk)', '2026-04-30 06:27:55', '2026-04-30 06:27:55'),
(554, 2, NULL, 'failed', 0.33, 79.21, 'Confidence terlalu rendah (79.21%, minimum 80%). (kiosk)', '2026-04-30 06:27:59', '2026-04-30 06:27:59'),
(556, 2, NULL, 'failed', 0.35, 77.74, 'Confidence terlalu rendah (77.74%, minimum 80%). (kiosk)', '2026-04-30 06:28:04', '2026-04-30 06:28:04'),
(558, 2, NULL, 'failed', 0.46, 61.19, 'Confidence terlalu rendah (61.19%, minimum 80%). (kiosk)', '2026-04-30 06:28:10', '2026-04-30 06:28:10'),
(559, 2, NULL, 'failed', 0.38, 73.87, 'Confidence terlalu rendah (73.87%, minimum 80%). (kiosk)', '2026-04-30 06:28:11', '2026-04-30 06:28:11'),
(561, 2, NULL, 'failed', 0.40, 70.22, 'Confidence terlalu rendah (70.22%, minimum 80%). (kiosk)', '2026-04-30 06:28:14', '2026-04-30 06:28:14'),
(562, 10, NULL, 'failed', 0.43, 65.98, 'Confidence terlalu rendah (65.98%, minimum 80%). (kiosk)', '2026-04-30 06:28:16', '2026-04-30 06:28:16'),
(564, 10, NULL, 'failed', 0.53, 51.37, 'Confidence terlalu rendah (51.37%, minimum 80%). (kiosk)', '2026-04-30 06:28:22', '2026-04-30 06:28:22'),
(566, 10, NULL, 'failed', 0.54, 48.98, 'Confidence terlalu rendah (48.98%, minimum 80%). (kiosk)', '2026-04-30 06:28:27', '2026-04-30 06:28:27'),
(568, 2, NULL, 'failed', 0.44, 65.49, 'Confidence terlalu rendah (65.49%, minimum 80%). (kiosk)', '2026-04-30 06:28:31', '2026-04-30 06:28:31'),
(569, 2, NULL, 'failed', 0.33, 79.45, 'Confidence terlalu rendah (79.45%, minimum 80%). (kiosk)', '2026-04-30 06:28:32', '2026-04-30 06:28:32'),
(571, 2, NULL, 'failed', 0.34, 78.70, 'Confidence terlalu rendah (78.7%, minimum 80%). (kiosk)', '2026-04-30 06:28:37', '2026-04-30 06:28:37'),
(573, 2, NULL, 'success', 0.28, 84.89, 'Wajah cocok. (kiosk)', '2026-04-30 06:28:42', '2026-04-30 06:28:42'),
(575, 2, NULL, 'failed', 0.46, 62.10, 'Confidence terlalu rendah (62.1%, minimum 80%). (kiosk)', '2026-04-30 06:28:44', '2026-04-30 06:28:44'),
(576, 2, NULL, 'success', 0.32, 81.26, 'Wajah cocok. (kiosk)', '2026-04-30 06:28:46', '2026-04-30 06:28:46'),
(577, 2, NULL, 'failed', 0.48, 58.21, 'Confidence terlalu rendah (58.21%, minimum 80%). (kiosk)', '2026-04-30 06:28:50', '2026-04-30 06:28:50'),
(578, 2, NULL, 'success', 0.31, 81.66, 'Wajah cocok. (kiosk)', '2026-04-30 06:28:51', '2026-04-30 06:28:51'),
(579, 2, NULL, 'failed', 0.47, 60.27, 'Confidence terlalu rendah (60.27%, minimum 80%). (kiosk)', '2026-04-30 06:28:55', '2026-04-30 06:28:55'),
(580, 10, NULL, 'failed', 0.52, 51.49, 'Confidence terlalu rendah (51.49%, minimum 80%). (kiosk)', '2026-04-30 06:28:55', '2026-04-30 06:28:55'),
(581, 2, NULL, 'failed', 0.34, 78.13, 'Confidence terlalu rendah (78.13%, minimum 80%). (kiosk)', '2026-04-30 06:28:56', '2026-04-30 06:28:56'),
(583, 2, NULL, 'success', 0.30, 83.03, 'Wajah cocok. (kiosk)', '2026-04-30 06:29:01', '2026-04-30 06:29:01'),
(584, 2, NULL, 'success', 0.28, 85.19, 'Wajah cocok. (kiosk)', '2026-04-30 06:29:07', '2026-04-30 06:29:07'),
(585, 2, NULL, 'success', 0.32, 81.43, 'Wajah cocok. (kiosk)', '2026-04-30 06:29:11', '2026-04-30 06:29:11'),
(588, 2, NULL, 'failed', 0.38, 73.99, 'Confidence terlalu rendah (73.99%, minimum 80%). (kiosk)', '2026-04-30 06:29:16', '2026-04-30 06:29:16'),
(590, 2, NULL, 'failed', 0.33, 79.37, 'Confidence terlalu rendah (79.37%, minimum 80%). (kiosk)', '2026-04-30 06:29:22', '2026-04-30 06:29:22'),
(592, 2, NULL, 'failed', 0.39, 71.61, 'Confidence terlalu rendah (71.61%, minimum 80%). (kiosk)', '2026-04-30 06:29:27', '2026-04-30 06:29:27'),
(595, 2, NULL, 'failed', 0.33, 79.30, 'Confidence terlalu rendah (79.3%, minimum 80%). (kiosk)', '2026-04-30 06:29:34', '2026-04-30 06:29:34'),
(597, 2, NULL, 'failed', 0.56, 45.21, 'Confidence terlalu rendah (45.21%, minimum 80%). (kiosk)', '2026-04-30 06:29:37', '2026-04-30 06:29:37'),
(598, 2, NULL, 'failed', 0.35, 77.15, 'Confidence terlalu rendah (77.15%, minimum 80%). (kiosk)', '2026-04-30 06:29:40', '2026-04-30 06:29:40'),
(600, 12, NULL, 'failed', 0.35, 77.62, 'Confidence terlalu rendah (77.62%, minimum 80%). (kiosk)', '2026-04-30 06:29:45', '2026-04-30 06:29:45'),
(601, 12, NULL, 'failed', 0.48, 59.28, 'Confidence terlalu rendah (59.28%, minimum 80%). (kiosk)', '2026-04-30 06:29:45', '2026-04-30 06:29:45'),
(604, 2, NULL, 'failed', 0.40, 70.67, 'Confidence terlalu rendah (70.67%, minimum 80%). (kiosk)', '2026-04-30 06:29:54', '2026-04-30 06:29:54'),
(607, 2, NULL, 'failed', 0.36, 76.10, 'Confidence terlalu rendah (76.1%, minimum 80%). (kiosk)', '2026-04-30 06:29:58', '2026-04-30 06:29:58'),
(610, 2, NULL, 'failed', 0.33, 79.69, 'Confidence terlalu rendah (79.69%, minimum 80%). (kiosk)', '2026-04-30 06:30:04', '2026-04-30 06:30:04'),
(611, 2, NULL, 'failed', 0.51, 54.05, 'Confidence terlalu rendah (54.05%, minimum 80%). (kiosk)', '2026-04-30 06:30:07', '2026-04-30 06:30:07'),
(612, 2, NULL, 'success', 0.30, 83.38, 'Wajah cocok. (kiosk)', '2026-04-30 06:30:09', '2026-04-30 06:30:09'),
(613, 10, NULL, 'failed', 0.61, 37.14, 'Confidence terlalu rendah (37.14%, minimum 80%). (kiosk)', '2026-04-30 06:30:10', '2026-04-30 06:30:10'),
(614, 2, NULL, 'failed', 0.54, 48.51, 'Confidence terlalu rendah (48.51%, minimum 80%). (kiosk)', '2026-04-30 06:30:11', '2026-04-30 06:30:11'),
(616, 2, NULL, 'success', 0.32, 80.98, 'Wajah cocok. (kiosk)', '2026-04-30 06:30:14', '2026-04-30 06:30:14'),
(618, 12, NULL, 'failed', 0.55, 47.20, 'Confidence terlalu rendah (47.2%, minimum 80%). (kiosk)', '2026-04-30 06:30:16', '2026-04-30 06:30:16'),
(619, 10, NULL, 'failed', 0.52, 52.66, 'Confidence terlalu rendah (52.66%, minimum 80%). (kiosk)', '2026-04-30 06:30:17', '2026-04-30 06:30:17'),
(620, 2, NULL, 'failed', 0.56, 45.69, 'Confidence terlalu rendah (45.69%, minimum 80%). (kiosk)', '2026-04-30 06:30:17', '2026-04-30 06:30:17'),
(621, 2, NULL, 'success', 0.31, 82.26, 'Wajah cocok. (kiosk)', '2026-04-30 06:30:19', '2026-04-30 06:30:19'),
(622, 2, NULL, 'failed', 0.54, 48.74, 'Confidence terlalu rendah (48.74%, minimum 80%). (kiosk)', '2026-04-30 06:30:22', '2026-04-30 06:30:22'),
(623, 10, NULL, 'failed', 0.51, 53.32, 'Confidence terlalu rendah (53.32%, minimum 80%). (kiosk)', '2026-04-30 06:30:24', '2026-04-30 06:30:24'),
(624, 2, NULL, 'success', 0.31, 81.75, 'Wajah cocok. (kiosk)', '2026-04-30 06:30:25', '2026-04-30 06:30:25'),
(625, 16, NULL, 'failed', 0.35, 77.28, 'Confidence terlalu rendah (77.28%, minimum 80%). (kiosk)', '2026-05-04 05:35:55', '2026-05-04 05:35:55'),
(626, 16, NULL, 'success', 0.26, 87.35, 'Wajah cocok. (kiosk)', '2026-05-04 05:36:00', '2026-05-04 05:36:00'),
(627, 16, 63, 'success', 0.26, 87.35, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-04 05:36:00', '2026-05-04 05:36:00'),
(628, 12, NULL, 'failed', 0.49, 56.82, 'Confidence terlalu rendah (56.82%, minimum 80%). (kiosk)', '2026-05-04 05:36:03', '2026-05-04 05:36:03'),
(629, 16, NULL, 'success', 0.24, 89.09, 'Wajah cocok. (kiosk)', '2026-05-04 05:36:05', '2026-05-04 05:36:05'),
(630, 16, NULL, 'failed', 0.48, 59.22, 'Confidence terlalu rendah (59.22%, minimum 80%). (kiosk)', '2026-05-04 05:36:06', '2026-05-04 05:36:06'),
(631, 16, NULL, 'failed', 0.50, 55.22, 'Confidence terlalu rendah (55.22%, minimum 80%). (kiosk)', '2026-05-04 05:36:11', '2026-05-04 05:36:11'),
(632, 16, NULL, 'success', 0.25, 88.55, 'Wajah cocok. (kiosk)', '2026-05-04 05:36:21', '2026-05-04 05:36:21'),
(633, 16, NULL, 'failed', 0.53, 51.29, 'Confidence terlalu rendah (51.29%, minimum 80%). (kiosk)', '2026-05-04 05:36:26', '2026-05-04 05:36:26'),
(634, 16, NULL, 'success', 0.28, 84.90, 'Wajah cocok. (kiosk)', '2026-05-04 05:36:31', '2026-05-04 05:36:31'),
(635, 16, NULL, 'failed', 0.42, 67.68, 'Confidence terlalu rendah (67.68%, minimum 80%). (kiosk)', '2026-05-04 05:36:35', '2026-05-04 05:36:35'),
(636, 16, NULL, 'failed', 0.54, 49.48, 'Confidence terlalu rendah (49.48%, minimum 80%). (kiosk)', '2026-05-04 05:36:42', '2026-05-04 05:36:42'),
(637, 2, NULL, 'success', 0.33, 80.01, 'Wajah cocok. (kiosk)', '2026-05-04 05:36:42', '2026-05-04 05:36:42'),
(638, 2, 64, 'success', 0.33, 80.01, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-04 05:36:42', '2026-05-04 05:36:42'),
(639, 16, NULL, 'failed', 0.54, 49.48, 'Confidence terlalu rendah (49.48%, minimum 80%). (kiosk)', '2026-05-04 05:37:05', '2026-05-04 05:37:05'),
(640, 16, NULL, 'failed', 0.46, 62.42, 'Confidence terlalu rendah (62.42%, minimum 80%). (kiosk)', '2026-05-04 05:37:15', '2026-05-04 05:37:15'),
(641, 2, NULL, 'failed', 0.53, 50.58, 'Confidence terlalu rendah (50.58%, minimum 80%). (kiosk)', '2026-05-04 05:37:34', '2026-05-04 05:37:34'),
(642, 16, NULL, 'failed', 0.40, 71.07, 'Confidence terlalu rendah (71.07%, minimum 80%). (kiosk)', '2026-05-04 05:37:35', '2026-05-04 05:37:35'),
(643, 16, NULL, 'failed', 0.43, 66.84, 'Confidence terlalu rendah (66.84%, minimum 80%). (kiosk)', '2026-05-04 05:37:37', '2026-05-04 05:37:37'),
(644, 16, NULL, 'failed', 0.40, 70.79, 'Confidence terlalu rendah (70.79%, minimum 80%). (kiosk)', '2026-05-04 05:37:40', '2026-05-04 05:37:40'),
(645, 16, NULL, 'failed', 0.34, 78.13, 'Confidence terlalu rendah (78.13%, minimum 80%). (kiosk)', '2026-05-04 05:37:45', '2026-05-04 05:37:45'),
(646, 16, NULL, 'failed', 0.45, 63.09, 'Confidence terlalu rendah (63.09%, minimum 80%). (kiosk)', '2026-05-04 05:37:46', '2026-05-04 05:37:46'),
(647, 16, NULL, 'failed', 0.42, 67.69, 'Confidence terlalu rendah (67.69%, minimum 80%). (kiosk)', '2026-05-04 05:37:47', '2026-05-04 05:37:47'),
(648, 16, NULL, 'success', 0.27, 86.02, 'Wajah cocok. (kiosk)', '2026-05-04 05:37:56', '2026-05-04 05:37:56'),
(649, 2, NULL, 'failed', 0.35, 77.46, 'Confidence terlalu rendah (77.46%, minimum 80%). (kiosk)', '2026-05-04 05:38:41', '2026-05-04 05:38:41'),
(650, 2, NULL, 'success', 0.29, 84.54, 'Wajah cocok. (kiosk)', '2026-05-04 05:38:46', '2026-05-04 05:38:46'),
(651, 2, NULL, 'failed', 0.35, 76.69, 'Confidence terlalu rendah (76.69%, minimum 80%). (kiosk)', '2026-05-04 05:39:28', '2026-05-04 05:39:28'),
(652, 2, NULL, 'success', 0.21, 91.47, 'Wajah cocok. (kiosk)', '2026-05-04 05:39:33', '2026-05-04 05:39:33'),
(653, 10, NULL, 'failed', 0.44, 64.58, 'Confidence terlalu rendah (64.58%, minimum 80%). (kiosk)', '2026-05-04 05:39:43', '2026-05-04 05:39:43'),
(654, 10, NULL, 'failed', 0.41, 69.71, 'Confidence terlalu rendah (69.71%, minimum 80%). (kiosk)', '2026-05-04 05:39:50', '2026-05-04 05:39:50'),
(655, 16, NULL, 'failed', 0.39, 72.42, 'Confidence terlalu rendah (72.42%, minimum 80%). (kiosk)', '2026-05-04 05:39:55', '2026-05-04 05:39:55'),
(656, 16, NULL, 'failed', 0.44, 64.83, 'Confidence terlalu rendah (64.83%, minimum 80%). (kiosk)', '2026-05-04 05:40:00', '2026-05-04 05:40:00'),
(657, 16, NULL, 'failed', 0.48, 59.50, 'Confidence terlalu rendah (59.5%, minimum 80%). (kiosk)', '2026-05-04 05:40:15', '2026-05-04 05:40:15'),
(658, 16, NULL, 'failed', 0.43, 66.97, 'Confidence terlalu rendah (66.97%, minimum 80%). (kiosk)', '2026-05-04 05:40:26', '2026-05-04 05:40:26'),
(659, 16, NULL, 'failed', 0.43, 66.69, 'Confidence terlalu rendah (66.69%, minimum 80%). (kiosk)', '2026-05-04 05:40:37', '2026-05-04 05:40:37'),
(660, 10, NULL, 'failed', 0.44, 64.67, 'Confidence terlalu rendah (64.67%, minimum 80%). (kiosk)', '2026-05-04 05:40:42', '2026-05-04 05:40:42'),
(661, 16, NULL, 'failed', 0.38, 72.85, 'Confidence terlalu rendah (72.85%, minimum 80%). (kiosk)', '2026-05-04 05:40:51', '2026-05-04 05:40:51'),
(662, 16, NULL, 'failed', 0.34, 79.04, 'Confidence terlalu rendah (79.04%, minimum 80%). (kiosk)', '2026-05-04 05:40:58', '2026-05-04 05:40:58'),
(663, 2, NULL, 'failed', 0.38, 72.80, 'Confidence terlalu rendah (72.8%, minimum 80%). (kiosk)', '2026-05-04 05:41:03', '2026-05-04 05:41:03'),
(664, 10, NULL, 'failed', 0.46, 62.65, 'Confidence terlalu rendah (62.65%, minimum 80%). (kiosk)', '2026-05-04 05:41:08', '2026-05-04 05:41:08'),
(665, 16, NULL, 'success', 0.32, 80.37, 'Wajah cocok. (kiosk)', '2026-05-04 05:41:13', '2026-05-04 05:41:13'),
(666, 16, NULL, 'failed', 0.43, 66.65, 'Confidence terlalu rendah (66.65%, minimum 80%). (kiosk)', '2026-05-04 05:41:15', '2026-05-04 05:41:15'),
(667, 16, NULL, 'failed', 0.34, 78.24, 'Confidence terlalu rendah (78.24%, minimum 80%). (kiosk)', '2026-05-04 05:41:18', '2026-05-04 05:41:18'),
(668, 16, NULL, 'success', 0.32, 81.23, 'Wajah cocok. (kiosk)', '2026-05-04 05:41:23', '2026-05-04 05:41:23'),
(669, 16, NULL, 'success', 0.33, 80.18, 'Wajah cocok. (kiosk)', '2026-05-04 05:41:28', '2026-05-04 05:41:28'),
(670, 16, NULL, 'success', 0.29, 84.05, 'Wajah cocok. (kiosk)', '2026-05-04 05:41:33', '2026-05-04 05:41:33'),
(671, 16, NULL, 'success', 0.25, 88.38, 'Wajah cocok. (kiosk)', '2026-05-04 05:41:38', '2026-05-04 05:41:38'),
(672, 16, NULL, 'failed', 0.34, 78.84, 'Confidence terlalu rendah (78.84%, minimum 80%). (kiosk)', '2026-05-04 05:41:43', '2026-05-04 05:41:43'),
(673, 2, NULL, 'failed', 0.43, 66.87, 'Confidence terlalu rendah (66.87%, minimum 80%). (kiosk)', '2026-05-04 05:42:17', '2026-05-04 05:42:17'),
(674, 6, NULL, 'failed', 0.34, 78.08, 'Confidence terlalu rendah (78.08%, minimum 80%). (kiosk)', '2026-05-04 05:43:44', '2026-05-04 05:43:44'),
(675, 16, NULL, 'failed', 0.39, 72.05, 'Confidence terlalu rendah (72.05%, minimum 80%). (kiosk)', '2026-05-04 05:43:47', '2026-05-04 05:43:47'),
(676, 6, NULL, 'success', 0.18, 93.93, 'Wajah cocok. (kiosk)', '2026-05-04 05:43:48', '2026-05-04 05:43:48'),
(677, 6, 65, 'success', 0.18, 93.93, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-04 05:43:48', '2026-05-04 05:43:48'),
(678, 6, NULL, 'success', 0.26, 87.34, 'Wajah cocok. (kiosk)', '2026-05-04 05:43:54', '2026-05-04 05:43:54'),
(679, 6, NULL, 'success', 0.22, 90.76, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:02', '2026-05-04 05:44:02'),
(680, 6, NULL, 'success', 0.32, 80.50, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:03', '2026-05-04 05:44:03'),
(681, 6, NULL, 'failed', 0.33, 79.71, 'Confidence terlalu rendah (79.71%, minimum 80%). (kiosk)', '2026-05-04 05:44:10', '2026-05-04 05:44:10'),
(682, 16, NULL, 'success', 0.30, 83.62, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:10', '2026-05-04 05:44:10'),
(683, 6, NULL, 'success', 0.29, 84.05, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:15', '2026-05-04 05:44:15'),
(684, 16, NULL, 'success', 0.28, 85.40, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:15', '2026-05-04 05:44:15'),
(685, 6, NULL, 'success', 0.27, 86.59, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:27', '2026-05-04 05:44:27'),
(686, 16, NULL, 'failed', 0.47, 60.69, 'Confidence terlalu rendah (60.69%, minimum 80%). (kiosk)', '2026-05-04 05:44:27', '2026-05-04 05:44:27'),
(687, 16, NULL, 'success', 0.32, 80.53, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:28', '2026-05-04 05:44:28'),
(688, 6, NULL, 'success', 0.33, 80.24, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:32', '2026-05-04 05:44:32'),
(689, 2, NULL, 'success', 0.29, 84.06, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:32', '2026-05-04 05:44:32'),
(690, 16, NULL, 'failed', 0.34, 77.93, 'Confidence terlalu rendah (77.93%, minimum 80%). (kiosk)', '2026-05-04 05:44:33', '2026-05-04 05:44:33'),
(691, 6, NULL, 'success', 0.23, 89.72, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:37', '2026-05-04 05:44:37'),
(692, 2, NULL, 'failed', 0.37, 74.32, 'Confidence terlalu rendah (74.32%, minimum 80%). (kiosk)', '2026-05-04 05:44:37', '2026-05-04 05:44:37'),
(693, 16, NULL, 'failed', 0.35, 77.85, 'Confidence terlalu rendah (77.85%, minimum 80%). (kiosk)', '2026-05-04 05:44:38', '2026-05-04 05:44:38'),
(694, 6, NULL, 'success', 0.26, 86.85, 'Wajah cocok. (kiosk)', '2026-05-04 05:44:42', '2026-05-04 05:44:42'),
(695, 2, NULL, 'failed', 0.42, 68.04, 'Confidence terlalu rendah (68.04%, minimum 80%). (kiosk)', '2026-05-04 05:44:43', '2026-05-04 05:44:43'),
(696, 16, NULL, 'failed', 0.34, 78.23, 'Confidence terlalu rendah (78.23%, minimum 80%). (kiosk)', '2026-05-04 05:44:43', '2026-05-04 05:44:43'),
(697, 6, NULL, 'failed', 0.42, 67.27, 'Confidence terlalu rendah (67.27%, minimum 80%). (kiosk)', '2026-05-04 05:44:43', '2026-05-04 05:44:43'),
(698, 6, NULL, 'success', 0.30, 83.25, 'Wajah cocok. (kiosk)', '2026-05-04 05:45:11', '2026-05-04 05:45:11'),
(699, 6, 65, 'success', 0.30, 83.25, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-04 05:45:11', '2026-05-04 05:45:11'),
(700, 2, NULL, 'failed', 0.36, 75.63, 'Confidence terlalu rendah (75.63%, minimum 80%). (kiosk)', '2026-05-04 05:45:12', '2026-05-04 05:45:12'),
(701, 16, NULL, 'success', 0.31, 81.79, 'Wajah cocok. (kiosk)', '2026-05-04 05:45:13', '2026-05-04 05:45:13'),
(702, 16, 63, 'success', 0.31, 81.79, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-04 05:45:13', '2026-05-04 05:45:13'),
(703, 6, NULL, 'success', 0.30, 83.00, 'Wajah cocok. (kiosk)', '2026-05-04 05:45:16', '2026-05-04 05:45:16'),
(704, 2, NULL, 'failed', 0.33, 79.75, 'Confidence terlalu rendah (79.75%, minimum 80%). (kiosk)', '2026-05-04 05:45:17', '2026-05-04 05:45:17'),
(705, 10, NULL, 'failed', 0.41, 69.58, 'Confidence terlalu rendah (69.58%, minimum 80%). (kiosk)', '2026-05-04 05:45:17', '2026-05-04 05:45:17'),
(706, 16, NULL, 'success', 0.32, 80.99, 'Wajah cocok. (kiosk)', '2026-05-04 05:45:18', '2026-05-04 05:45:18'),
(707, 6, NULL, 'success', 0.28, 85.46, 'Wajah cocok. (kiosk)', '2026-05-04 05:45:21', '2026-05-04 05:45:21'),
(708, 2, NULL, 'failed', 0.36, 75.53, 'Confidence terlalu rendah (75.53%, minimum 80%). (kiosk)', '2026-05-04 05:45:22', '2026-05-04 05:45:22'),
(709, 16, NULL, 'failed', 0.48, 58.96, 'Confidence terlalu rendah (58.96%, minimum 80%). (kiosk)', '2026-05-04 05:45:22', '2026-05-04 05:45:22'),
(710, 16, NULL, 'success', 0.26, 87.28, 'Wajah cocok. (kiosk)', '2026-05-04 05:45:23', '2026-05-04 05:45:23'),
(711, 2, NULL, 'success', 0.33, 80.29, 'Wajah cocok. (kiosk)', '2026-05-04 05:45:27', '2026-05-04 05:45:27'),
(712, 2, 64, 'success', 0.33, 80.29, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-04 05:45:27', '2026-05-04 05:45:27'),
(713, 16, NULL, 'failed', 0.37, 75.20, 'Confidence terlalu rendah (75.2%, minimum 80%). (kiosk)', '2026-05-04 05:45:30', '2026-05-04 05:45:30'),
(714, 16, NULL, 'success', 0.33, 80.03, 'Wajah cocok. (kiosk)', '2026-05-04 05:45:46', '2026-05-04 05:45:46'),
(715, 10, NULL, 'failed', 0.51, 53.10, 'Confidence terlalu rendah (53.1%, minimum 80%). (kiosk)', '2026-05-04 05:45:47', '2026-05-04 05:45:47'),
(716, 10, NULL, 'failed', 0.38, 73.99, 'Confidence terlalu rendah (73.99%, minimum 80%). (kiosk)', '2026-05-04 05:45:51', '2026-05-04 05:45:51'),
(717, 2, NULL, 'failed', 0.35, 77.88, 'Confidence terlalu rendah (77.88%, minimum 80%). (kiosk)', '2026-05-04 05:45:56', '2026-05-04 05:45:56'),
(718, 16, NULL, 'failed', 0.43, 66.04, 'Confidence terlalu rendah (66.04%, minimum 80%). (kiosk)', '2026-05-04 05:45:58', '2026-05-04 05:45:58'),
(719, 10, NULL, 'failed', 0.49, 57.58, 'Confidence terlalu rendah (57.58%, minimum 80%). (kiosk)', '2026-05-04 05:46:02', '2026-05-04 05:46:02'),
(720, 10, NULL, 'failed', 0.43, 67.01, 'Confidence terlalu rendah (67.01%, minimum 80%). (kiosk)', '2026-05-04 05:46:27', '2026-05-04 05:46:27'),
(721, 2, NULL, 'success', 0.31, 82.00, 'Wajah cocok. (kiosk)', '2026-05-04 05:46:28', '2026-05-04 05:46:28'),
(722, 2, NULL, 'success', 0.32, 80.39, 'Wajah cocok. (kiosk)', '2026-05-04 05:46:36', '2026-05-04 05:46:36'),
(723, 2, NULL, 'failed', 0.34, 78.18, 'Confidence terlalu rendah (78.18%, minimum 80%). (kiosk)', '2026-05-04 05:46:41', '2026-05-04 05:46:41'),
(724, 6, NULL, 'failed', 0.36, 75.45, 'Confidence terlalu rendah (75.45%, minimum 80%). (kiosk)', '2026-05-04 05:46:46', '2026-05-04 05:46:46'),
(725, 2, NULL, 'failed', 0.33, 79.15, 'Confidence terlalu rendah (79.15%, minimum 80%). (kiosk)', '2026-05-04 05:46:51', '2026-05-04 05:46:51'),
(726, 6, NULL, 'failed', 0.35, 77.53, 'Confidence terlalu rendah (77.53%, minimum 80%). (kiosk)', '2026-05-04 05:46:56', '2026-05-04 05:46:56'),
(727, 2, NULL, 'failed', 0.33, 79.23, 'Confidence terlalu rendah (79.23%, minimum 80%). (kiosk)', '2026-05-04 05:47:01', '2026-05-04 05:47:01'),
(728, 10, NULL, 'failed', 0.36, 76.07, 'Confidence terlalu rendah (76.07%, minimum 80%). (kiosk)', '2026-05-04 05:47:06', '2026-05-04 05:47:06'),
(729, 10, NULL, 'failed', 0.37, 74.41, 'Confidence terlalu rendah (74.41%, minimum 80%). (kiosk)', '2026-05-04 05:47:11', '2026-05-04 05:47:11'),
(730, 10, NULL, 'failed', 0.38, 73.52, 'Confidence terlalu rendah (73.52%, minimum 80%). (kiosk)', '2026-05-04 05:47:16', '2026-05-04 05:47:16'),
(731, 2, NULL, 'failed', 0.33, 79.18, 'Confidence terlalu rendah (79.18%, minimum 80%). (kiosk)', '2026-05-04 05:47:21', '2026-05-04 05:47:21'),
(732, 2, NULL, 'success', 0.33, 80.00, 'Wajah cocok. (kiosk)', '2026-05-04 05:47:26', '2026-05-04 05:47:26'),
(733, 2, NULL, 'failed', 0.34, 78.01, 'Confidence terlalu rendah (78.01%, minimum 80%). (kiosk)', '2026-05-04 05:47:31', '2026-05-04 05:47:31'),
(734, 2, NULL, 'failed', 0.33, 79.25, 'Confidence terlalu rendah (79.25%, minimum 80%). (kiosk)', '2026-05-04 05:47:36', '2026-05-04 05:47:36'),
(735, 2, NULL, 'failed', 0.34, 77.97, 'Confidence terlalu rendah (77.97%, minimum 80%). (kiosk)', '2026-05-04 05:47:41', '2026-05-04 05:47:41'),
(736, 2, NULL, 'success', 0.23, 90.37, 'Wajah cocok. (kiosk)', '2026-05-04 05:47:46', '2026-05-04 05:47:46'),
(737, 2, NULL, 'success', 0.28, 85.73, 'Wajah cocok. (kiosk)', '2026-05-04 05:47:51', '2026-05-04 05:47:51'),
(738, 2, NULL, 'success', 0.31, 81.60, 'Wajah cocok. (kiosk)', '2026-05-04 05:47:54', '2026-05-04 05:47:54'),
(739, 2, NULL, 'failed', 0.33, 79.81, 'Confidence terlalu rendah (79.81%, minimum 80%). (kiosk)', '2026-05-04 05:48:02', '2026-05-04 05:48:02'),
(740, 2, NULL, 'failed', 0.33, 79.87, 'Confidence terlalu rendah (79.87%, minimum 80%). (kiosk)', '2026-05-04 05:48:07', '2026-05-04 05:48:07'),
(741, 2, NULL, 'failed', 0.35, 77.16, 'Confidence terlalu rendah (77.16%, minimum 80%). (kiosk)', '2026-05-04 05:48:14', '2026-05-04 05:48:14'),
(742, 2, NULL, 'success', 0.32, 80.70, 'Wajah cocok. (kiosk)', '2026-05-04 05:48:17', '2026-05-04 05:48:17'),
(743, 2, NULL, 'success', 0.33, 80.04, 'Wajah cocok. (kiosk)', '2026-05-04 05:48:22', '2026-05-04 05:48:22'),
(744, 6, NULL, 'failed', 0.36, 76.32, 'Confidence terlalu rendah (76.32%, minimum 80%). (kiosk)', '2026-05-04 05:48:26', '2026-05-04 05:48:26'),
(745, 2, NULL, 'failed', 0.35, 77.61, 'Confidence terlalu rendah (77.61%, minimum 80%). (kiosk)', '2026-05-04 05:48:31', '2026-05-04 05:48:31'),
(746, 2, NULL, 'success', 0.32, 80.35, 'Wajah cocok. (kiosk)', '2026-05-04 05:48:36', '2026-05-04 05:48:36'),
(747, 10, NULL, 'failed', 0.50, 55.43, 'Confidence terlalu rendah (55.43%, minimum 80%). (kiosk)', '2026-05-04 05:48:40', '2026-05-04 05:48:40'),
(748, 2, NULL, 'failed', 0.34, 78.17, 'Confidence terlalu rendah (78.17%, minimum 80%). (kiosk)', '2026-05-04 05:48:44', '2026-05-04 05:48:44'),
(749, 2, NULL, 'success', 0.31, 81.53, 'Wajah cocok. (kiosk)', '2026-05-04 05:48:49', '2026-05-04 05:48:49'),
(750, 2, NULL, 'success', 0.29, 83.82, 'Wajah cocok. (kiosk)', '2026-05-04 05:48:54', '2026-05-04 05:48:54'),
(751, 2, NULL, 'failed', 0.35, 77.42, 'Confidence terlalu rendah (77.42%, minimum 80%). (kiosk)', '2026-05-04 05:48:59', '2026-05-04 05:48:59'),
(752, 6, NULL, 'failed', 0.36, 76.10, 'Confidence terlalu rendah (76.1%, minimum 80%). (kiosk)', '2026-05-04 05:49:04', '2026-05-04 05:49:04'),
(753, 2, NULL, 'failed', 0.35, 77.54, 'Confidence terlalu rendah (77.54%, minimum 80%). (kiosk)', '2026-05-04 05:49:09', '2026-05-04 05:49:09'),
(754, 2, NULL, 'failed', 0.37, 74.68, 'Confidence terlalu rendah (74.68%, minimum 80%). (kiosk)', '2026-05-04 05:49:14', '2026-05-04 05:49:14'),
(755, 2, NULL, 'success', 0.31, 81.90, 'Wajah cocok. (kiosk)', '2026-05-04 05:49:19', '2026-05-04 05:49:19'),
(756, 2, NULL, 'failed', 0.34, 78.18, 'Confidence terlalu rendah (78.18%, minimum 80%). (kiosk)', '2026-05-04 05:49:24', '2026-05-04 05:49:24'),
(757, 2, NULL, 'failed', 0.34, 78.09, 'Confidence terlalu rendah (78.09%, minimum 80%). (kiosk)', '2026-05-04 05:49:29', '2026-05-04 05:49:29'),
(758, 2, NULL, 'success', 0.32, 80.82, 'Wajah cocok. (kiosk)', '2026-05-04 05:49:34', '2026-05-04 05:49:34'),
(759, 2, NULL, 'success', 0.31, 82.10, 'Wajah cocok. (kiosk)', '2026-05-04 05:49:39', '2026-05-04 05:49:39'),
(760, 2, NULL, 'success', 0.32, 80.34, 'Wajah cocok. (kiosk)', '2026-05-04 05:49:44', '2026-05-04 05:49:44'),
(761, 2, NULL, 'failed', 0.34, 78.95, 'Confidence terlalu rendah (78.95%, minimum 80%). (kiosk)', '2026-05-04 05:49:49', '2026-05-04 05:49:49'),
(762, 2, NULL, 'failed', 0.35, 77.55, 'Confidence terlalu rendah (77.55%, minimum 80%). (kiosk)', '2026-05-04 05:49:54', '2026-05-04 05:49:54'),
(763, 2, NULL, 'failed', 0.33, 79.20, 'Confidence terlalu rendah (79.2%, minimum 80%). (kiosk)', '2026-05-04 05:49:59', '2026-05-04 05:49:59'),
(764, 2, NULL, 'failed', 0.39, 72.14, 'Confidence terlalu rendah (72.14%, minimum 80%). (kiosk)', '2026-05-04 05:50:04', '2026-05-04 05:50:04'),
(765, 2, NULL, 'failed', 0.35, 77.84, 'Confidence terlalu rendah (77.84%, minimum 80%). (kiosk)', '2026-05-04 05:50:09', '2026-05-04 05:50:09'),
(766, 2, NULL, 'failed', 0.35, 76.97, 'Confidence terlalu rendah (76.97%, minimum 80%). (kiosk)', '2026-05-04 05:50:14', '2026-05-04 05:50:14'),
(767, 10, NULL, 'failed', 0.37, 74.93, 'Confidence terlalu rendah (74.93%, minimum 80%). (kiosk)', '2026-05-04 05:50:22', '2026-05-04 05:50:22'),
(768, 2, NULL, 'failed', 0.40, 70.24, 'Confidence terlalu rendah (70.24%, minimum 80%). (kiosk)', '2026-05-04 05:50:27', '2026-05-04 05:50:27'),
(769, 2, NULL, 'failed', 0.38, 73.61, 'Confidence terlalu rendah (73.61%, minimum 80%). (kiosk)', '2026-05-04 05:50:32', '2026-05-04 05:50:32'),
(771, 2, NULL, 'failed', 0.38, 73.16, 'Confidence terlalu rendah (73.16%, minimum 80%). (kiosk)', '2026-05-04 05:50:42', '2026-05-04 05:50:42'),
(772, 2, NULL, 'success', 0.32, 81.43, 'Wajah cocok. (kiosk)', '2026-05-04 05:50:47', '2026-05-04 05:50:47'),
(773, 16, NULL, 'failed', 0.55, 46.45, 'Confidence terlalu rendah (46.45%, minimum 80%). (kiosk)', '2026-05-04 05:50:50', '2026-05-04 05:50:50'),
(774, 6, NULL, 'failed', 0.39, 72.66, 'Confidence terlalu rendah (72.66%, minimum 80%). (kiosk)', '2026-05-04 05:51:05', '2026-05-04 05:51:05'),
(775, 6, NULL, 'failed', 0.43, 65.87, 'Confidence terlalu rendah (65.87%, minimum 80%). (kiosk)', '2026-05-04 05:51:10', '2026-05-04 05:51:10'),
(776, 2, NULL, 'failed', 0.36, 75.70, 'Confidence terlalu rendah (75.7%, minimum 80%). (kiosk)', '2026-05-04 05:51:12', '2026-05-04 05:51:12'),
(777, 2, NULL, 'failed', 0.37, 74.55, 'Confidence terlalu rendah (74.55%, minimum 80%). (kiosk)', '2026-05-04 05:51:17', '2026-05-04 05:51:17'),
(778, 2, NULL, 'failed', 0.34, 78.79, 'Confidence terlalu rendah (78.79%, minimum 80%). (kiosk)', '2026-05-04 05:51:23', '2026-05-04 05:51:23'),
(779, 2, NULL, 'success', 0.32, 81.26, 'Wajah cocok. (kiosk)', '2026-05-04 05:51:28', '2026-05-04 05:51:28'),
(780, 2, NULL, 'failed', 0.35, 77.24, 'Confidence terlalu rendah (77.24%, minimum 80%). (kiosk)', '2026-05-04 05:51:33', '2026-05-04 05:51:33'),
(781, 16, NULL, 'failed', 0.35, 77.68, 'Confidence terlalu rendah (77.68%, minimum 80%). (kiosk)', '2026-05-04 05:51:38', '2026-05-04 05:51:38'),
(782, 2, NULL, 'failed', 0.35, 77.10, 'Confidence terlalu rendah (77.1%, minimum 80%). (kiosk)', '2026-05-04 05:51:43', '2026-05-04 05:51:43'),
(783, 2, NULL, 'success', 0.29, 84.30, 'Wajah cocok. (kiosk)', '2026-05-04 05:51:47', '2026-05-04 05:51:47'),
(784, 10, NULL, 'failed', 0.36, 76.19, 'Confidence terlalu rendah (76.19%, minimum 80%). (kiosk)', '2026-05-04 05:51:49', '2026-05-04 05:51:49'),
(785, 16, NULL, 'failed', 0.44, 65.59, 'Confidence terlalu rendah (65.59%, minimum 80%). (kiosk)', '2026-05-04 05:51:51', '2026-05-04 05:51:51'),
(786, 6, NULL, 'failed', 0.47, 60.56, 'Confidence terlalu rendah (60.56%, minimum 80%). (kiosk)', '2026-05-04 05:51:53', '2026-05-04 05:51:53'),
(787, 16, NULL, 'failed', 0.44, 64.72, 'Confidence terlalu rendah (64.72%, minimum 80%). (kiosk)', '2026-05-04 05:51:57', '2026-05-04 05:51:57'),
(788, 10, NULL, 'failed', 0.44, 65.04, 'Confidence terlalu rendah (65.04%, minimum 80%). (kiosk)', '2026-05-04 05:52:02', '2026-05-04 05:52:02'),
(789, 16, NULL, 'failed', 0.46, 62.63, 'Confidence terlalu rendah (62.63%, minimum 80%). (kiosk)', '2026-05-04 05:52:06', '2026-05-04 05:52:06'),
(790, 6, NULL, 'failed', 0.46, 61.83, 'Confidence terlalu rendah (61.83%, minimum 80%). (kiosk)', '2026-05-04 05:52:07', '2026-05-04 05:52:07'),
(791, 16, NULL, 'failed', 0.43, 66.32, 'Confidence terlalu rendah (66.32%, minimum 80%). (kiosk)', '2026-05-04 05:52:12', '2026-05-04 05:52:12'),
(792, 6, NULL, 'failed', 0.35, 77.83, 'Confidence terlalu rendah (77.83%, minimum 80%). (kiosk)', '2026-05-04 05:52:17', '2026-05-04 05:52:17'),
(793, 6, NULL, 'failed', 0.35, 77.88, 'Confidence terlalu rendah (77.88%, minimum 80%). (kiosk)', '2026-05-04 05:52:22', '2026-05-04 05:52:22'),
(794, 10, NULL, 'failed', 0.34, 78.21, 'Confidence terlalu rendah (78.21%, minimum 80%). (kiosk)', '2026-05-04 05:52:27', '2026-05-04 05:52:27'),
(795, 2, NULL, 'failed', 0.33, 79.99, 'Confidence terlalu rendah (79.99%, minimum 80%). (kiosk)', '2026-05-04 05:52:32', '2026-05-04 05:52:32'),
(796, 2, NULL, 'failed', 0.33, 79.61, 'Confidence terlalu rendah (79.61%, minimum 80%). (kiosk)', '2026-05-04 05:52:37', '2026-05-04 05:52:37'),
(797, 10, NULL, 'failed', 0.36, 76.08, 'Confidence terlalu rendah (76.08%, minimum 80%). (kiosk)', '2026-05-04 05:52:42', '2026-05-04 05:52:42'),
(798, 2, NULL, 'failed', 0.36, 75.70, 'Confidence terlalu rendah (75.7%, minimum 80%). (kiosk)', '2026-05-04 05:52:47', '2026-05-04 05:52:47'),
(799, 2, NULL, 'failed', 0.33, 79.58, 'Confidence terlalu rendah (79.58%, minimum 80%). (kiosk)', '2026-05-04 05:52:52', '2026-05-04 05:52:52'),
(800, 6, NULL, 'failed', 0.36, 75.86, 'Confidence terlalu rendah (75.86%, minimum 80%). (kiosk)', '2026-05-04 05:52:57', '2026-05-04 05:52:57'),
(801, 2, NULL, 'failed', 0.34, 78.28, 'Confidence terlalu rendah (78.28%, minimum 80%). (kiosk)', '2026-05-04 05:53:02', '2026-05-04 05:53:02'),
(802, 2, NULL, 'failed', 0.34, 78.65, 'Confidence terlalu rendah (78.65%, minimum 80%). (kiosk)', '2026-05-04 05:53:07', '2026-05-04 05:53:07'),
(803, 2, NULL, 'failed', 0.36, 75.99, 'Confidence terlalu rendah (75.99%, minimum 80%). (kiosk)', '2026-05-04 05:53:12', '2026-05-04 05:53:12'),
(804, 2, NULL, 'success', 0.32, 81.03, 'Wajah cocok. (kiosk)', '2026-05-04 05:53:17', '2026-05-04 05:53:17'),
(805, 2, NULL, 'failed', 0.36, 76.05, 'Confidence terlalu rendah (76.05%, minimum 80%). (kiosk)', '2026-05-04 05:53:22', '2026-05-04 05:53:22'),
(806, 2, NULL, 'failed', 0.34, 78.94, 'Confidence terlalu rendah (78.94%, minimum 80%). (kiosk)', '2026-05-04 05:53:27', '2026-05-04 05:53:27'),
(807, 2, NULL, 'failed', 0.33, 79.27, 'Confidence terlalu rendah (79.27%, minimum 80%). (kiosk)', '2026-05-04 05:53:32', '2026-05-04 05:53:32'),
(808, 6, NULL, 'failed', 0.36, 76.23, 'Confidence terlalu rendah (76.23%, minimum 80%). (kiosk)', '2026-05-04 05:53:37', '2026-05-04 05:53:37'),
(809, 16, 66, 'success', 0.68, 9.38, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-12 00:18:44', '2026-05-12 00:18:44'),
(810, 2, NULL, 'success', 0.29, 83.82, 'Wajah cocok. (kiosk)', '2026-05-12 07:21:23', '2026-05-12 07:21:23'),
(811, 2, NULL, 'success', 0.24, 88.80, 'Wajah cocok. (kiosk)', '2026-05-12 07:21:28', '2026-05-12 07:21:28'),
(812, 2, NULL, 'success', 0.30, 82.78, 'Wajah cocok. (kiosk)', '2026-05-12 07:21:33', '2026-05-12 07:21:33'),
(813, 2, NULL, 'success', 0.27, 86.38, 'Wajah cocok. (kiosk)', '2026-05-12 07:21:38', '2026-05-12 07:21:38'),
(814, 2, NULL, 'success', 0.29, 83.87, 'Wajah cocok. (kiosk)', '2026-05-12 07:21:43', '2026-05-12 07:21:43'),
(815, 2, NULL, 'success', 0.29, 84.41, 'Wajah cocok. (kiosk)', '2026-05-12 07:21:48', '2026-05-12 07:21:48'),
(816, 2, NULL, 'success', 0.26, 86.82, 'Wajah cocok. (kiosk)', '2026-05-12 07:21:56', '2026-05-12 07:21:56'),
(817, 2, NULL, 'success', 0.26, 87.22, 'Wajah cocok. (kiosk)', '2026-05-12 07:22:01', '2026-05-12 07:22:01'),
(818, 2, NULL, 'success', 0.33, 80.22, 'Wajah cocok. (kiosk)', '2026-05-12 07:22:06', '2026-05-12 07:22:06'),
(819, 2, NULL, 'success', 0.27, 85.86, 'Wajah cocok. (kiosk)', '2026-05-12 07:22:11', '2026-05-12 07:22:11'),
(820, 2, NULL, 'success', 0.27, 86.35, 'Wajah cocok. (kiosk)', '2026-05-12 07:22:16', '2026-05-12 07:22:16'),
(821, 2, NULL, 'success', 0.28, 85.73, 'Wajah cocok. (kiosk)', '2026-05-12 07:22:27', '2026-05-12 07:22:27'),
(822, 2, NULL, 'success', 0.24, 89.34, 'Wajah cocok. (kiosk)', '2026-05-12 07:22:32', '2026-05-12 07:22:32'),
(823, 2, NULL, 'success', 0.23, 89.63, 'Wajah cocok. (kiosk)', '2026-05-12 07:22:37', '2026-05-12 07:22:37'),
(824, 2, NULL, 'success', 0.24, 88.97, 'Wajah cocok. (kiosk)', '2026-05-12 07:23:56', '2026-05-12 07:23:56'),
(825, 2, 67, 'success', 0.24, 88.97, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-12 07:23:56', '2026-05-12 07:23:56'),
(826, 2, NULL, 'success', 0.26, 87.65, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:00', '2026-05-12 07:24:00'),
(827, 2, NULL, 'success', 0.25, 87.97, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:05', '2026-05-12 07:24:05'),
(828, 2, NULL, 'success', 0.27, 86.44, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:10', '2026-05-12 07:24:10'),
(829, 2, NULL, 'success', 0.24, 89.38, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:15', '2026-05-12 07:24:15'),
(830, 2, NULL, 'success', 0.25, 88.30, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:20', '2026-05-12 07:24:20'),
(831, 2, NULL, 'success', 0.26, 87.08, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:25', '2026-05-12 07:24:25'),
(832, 2, NULL, 'success', 0.28, 85.01, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:30', '2026-05-12 07:24:30'),
(833, 2, NULL, 'success', 0.25, 87.83, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:35', '2026-05-12 07:24:35'),
(834, 2, NULL, 'success', 0.27, 86.29, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:40', '2026-05-12 07:24:40'),
(835, 2, NULL, 'success', 0.24, 89.41, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:49', '2026-05-12 07:24:49'),
(836, 2, NULL, 'success', 0.26, 87.55, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:53', '2026-05-12 07:24:53'),
(837, 2, NULL, 'success', 0.24, 89.17, 'Wajah cocok. (kiosk)', '2026-05-12 07:24:58', '2026-05-12 07:24:58'),
(838, 2, NULL, 'success', 0.26, 87.06, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:03', '2026-05-12 07:25:03'),
(839, 2, NULL, 'success', 0.28, 85.71, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:08', '2026-05-12 07:25:08'),
(840, 12, NULL, 'failed', 0.35, 77.78, 'Confidence terlalu rendah (77.78%, minimum 80%). (kiosk)', '2026-05-12 07:25:13', '2026-05-12 07:25:13'),
(841, 2, NULL, 'success', 0.26, 87.05, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:18', '2026-05-12 07:25:18'),
(842, 2, NULL, 'success', 0.26, 87.50, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:23', '2026-05-12 07:25:23'),
(843, 2, NULL, 'success', 0.27, 86.07, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:28', '2026-05-12 07:25:28'),
(844, 16, NULL, 'success', 0.32, 80.82, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:33', '2026-05-12 07:25:33'),
(845, 16, 68, 'success', 0.32, 80.82, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-12 07:25:33', '2026-05-12 07:25:33'),
(846, 2, NULL, 'success', 0.25, 88.17, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:38', '2026-05-12 07:25:38'),
(847, 2, NULL, 'success', 0.31, 81.88, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:43', '2026-05-12 07:25:43'),
(848, 2, NULL, 'success', 0.30, 83.16, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:52', '2026-05-12 07:25:52'),
(849, 2, NULL, 'success', 0.25, 88.36, 'Wajah cocok. (kiosk)', '2026-05-12 07:25:57', '2026-05-12 07:25:57'),
(850, 2, NULL, 'success', 0.28, 85.64, 'Wajah cocok. (kiosk)', '2026-05-12 07:26:05', '2026-05-12 07:26:05'),
(851, 2, NULL, 'success', 0.25, 88.05, 'Wajah cocok. (kiosk)', '2026-05-12 07:26:11', '2026-05-12 07:26:11'),
(852, 2, NULL, 'success', 0.30, 82.88, 'Wajah cocok. (kiosk)', '2026-05-12 07:26:20', '2026-05-12 07:26:20'),
(853, 10, NULL, 'failed', 0.33, 79.33, 'Confidence terlalu rendah (79.33%, minimum 80%). (kiosk)', '2026-05-12 07:26:29', '2026-05-12 07:26:29'),
(854, 10, NULL, 'failed', 0.34, 78.06, 'Confidence terlalu rendah (78.06%, minimum 80%). (kiosk)', '2026-05-12 07:26:35', '2026-05-12 07:26:35'),
(855, 2, NULL, 'success', 0.30, 83.04, 'Wajah cocok. (kiosk)', '2026-05-12 07:26:41', '2026-05-12 07:26:41'),
(856, 2, NULL, 'success', 0.27, 86.40, 'Wajah cocok. (kiosk)', '2026-05-12 07:26:48', '2026-05-12 07:26:48'),
(857, 6, NULL, 'success', 0.30, 82.93, 'Wajah cocok. (kiosk)', '2026-05-12 07:26:56', '2026-05-12 07:26:56'),
(858, 6, 69, 'success', 0.30, 82.93, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-12 07:26:56', '2026-05-12 07:26:56'),
(859, 2, NULL, 'success', 0.28, 85.30, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:03', '2026-05-12 07:27:03'),
(860, 2, NULL, 'failed', 0.33, 79.38, 'Confidence terlalu rendah (79.38%, minimum 80%). (kiosk)', '2026-05-12 07:27:08', '2026-05-12 07:27:08'),
(861, 2, NULL, 'success', 0.26, 87.08, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:13', '2026-05-12 07:27:13'),
(862, 2, NULL, 'success', 0.22, 90.59, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:18', '2026-05-12 07:27:18'),
(863, 2, NULL, 'success', 0.23, 89.68, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:23', '2026-05-12 07:27:23'),
(864, 2, NULL, 'success', 0.22, 90.40, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:28', '2026-05-12 07:27:28'),
(865, 2, NULL, 'success', 0.27, 86.73, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:33', '2026-05-12 07:27:33'),
(866, 2, NULL, 'success', 0.32, 80.54, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:38', '2026-05-12 07:27:38'),
(867, 2, NULL, 'success', 0.32, 80.80, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:43', '2026-05-12 07:27:43'),
(868, 2, NULL, 'success', 0.30, 82.93, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:49', '2026-05-12 07:27:49'),
(869, 2, NULL, 'success', 0.24, 89.06, 'Wajah cocok. (kiosk)', '2026-05-12 07:27:58', '2026-05-12 07:27:58'),
(870, 2, NULL, 'success', 0.32, 80.64, 'Wajah cocok. (kiosk)', '2026-05-12 07:28:05', '2026-05-12 07:28:05'),
(871, 2, NULL, 'success', 0.26, 87.61, 'Wajah cocok. (kiosk)', '2026-05-12 07:28:07', '2026-05-12 07:28:07'),
(872, 2, NULL, 'success', 0.30, 83.41, 'Wajah cocok. (kiosk)', '2026-05-12 07:28:12', '2026-05-12 07:28:12'),
(873, 2, NULL, 'success', 0.25, 88.65, 'Wajah cocok. (kiosk)', '2026-05-12 07:28:17', '2026-05-12 07:28:17'),
(874, 2, NULL, 'failed', 0.34, 78.35, 'Confidence terlalu rendah (78.35%, minimum 80%). (kiosk)', '2026-05-12 07:28:23', '2026-05-12 07:28:23'),
(875, 2, NULL, 'success', 0.25, 88.57, 'Wajah cocok. (kiosk)', '2026-05-12 07:28:28', '2026-05-12 07:28:28'),
(876, 2, NULL, 'success', 0.30, 83.56, 'Wajah cocok. (kiosk)', '2026-05-12 07:28:36', '2026-05-12 07:28:36'),
(877, 2, NULL, 'success', 0.31, 82.58, 'Wajah cocok. (kiosk)', '2026-05-12 07:28:41', '2026-05-12 07:28:41'),
(878, 2, NULL, 'success', 0.32, 80.54, 'Wajah cocok. (kiosk)', '2026-05-12 07:28:46', '2026-05-12 07:28:46'),
(879, 16, NULL, 'failed', 0.45, 64.01, 'Confidence terlalu rendah (64.01%, minimum 80%). (kiosk)', '2026-05-12 07:28:54', '2026-05-12 07:28:54'),
(880, 16, NULL, 'failed', 0.43, 66.02, 'Confidence terlalu rendah (66.02%, minimum 80%). (kiosk)', '2026-05-12 07:29:04', '2026-05-12 07:29:04'),
(881, 2, NULL, 'failed', 0.38, 73.62, 'Confidence terlalu rendah (73.62%, minimum 80%). (kiosk)', '2026-05-12 07:29:05', '2026-05-12 07:29:05'),
(882, 2, NULL, 'success', 0.32, 81.32, 'Wajah cocok. (kiosk)', '2026-05-12 07:29:10', '2026-05-12 07:29:10'),
(883, 2, NULL, 'success', 0.31, 82.17, 'Wajah cocok. (kiosk)', '2026-05-12 07:29:15', '2026-05-12 07:29:15'),
(884, 2, NULL, 'failed', 0.35, 77.82, 'Confidence terlalu rendah (77.82%, minimum 80%). (kiosk)', '2026-05-12 07:29:20', '2026-05-12 07:29:20'),
(885, 2, NULL, 'success', 0.32, 80.74, 'Wajah cocok. (kiosk)', '2026-05-12 07:29:25', '2026-05-12 07:29:25'),
(886, 2, NULL, 'failed', 0.37, 75.38, 'Confidence terlalu rendah (75.38%, minimum 80%). (kiosk)', '2026-05-12 07:29:30', '2026-05-12 07:29:30'),
(887, 2, NULL, 'success', 0.31, 81.51, 'Wajah cocok. (kiosk)', '2026-05-12 07:29:35', '2026-05-12 07:29:35'),
(888, 2, NULL, 'success', 0.28, 84.90, 'Wajah cocok. (kiosk)', '2026-05-12 07:29:40', '2026-05-12 07:29:40'),
(889, 16, NULL, 'failed', 0.51, 54.26, 'Confidence terlalu rendah (54.26%, minimum 80%). (kiosk)', '2026-05-12 07:29:45', '2026-05-12 07:29:45'),
(890, 2, NULL, 'success', 0.31, 82.47, 'Wajah cocok. (kiosk)', '2026-05-12 07:29:46', '2026-05-12 07:29:46'),
(891, 2, NULL, 'success', 0.28, 85.25, 'Wajah cocok. (kiosk)', '2026-05-12 07:29:51', '2026-05-12 07:29:51'),
(892, 2, NULL, 'success', 0.31, 82.57, 'Wajah cocok. (kiosk)', '2026-05-12 07:29:57', '2026-05-12 07:29:57'),
(893, 2, NULL, 'success', 0.30, 82.65, 'Wajah cocok. (kiosk)', '2026-05-12 07:30:19', '2026-05-12 07:30:19'),
(894, 2, NULL, 'failed', 0.37, 74.96, 'Confidence terlalu rendah (74.96%, minimum 80%). (kiosk)', '2026-05-12 07:30:29', '2026-05-12 07:30:29'),
(895, 2, NULL, 'success', 0.30, 83.26, 'Wajah cocok. (kiosk)', '2026-05-12 07:30:40', '2026-05-12 07:30:40'),
(896, 2, NULL, 'success', 0.29, 84.47, 'Wajah cocok. (kiosk)', '2026-05-12 07:30:55', '2026-05-12 07:30:55'),
(897, 2, NULL, 'success', 0.28, 85.68, 'Wajah cocok. (kiosk)', '2026-05-12 07:31:00', '2026-05-12 07:31:00'),
(898, 2, NULL, 'success', 0.29, 84.10, 'Wajah cocok. (kiosk)', '2026-05-12 07:31:37', '2026-05-12 07:31:37'),
(899, 2, NULL, 'success', 0.26, 87.57, 'Wajah cocok. (kiosk)', '2026-05-12 07:31:50', '2026-05-12 07:31:50'),
(900, 2, NULL, 'success', 0.29, 84.24, 'Wajah cocok. (kiosk)', '2026-05-12 07:31:55', '2026-05-12 07:31:55'),
(901, 2, NULL, 'success', 0.24, 89.13, 'Wajah cocok. (kiosk)', '2026-05-12 07:32:00', '2026-05-12 07:32:00'),
(902, 2, NULL, 'failed', 0.34, 78.23, 'Confidence terlalu rendah (78.23%, minimum 80%). (kiosk)', '2026-05-12 07:32:09', '2026-05-12 07:32:09'),
(903, 2, NULL, 'success', 0.29, 84.30, 'Wajah cocok. (kiosk)', '2026-05-12 07:32:14', '2026-05-12 07:32:14'),
(904, 2, NULL, 'success', 0.31, 82.27, 'Wajah cocok. (kiosk)', '2026-05-12 07:32:20', '2026-05-12 07:32:20'),
(905, 2, NULL, 'failed', 0.36, 75.62, 'Confidence terlalu rendah (75.62%, minimum 80%). (kiosk)', '2026-05-12 07:32:26', '2026-05-12 07:32:26'),
(906, 2, NULL, 'success', 0.27, 86.26, 'Wajah cocok. (kiosk)', '2026-05-12 07:32:37', '2026-05-12 07:32:37'),
(907, 2, NULL, 'success', 0.26, 87.68, 'Wajah cocok. (kiosk)', '2026-05-12 07:32:45', '2026-05-12 07:32:45'),
(908, 16, NULL, 'failed', 0.50, 55.84, 'Confidence terlalu rendah (55.84%, minimum 80%). (kiosk)', '2026-05-12 07:32:45', '2026-05-12 07:32:45'),
(909, 2, NULL, 'failed', 0.46, 62.51, 'Confidence terlalu rendah (62.51%, minimum 80%). (kiosk)', '2026-05-12 07:32:49', '2026-05-12 07:32:49'),
(910, 2, NULL, 'failed', 0.42, 67.24, 'Confidence terlalu rendah (67.24%, minimum 80%). (kiosk)', '2026-05-12 07:32:59', '2026-05-12 07:32:59'),
(911, 2, NULL, 'failed', 0.34, 78.29, 'Confidence terlalu rendah (78.29%, minimum 80%). (kiosk)', '2026-05-12 07:33:24', '2026-05-12 07:33:24'),
(912, 2, NULL, 'success', 0.27, 85.97, 'Wajah cocok. (kiosk)', '2026-05-12 07:34:11', '2026-05-12 07:34:11'),
(913, 2, NULL, 'success', 0.28, 85.76, 'Wajah cocok. (kiosk)', '2026-05-12 07:34:16', '2026-05-12 07:34:16'),
(914, 2, NULL, 'success', 0.28, 85.07, 'Wajah cocok. (kiosk)', '2026-05-12 07:35:16', '2026-05-12 07:35:16'),
(915, 2, NULL, 'failed', 0.35, 77.75, 'Confidence terlalu rendah (77.75%, minimum 80%). (kiosk)', '2026-05-12 07:35:27', '2026-05-12 07:35:27'),
(916, 2, NULL, 'success', 0.31, 81.86, 'Wajah cocok. (kiosk)', '2026-05-12 07:36:44', '2026-05-12 07:36:44'),
(917, 2, NULL, 'success', 0.30, 83.14, 'Wajah cocok. (kiosk)', '2026-05-12 07:36:49', '2026-05-12 07:36:49'),
(918, 2, NULL, 'success', 0.30, 82.93, 'Wajah cocok. (kiosk)', '2026-05-12 07:36:54', '2026-05-12 07:36:54'),
(919, 2, NULL, 'success', 0.30, 83.61, 'Wajah cocok. (kiosk)', '2026-05-12 07:36:59', '2026-05-12 07:36:59'),
(920, 2, NULL, 'failed', 0.34, 78.71, 'Confidence terlalu rendah (78.71%, minimum 80%). (kiosk)', '2026-05-12 07:37:44', '2026-05-12 07:37:44'),
(921, 16, NULL, 'failed', 0.46, 61.61, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:37:51', '2026-05-12 07:37:51'),
(922, 16, NULL, 'failed', 0.36, 76.35, 'Confidence terlalu rendah (76.35%, minimum 80%). (kiosk)', '2026-05-12 07:37:56', '2026-05-12 07:37:56'),
(923, 2, NULL, 'success', 0.26, 86.79, 'Wajah cocok. (kiosk)', '2026-05-12 07:38:01', '2026-05-12 07:38:01'),
(924, 2, NULL, 'failed', 0.37, 75.27, 'Confidence terlalu rendah (75.27%, minimum 80%). (kiosk)', '2026-05-12 07:40:01', '2026-05-12 07:40:01'),
(925, 2, NULL, 'failed', 0.34, 78.08, 'Confidence terlalu rendah (78.08%, minimum 80%). (kiosk)', '2026-05-12 07:40:06', '2026-05-12 07:40:06'),
(926, 2, NULL, 'success', 0.28, 85.38, 'Wajah cocok. (kiosk)', '2026-05-12 07:40:15', '2026-05-12 07:40:15'),
(927, 2, NULL, 'failed', 0.35, 77.37, 'Confidence terlalu rendah (77.37%, minimum 80%). (kiosk)', '2026-05-12 07:40:23', '2026-05-12 07:40:23'),
(928, 2, NULL, 'failed', 0.39, 71.81, 'Confidence terlalu rendah (71.81%, minimum 80%). (kiosk)', '2026-05-12 07:41:31', '2026-05-12 07:41:31'),
(929, 16, NULL, 'failed', 0.42, 67.24, 'Confidence terlalu rendah (67.24%, minimum 80%). (kiosk)', '2026-05-12 07:41:44', '2026-05-12 07:41:44');
INSERT INTO `face_logs` (`id`, `user_id`, `absensi_id`, `status`, `distance`, `confidence`, `message`, `created_at`, `updated_at`) VALUES
(930, 2, NULL, 'success', 0.30, 83.65, 'Wajah cocok. (kiosk)', '2026-05-12 07:41:49', '2026-05-12 07:41:49'),
(931, 2, NULL, 'failed', 0.40, 71.15, 'Confidence terlalu rendah (71.15%, minimum 80%). (kiosk)', '2026-05-12 07:41:54', '2026-05-12 07:41:54'),
(932, 2, NULL, 'failed', 0.34, 78.96, 'Confidence terlalu rendah (78.96%, minimum 80%). (kiosk)', '2026-05-12 07:41:59', '2026-05-12 07:41:59'),
(933, 16, NULL, 'failed', 0.34, 78.12, 'Confidence terlalu rendah (78.12%, minimum 80%). (kiosk)', '2026-05-12 07:42:04', '2026-05-12 07:42:04'),
(934, 2, NULL, 'success', 0.31, 82.25, 'Wajah cocok. (kiosk)', '2026-05-12 07:42:09', '2026-05-12 07:42:09'),
(935, 16, NULL, 'success', 0.30, 83.24, 'Wajah cocok. (kiosk)', '2026-05-12 07:42:14', '2026-05-12 07:42:14'),
(936, 2, NULL, 'success', 0.27, 86.01, 'Wajah cocok. (kiosk)', '2026-05-12 07:42:19', '2026-05-12 07:42:19'),
(937, 2, NULL, 'success', 0.28, 85.52, 'Wajah cocok. (kiosk)', '2026-05-12 07:42:24', '2026-05-12 07:42:24'),
(938, 2, NULL, 'success', 0.27, 86.33, 'Wajah cocok. (kiosk)', '2026-05-12 07:42:29', '2026-05-12 07:42:29'),
(939, 2, NULL, 'success', 0.25, 87.96, 'Wajah cocok. (kiosk)', '2026-05-12 07:42:34', '2026-05-12 07:42:34'),
(940, 2, NULL, 'success', 0.33, 80.26, 'Wajah cocok. (kiosk)', '2026-05-12 07:42:39', '2026-05-12 07:42:39'),
(941, 2, NULL, 'failed', 0.34, 78.10, 'Confidence terlalu rendah (78.1%, minimum 80%). (kiosk)', '2026-05-12 07:42:44', '2026-05-12 07:42:44'),
(942, 16, NULL, 'failed', 0.37, 74.56, 'Confidence terlalu rendah (74.56%, minimum 80%). (kiosk)', '2026-05-12 07:42:49', '2026-05-12 07:42:49'),
(943, 16, NULL, 'failed', 0.49, 57.85, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:42:51', '2026-05-12 07:42:51'),
(944, 16, NULL, 'failed', 0.37, 74.38, 'Confidence terlalu rendah (74.38%, minimum 80%). (kiosk)', '2026-05-12 07:42:54', '2026-05-12 07:42:54'),
(945, 2, NULL, 'success', 0.32, 81.07, 'Wajah cocok. (kiosk)', '2026-05-12 07:42:58', '2026-05-12 07:42:58'),
(946, 12, NULL, 'failed', 0.39, 71.67, 'Confidence terlalu rendah (71.67%, minimum 80%). (kiosk)', '2026-05-12 07:42:59', '2026-05-12 07:42:59'),
(947, 2, NULL, 'failed', 0.38, 73.57, 'Confidence terlalu rendah (73.57%, minimum 80%). (kiosk)', '2026-05-12 07:43:04', '2026-05-12 07:43:04'),
(948, 2, NULL, 'failed', 0.34, 79.06, 'Confidence terlalu rendah (79.06%, minimum 80%). (kiosk)', '2026-05-12 07:43:15', '2026-05-12 07:43:15'),
(949, 2, NULL, 'success', 0.30, 83.18, 'Wajah cocok. (kiosk)', '2026-05-12 07:43:44', '2026-05-12 07:43:44'),
(950, 2, NULL, 'success', 0.29, 84.67, 'Wajah cocok. (kiosk)', '2026-05-12 07:43:59', '2026-05-12 07:43:59'),
(951, 2, NULL, 'success', 0.30, 83.54, 'Wajah cocok. (kiosk)', '2026-05-12 07:44:28', '2026-05-12 07:44:28'),
(952, 2, NULL, 'success', 0.29, 83.98, 'Wajah cocok. (kiosk)', '2026-05-12 07:46:55', '2026-05-12 07:46:55'),
(953, 2, NULL, 'success', 0.28, 84.88, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:04', '2026-05-12 07:47:04'),
(954, 2, NULL, 'success', 0.29, 83.92, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:09', '2026-05-12 07:47:09'),
(955, 2, NULL, 'success', 0.32, 81.26, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:16', '2026-05-12 07:47:16'),
(956, 2, NULL, 'success', 0.25, 88.40, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:21', '2026-05-12 07:47:21'),
(957, 2, NULL, 'success', 0.23, 89.95, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:29', '2026-05-12 07:47:29'),
(958, 2, NULL, 'success', 0.23, 89.94, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:34', '2026-05-12 07:47:34'),
(959, 16, NULL, 'failed', 0.38, 73.13, 'Confidence terlalu rendah (73.13%, minimum 75%). (kiosk)', '2026-05-12 07:47:39', '2026-05-12 07:47:39'),
(960, 12, NULL, 'success', 0.34, 78.85, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:44', '2026-05-12 07:47:44'),
(961, 12, 70, 'success', 0.34, 78.85, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-12 07:47:44', '2026-05-12 07:47:44'),
(962, 12, NULL, 'success', 0.32, 81.01, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:48', '2026-05-12 07:47:48'),
(963, 12, NULL, 'success', 0.36, 75.94, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:53', '2026-05-12 07:47:53'),
(964, 12, NULL, 'success', 0.34, 77.92, 'Wajah cocok. (kiosk)', '2026-05-12 07:47:58', '2026-05-12 07:47:58'),
(965, 12, NULL, 'success', 0.33, 79.60, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:03', '2026-05-12 07:48:03'),
(966, 12, NULL, 'success', 0.35, 77.88, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:08', '2026-05-12 07:48:08'),
(967, 12, NULL, 'success', 0.35, 77.27, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:13', '2026-05-12 07:48:13'),
(968, 12, NULL, 'success', 0.33, 79.81, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:18', '2026-05-12 07:48:18'),
(969, 12, NULL, 'failed', 0.40, 70.57, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:48:23', '2026-05-12 07:48:23'),
(970, 12, NULL, 'success', 0.33, 79.63, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:28', '2026-05-12 07:48:28'),
(971, 16, NULL, 'failed', 0.37, 74.16, 'Confidence terlalu rendah (74.16%, minimum 75%). (kiosk)', '2026-05-12 07:48:33', '2026-05-12 07:48:33'),
(972, 16, NULL, 'success', 0.34, 78.60, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:38', '2026-05-12 07:48:38'),
(973, 12, NULL, 'success', 0.36, 75.51, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:43', '2026-05-12 07:48:43'),
(974, 12, NULL, 'success', 0.35, 77.85, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:48', '2026-05-12 07:48:48'),
(975, 12, NULL, 'success', 0.33, 80.13, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:55', '2026-05-12 07:48:55'),
(976, 16, NULL, 'success', 0.33, 79.43, 'Wajah cocok. (kiosk)', '2026-05-12 07:48:59', '2026-05-12 07:48:59'),
(977, 10, NULL, 'failed', 0.43, 67.05, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:04', '2026-05-12 07:49:04'),
(978, 10, NULL, 'failed', 0.41, 68.79, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:09', '2026-05-12 07:49:09'),
(979, 10, NULL, 'failed', 0.43, 66.67, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:14', '2026-05-12 07:49:14'),
(980, 10, NULL, 'failed', 0.42, 68.38, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:21', '2026-05-12 07:49:21'),
(981, 10, NULL, 'failed', 0.43, 66.69, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:26', '2026-05-12 07:49:26'),
(982, 10, NULL, 'failed', 0.43, 66.46, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:31', '2026-05-12 07:49:31'),
(983, 10, NULL, 'failed', 0.43, 66.58, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:36', '2026-05-12 07:49:36'),
(984, 10, NULL, 'failed', 0.46, 62.63, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:41', '2026-05-12 07:49:41'),
(985, 10, NULL, 'failed', 0.45, 64.15, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:46', '2026-05-12 07:49:46'),
(986, 10, NULL, 'failed', 0.40, 70.42, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:51', '2026-05-12 07:49:51'),
(987, 10, NULL, 'failed', 0.44, 65.47, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:49:57', '2026-05-12 07:49:57'),
(988, 10, NULL, 'failed', 0.45, 64.16, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:02', '2026-05-12 07:50:02'),
(989, 10, NULL, 'failed', 0.42, 67.32, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:07', '2026-05-12 07:50:07'),
(990, 10, NULL, 'failed', 0.43, 65.86, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:12', '2026-05-12 07:50:12'),
(991, 10, NULL, 'failed', 0.41, 69.58, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:17', '2026-05-12 07:50:17'),
(992, 10, NULL, 'failed', 0.42, 68.11, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:22', '2026-05-12 07:50:22'),
(993, 10, NULL, 'failed', 0.42, 67.27, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:27', '2026-05-12 07:50:27'),
(994, 10, NULL, 'failed', 0.43, 66.50, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:32', '2026-05-12 07:50:32'),
(995, 10, NULL, 'failed', 0.43, 66.60, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:37', '2026-05-12 07:50:37'),
(996, 10, NULL, 'failed', 0.41, 69.04, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:42', '2026-05-12 07:50:42'),
(997, 10, NULL, 'failed', 0.44, 64.89, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:50:47', '2026-05-12 07:50:47'),
(998, 10, NULL, 'failed', 0.38, 72.94, 'Confidence terlalu rendah (72.94%, minimum 75%). (kiosk)', '2026-05-12 07:51:00', '2026-05-12 07:51:00'),
(999, 10, NULL, 'failed', 0.39, 71.88, 'Confidence terlalu rendah (71.88%, minimum 75%). (kiosk)', '2026-05-12 07:51:05', '2026-05-12 07:51:05'),
(1000, 10, NULL, 'failed', 0.40, 70.03, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:51:14', '2026-05-12 07:51:14'),
(1001, 10, NULL, 'failed', 0.40, 70.88, 'Confidence terlalu rendah (70.88%, minimum 75%). (kiosk)', '2026-05-12 07:51:19', '2026-05-12 07:51:19'),
(1002, 10, NULL, 'failed', 0.40, 70.16, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:51:28', '2026-05-12 07:51:28'),
(1003, 10, NULL, 'failed', 0.45, 63.46, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:51:33', '2026-05-12 07:51:33'),
(1004, 10, NULL, 'failed', 0.42, 67.50, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:51:38', '2026-05-12 07:51:38'),
(1005, 10, NULL, 'failed', 0.44, 64.27, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:51:43', '2026-05-12 07:51:43'),
(1006, 10, NULL, 'failed', 0.45, 63.33, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:51:48', '2026-05-12 07:51:48'),
(1007, 10, NULL, 'failed', 0.41, 69.00, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:52:27', '2026-05-12 07:52:27'),
(1008, 10, NULL, 'failed', 0.41, 68.78, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:52:32', '2026-05-12 07:52:32'),
(1009, 10, NULL, 'failed', 0.41, 69.36, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:53:21', '2026-05-12 07:53:21'),
(1010, 10, NULL, 'failed', 0.41, 68.74, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:53:32', '2026-05-12 07:53:32'),
(1011, 10, NULL, 'failed', 0.42, 67.88, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:54:57', '2026-05-12 07:54:57'),
(1012, 10, NULL, 'failed', 0.41, 69.90, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:55:58', '2026-05-12 07:55:58'),
(1013, 10, NULL, 'failed', 0.39, 71.58, 'Confidence terlalu rendah (71.58%, minimum 75%). (kiosk)', '2026-05-12 07:57:49', '2026-05-12 07:57:49'),
(1014, 10, NULL, 'failed', 0.43, 67.13, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:57:54', '2026-05-12 07:57:54'),
(1015, 10, NULL, 'failed', 0.40, 70.56, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:58:01', '2026-05-12 07:58:01'),
(1016, 10, NULL, 'failed', 0.39, 72.22, 'Confidence terlalu rendah (72.22%, minimum 75%). (kiosk)', '2026-05-12 07:59:28', '2026-05-12 07:59:28'),
(1017, 10, NULL, 'failed', 0.40, 70.06, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:59:33', '2026-05-12 07:59:33'),
(1018, 10, NULL, 'failed', 0.40, 70.69, 'Wajah tidak cocok. (kiosk)', '2026-05-12 07:59:44', '2026-05-12 07:59:44'),
(1019, 10, NULL, 'failed', 0.38, 72.92, 'Confidence terlalu rendah (72.92%, minimum 75%). (kiosk)', '2026-05-12 07:59:49', '2026-05-12 07:59:49'),
(1020, 10, NULL, 'failed', 0.39, 72.40, 'Confidence terlalu rendah (72.4%, minimum 75%). (kiosk)', '2026-05-12 07:59:56', '2026-05-12 07:59:56'),
(1021, 10, NULL, 'failed', 0.39, 72.74, 'Confidence terlalu rendah (72.74%, minimum 75%). (kiosk)', '2026-05-12 08:00:09', '2026-05-12 08:00:09'),
(1022, 10, NULL, 'failed', 0.38, 73.82, 'Confidence terlalu rendah (73.82%, minimum 75%). (kiosk)', '2026-05-12 08:00:14', '2026-05-12 08:00:14'),
(1023, 10, NULL, 'failed', 0.38, 73.28, 'Confidence terlalu rendah (73.28%, minimum 75%). (kiosk)', '2026-05-12 08:00:19', '2026-05-12 08:00:19'),
(1024, 10, NULL, 'failed', 0.38, 73.11, 'Confidence terlalu rendah (73.11%, minimum 75%). (kiosk)', '2026-05-12 08:00:24', '2026-05-12 08:00:24'),
(1025, 10, NULL, 'failed', 0.38, 73.63, 'Confidence terlalu rendah (73.63%, minimum 75%). (kiosk)', '2026-05-12 08:00:29', '2026-05-12 08:00:29'),
(1026, 10, NULL, 'failed', 0.38, 73.65, 'Confidence terlalu rendah (73.65%, minimum 75%). (kiosk)', '2026-05-12 08:00:36', '2026-05-12 08:00:36'),
(1027, 10, NULL, 'failed', 0.39, 72.61, 'Confidence terlalu rendah (72.61%, minimum 75%). (kiosk)', '2026-05-12 08:00:41', '2026-05-12 08:00:41'),
(1028, 10, NULL, 'failed', 0.39, 72.74, 'Confidence terlalu rendah (72.74%, minimum 75%). (kiosk)', '2026-05-12 08:01:36', '2026-05-12 08:01:36'),
(1029, 10, NULL, 'failed', 0.40, 71.14, 'Confidence terlalu rendah (71.14%, minimum 75%). (kiosk)', '2026-05-12 08:02:03', '2026-05-12 08:02:03'),
(1030, 10, NULL, 'failed', 0.42, 68.44, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:02:08', '2026-05-12 08:02:08'),
(1031, 10, NULL, 'failed', 0.42, 67.17, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:02:13', '2026-05-12 08:02:13'),
(1032, 10, NULL, 'failed', 0.40, 71.26, 'Confidence terlalu rendah (71.26%, minimum 75%). (kiosk)', '2026-05-12 08:02:18', '2026-05-12 08:02:18'),
(1033, 10, NULL, 'failed', 0.40, 70.19, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:02:23', '2026-05-12 08:02:23'),
(1034, 10, NULL, 'failed', 0.39, 72.24, 'Confidence terlalu rendah (72.24%, minimum 75%). (kiosk)', '2026-05-12 08:02:28', '2026-05-12 08:02:28'),
(1035, 10, NULL, 'failed', 0.39, 72.43, 'Confidence terlalu rendah (72.43%, minimum 75%). (kiosk)', '2026-05-12 08:02:33', '2026-05-12 08:02:33'),
(1036, 10, NULL, 'failed', 0.40, 71.06, 'Confidence terlalu rendah (71.06%, minimum 75%). (kiosk)', '2026-05-12 08:03:16', '2026-05-12 08:03:16'),
(1037, 10, NULL, 'failed', 0.38, 72.94, 'Confidence terlalu rendah (72.94%, minimum 75%). (kiosk)', '2026-05-12 08:03:21', '2026-05-12 08:03:21'),
(1038, 10, NULL, 'failed', 0.39, 72.49, 'Confidence terlalu rendah (72.49%, minimum 75%). (kiosk)', '2026-05-12 08:03:26', '2026-05-12 08:03:26'),
(1039, 10, NULL, 'failed', 0.40, 70.27, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:03:31', '2026-05-12 08:03:31'),
(1040, 10, NULL, 'failed', 0.39, 71.74, 'Confidence terlalu rendah (71.74%, minimum 75%). (kiosk)', '2026-05-12 08:03:36', '2026-05-12 08:03:36'),
(1041, 10, NULL, 'failed', 0.39, 72.29, 'Confidence terlalu rendah (72.29%, minimum 75%). (kiosk)', '2026-05-12 08:03:41', '2026-05-12 08:03:41'),
(1042, 10, NULL, 'failed', 0.39, 72.11, 'Confidence terlalu rendah (72.11%, minimum 75%). (kiosk)', '2026-05-12 08:03:46', '2026-05-12 08:03:46'),
(1043, 10, NULL, 'failed', 0.39, 72.36, 'Confidence terlalu rendah (72.36%, minimum 75%). (kiosk)', '2026-05-12 08:03:51', '2026-05-12 08:03:51'),
(1044, 10, NULL, 'failed', 0.39, 71.89, 'Confidence terlalu rendah (71.89%, minimum 75%). (kiosk)', '2026-05-12 08:03:56', '2026-05-12 08:03:56'),
(1045, 10, NULL, 'failed', 0.40, 71.26, 'Confidence terlalu rendah (71.26%, minimum 75%). (kiosk)', '2026-05-12 08:04:01', '2026-05-12 08:04:01'),
(1046, 10, NULL, 'failed', 0.37, 74.57, 'Confidence terlalu rendah (74.57%, minimum 75%). (kiosk)', '2026-05-12 08:04:06', '2026-05-12 08:04:06'),
(1047, 10, NULL, 'failed', 0.40, 71.24, 'Confidence terlalu rendah (71.24%, minimum 75%). (kiosk)', '2026-05-12 08:04:11', '2026-05-12 08:04:11'),
(1048, 10, NULL, 'failed', 0.39, 72.48, 'Confidence terlalu rendah (72.48%, minimum 75%). (kiosk)', '2026-05-12 08:04:16', '2026-05-12 08:04:16'),
(1049, 10, NULL, 'failed', 0.41, 68.94, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:04:21', '2026-05-12 08:04:21'),
(1050, 10, NULL, 'failed', 0.41, 68.77, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:04:26', '2026-05-12 08:04:26'),
(1051, 10, NULL, 'failed', 0.40, 70.13, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:04:31', '2026-05-12 08:04:31'),
(1052, 10, NULL, 'failed', 0.38, 72.85, 'Confidence terlalu rendah (72.85%, minimum 75%). (kiosk)', '2026-05-12 08:04:36', '2026-05-12 08:04:36'),
(1053, 10, NULL, 'failed', 0.42, 68.40, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:04:41', '2026-05-12 08:04:41'),
(1054, 10, NULL, 'failed', 0.41, 69.58, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:04:46', '2026-05-12 08:04:46'),
(1055, 10, NULL, 'failed', 0.41, 69.42, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:04:51', '2026-05-12 08:04:51'),
(1056, 10, NULL, 'failed', 0.41, 68.67, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:04:56', '2026-05-12 08:04:56'),
(1057, 10, NULL, 'failed', 0.40, 71.08, 'Confidence terlalu rendah (71.08%, minimum 75%). (kiosk)', '2026-05-12 08:05:01', '2026-05-12 08:05:01'),
(1058, 10, NULL, 'failed', 0.41, 69.14, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:05:06', '2026-05-12 08:05:06'),
(1059, 10, NULL, 'failed', 0.41, 69.43, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:05:11', '2026-05-12 08:05:11'),
(1060, 10, NULL, 'failed', 0.39, 72.29, 'Confidence terlalu rendah (72.29%, minimum 75%). (kiosk)', '2026-05-12 08:05:16', '2026-05-12 08:05:16'),
(1061, 10, NULL, 'failed', 0.39, 72.23, 'Confidence terlalu rendah (72.23%, minimum 75%). (kiosk)', '2026-05-12 08:05:21', '2026-05-12 08:05:21'),
(1062, 10, NULL, 'failed', 0.40, 70.75, 'Confidence terlalu rendah (70.75%, minimum 75%). (kiosk)', '2026-05-12 08:05:26', '2026-05-12 08:05:26'),
(1063, 10, NULL, 'failed', 0.38, 72.99, 'Confidence terlalu rendah (72.99%, minimum 75%). (kiosk)', '2026-05-12 08:05:31', '2026-05-12 08:05:31'),
(1064, 10, NULL, 'failed', 0.39, 71.43, 'Confidence terlalu rendah (71.43%, minimum 75%). (kiosk)', '2026-05-12 08:05:36', '2026-05-12 08:05:36'),
(1065, 10, NULL, 'failed', 0.42, 67.47, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:05:41', '2026-05-12 08:05:41'),
(1066, 10, NULL, 'failed', 0.41, 68.91, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:05:46', '2026-05-12 08:05:46'),
(1067, 10, NULL, 'failed', 0.38, 73.42, 'Confidence terlalu rendah (73.42%, minimum 75%). (kiosk)', '2026-05-12 08:05:53', '2026-05-12 08:05:53'),
(1068, 10, NULL, 'failed', 0.43, 65.71, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:05:58', '2026-05-12 08:05:58'),
(1069, 10, NULL, 'failed', 0.39, 72.20, 'Confidence terlalu rendah (72.2%, minimum 75%). (kiosk)', '2026-05-12 08:06:03', '2026-05-12 08:06:03'),
(1070, 10, NULL, 'failed', 0.39, 72.60, 'Confidence terlalu rendah (72.6%, minimum 75%). (kiosk)', '2026-05-12 08:06:08', '2026-05-12 08:06:08'),
(1071, 10, NULL, 'failed', 0.39, 72.61, 'Confidence terlalu rendah (72.61%, minimum 75%). (kiosk)', '2026-05-12 08:06:13', '2026-05-12 08:06:13'),
(1072, 10, NULL, 'failed', 0.45, 64.17, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:06:24', '2026-05-12 08:06:24'),
(1073, 10, NULL, 'failed', 0.42, 67.38, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:06:33', '2026-05-12 08:06:33'),
(1074, 10, NULL, 'failed', 0.41, 69.23, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:06:38', '2026-05-12 08:06:38'),
(1075, 10, NULL, 'failed', 0.42, 67.65, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:07:15', '2026-05-12 08:07:15'),
(1076, 10, NULL, 'failed', 0.39, 72.23, 'Confidence terlalu rendah (72.23%, minimum 75%). (kiosk)', '2026-05-12 08:07:19', '2026-05-12 08:07:19'),
(1077, 2, NULL, 'success', 0.16, 95.17, 'Wajah cocok. (kiosk)', '2026-05-12 08:08:32', '2026-05-12 08:08:32'),
(1078, 2, NULL, 'success', 0.18, 93.83, 'Wajah cocok. (kiosk)', '2026-05-12 08:08:38', '2026-05-12 08:08:38'),
(1079, 10, NULL, 'failed', 0.47, 60.59, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:08:47', '2026-05-12 08:08:47'),
(1080, 10, NULL, 'failed', 0.42, 68.44, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:08:52', '2026-05-12 08:08:52'),
(1081, 2, NULL, 'success', 0.36, 76.06, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:00', '2026-05-12 08:09:00'),
(1082, 2, NULL, 'success', 0.23, 89.97, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:07', '2026-05-12 08:09:07'),
(1083, 2, NULL, 'success', 0.22, 90.70, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:12', '2026-05-12 08:09:12'),
(1084, 2, NULL, 'success', 0.18, 93.62, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:17', '2026-05-12 08:09:17'),
(1085, 2, NULL, 'success', 0.19, 93.40, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:22', '2026-05-12 08:09:22'),
(1086, 2, NULL, 'success', 0.22, 91.03, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:27', '2026-05-12 08:09:27'),
(1087, 2, NULL, 'success', 0.21, 92.00, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:32', '2026-05-12 08:09:32'),
(1088, 2, NULL, 'success', 0.20, 92.11, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:37', '2026-05-12 08:09:37'),
(1089, 2, NULL, 'success', 0.21, 91.87, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:42', '2026-05-12 08:09:42'),
(1090, 2, NULL, 'success', 0.18, 93.66, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:47', '2026-05-12 08:09:47'),
(1091, 2, NULL, 'success', 0.20, 92.29, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:52', '2026-05-12 08:09:52'),
(1092, 2, NULL, 'success', 0.25, 88.45, 'Wajah cocok. (kiosk)', '2026-05-12 08:09:57', '2026-05-12 08:09:57'),
(1093, 2, NULL, 'success', 0.21, 91.45, 'Wajah cocok. (kiosk)', '2026-05-12 08:10:02', '2026-05-12 08:10:02'),
(1094, 2, NULL, 'success', 0.21, 91.78, 'Wajah cocok. (kiosk)', '2026-05-12 08:10:07', '2026-05-12 08:10:07'),
(1095, 2, NULL, 'success', 0.21, 91.68, 'Wajah cocok. (kiosk)', '2026-05-12 08:10:12', '2026-05-12 08:10:12'),
(1096, 2, NULL, 'success', 0.18, 93.90, 'Wajah cocok. (kiosk)', '2026-05-12 08:10:17', '2026-05-12 08:10:17'),
(1097, 10, NULL, 'failed', 0.40, 70.33, 'Wajah tidak cocok. (kiosk)', '2026-05-12 08:10:21', '2026-05-12 08:10:21'),
(1098, 12, NULL, 'success', 0.22, 91.17, 'Wajah cocok. (kiosk)', '2026-05-12 08:11:23', '2026-05-12 08:11:23'),
(1099, 12, NULL, 'success', 0.20, 92.21, 'Wajah cocok. (kiosk)', '2026-05-12 08:11:27', '2026-05-12 08:11:27'),
(1100, 2, NULL, 'success', 0.27, 86.50, 'Wajah cocok. (kiosk)', '2026-05-12 08:11:29', '2026-05-12 08:11:29'),
(1101, 2, NULL, 'success', 0.27, 86.48, 'Wajah cocok. (kiosk)', '2026-05-12 08:11:34', '2026-05-12 08:11:34'),
(1102, 12, NULL, 'success', 0.25, 88.30, 'Wajah cocok. (kiosk)', '2026-05-12 08:11:34', '2026-05-12 08:11:34'),
(1103, 12, NULL, 'success', 0.23, 90.23, 'Wajah cocok. (kiosk)', '2026-05-12 08:11:39', '2026-05-12 08:11:39'),
(1104, 2, NULL, 'success', 0.34, 78.51, 'Wajah cocok. (kiosk)', '2026-05-12 08:11:47', '2026-05-12 08:11:47'),
(1105, 2, NULL, 'success', 0.19, 92.93, 'Wajah cocok. (kiosk)', '2026-05-12 08:11:52', '2026-05-12 08:11:52'),
(1106, 2, NULL, 'success', 0.15, 95.56, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:12', '2026-05-13 03:47:12'),
(1107, 2, 67, 'success', 0.15, 95.56, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-13 03:47:12', '2026-05-13 03:47:12'),
(1108, 2, NULL, 'success', 0.19, 92.78, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:17', '2026-05-13 03:47:17'),
(1109, 2, NULL, 'success', 0.16, 95.18, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:22', '2026-05-13 03:47:22'),
(1110, 2, NULL, 'success', 0.23, 89.87, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:31', '2026-05-13 03:47:31'),
(1111, 2, NULL, 'success', 0.22, 90.64, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:36', '2026-05-13 03:47:36'),
(1112, 2, NULL, 'success', 0.15, 95.73, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:41', '2026-05-13 03:47:41'),
(1113, 2, NULL, 'success', 0.15, 95.47, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:46', '2026-05-13 03:47:46'),
(1114, 2, NULL, 'success', 0.19, 93.45, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:51', '2026-05-13 03:47:51'),
(1115, 2, NULL, 'success', 0.21, 91.46, 'Wajah cocok. (kiosk)', '2026-05-13 03:47:56', '2026-05-13 03:47:56'),
(1116, 2, NULL, 'success', 0.21, 91.85, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:01', '2026-05-13 03:48:01'),
(1117, 2, NULL, 'success', 0.16, 94.93, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:08', '2026-05-13 03:48:08'),
(1118, 2, NULL, 'success', 0.29, 84.71, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:16', '2026-05-13 03:48:16'),
(1119, 2, NULL, 'success', 0.18, 93.62, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:24', '2026-05-13 03:48:24'),
(1120, 2, NULL, 'success', 0.22, 91.17, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:29', '2026-05-13 03:48:29'),
(1121, 2, NULL, 'success', 0.22, 90.65, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:34', '2026-05-13 03:48:34'),
(1122, 2, NULL, 'success', 0.13, 96.70, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:39', '2026-05-13 03:48:39'),
(1123, 2, NULL, 'success', 0.20, 92.39, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:44', '2026-05-13 03:48:44'),
(1124, 2, NULL, 'success', 0.15, 95.66, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:49', '2026-05-13 03:48:49'),
(1125, 2, NULL, 'success', 0.21, 91.93, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:54', '2026-05-13 03:48:54'),
(1126, 2, NULL, 'success', 0.22, 91.21, 'Wajah cocok. (kiosk)', '2026-05-13 03:48:59', '2026-05-13 03:48:59'),
(1127, 2, NULL, 'success', 0.16, 95.04, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:04', '2026-05-13 03:49:04'),
(1128, 2, NULL, 'success', 0.31, 82.27, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:16', '2026-05-13 03:49:16'),
(1129, 2, NULL, 'success', 0.22, 90.61, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:23', '2026-05-13 03:49:23'),
(1130, 2, NULL, 'success', 0.27, 85.83, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:28', '2026-05-13 03:49:28'),
(1131, 2, NULL, 'success', 0.26, 86.81, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:33', '2026-05-13 03:49:33'),
(1132, 2, NULL, 'success', 0.19, 93.07, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:38', '2026-05-13 03:49:38'),
(1133, 2, NULL, 'success', 0.24, 89.53, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:43', '2026-05-13 03:49:43'),
(1134, 2, NULL, 'success', 0.23, 90.16, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:48', '2026-05-13 03:49:48'),
(1135, 2, NULL, 'success', 0.24, 89.29, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:53', '2026-05-13 03:49:53'),
(1136, 2, NULL, 'success', 0.18, 93.96, 'Wajah cocok. (kiosk)', '2026-05-13 03:49:58', '2026-05-13 03:49:58'),
(1137, 2, NULL, 'success', 0.17, 94.60, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:03', '2026-05-13 03:50:03'),
(1138, 2, NULL, 'success', 0.24, 88.80, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:08', '2026-05-13 03:50:08'),
(1139, 2, NULL, 'success', 0.31, 82.56, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:13', '2026-05-13 03:50:13'),
(1140, 2, NULL, 'success', 0.21, 91.61, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:18', '2026-05-13 03:50:18'),
(1141, 2, NULL, 'success', 0.17, 94.22, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:23', '2026-05-13 03:50:23'),
(1142, 2, NULL, 'success', 0.16, 94.99, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:28', '2026-05-13 03:50:28'),
(1143, 2, NULL, 'success', 0.17, 94.58, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:33', '2026-05-13 03:50:33'),
(1144, 2, NULL, 'success', 0.23, 90.29, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:48', '2026-05-13 03:50:48'),
(1145, 2, NULL, 'success', 0.20, 92.32, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:53', '2026-05-13 03:50:53'),
(1146, 2, NULL, 'success', 0.22, 90.57, 'Wajah cocok. (kiosk)', '2026-05-13 03:50:58', '2026-05-13 03:50:58'),
(1147, 2, NULL, 'success', 0.18, 93.94, 'Wajah cocok. (kiosk)', '2026-05-13 03:51:03', '2026-05-13 03:51:03'),
(1148, 2, NULL, 'success', 0.15, 95.74, 'Wajah cocok. (kiosk)', '2026-05-13 03:51:08', '2026-05-13 03:51:08'),
(1149, 2, NULL, 'success', 0.28, 84.92, 'Wajah cocok. (kiosk)', '2026-05-13 03:51:13', '2026-05-13 03:51:13'),
(1150, 2, NULL, 'success', 0.22, 90.81, 'Wajah cocok. (kiosk)', '2026-05-13 03:51:46', '2026-05-13 03:51:46'),
(1151, 2, NULL, 'success', 0.29, 83.89, 'Wajah cocok. (kiosk)', '2026-05-13 03:51:52', '2026-05-13 03:51:52'),
(1152, 2, NULL, 'success', 0.33, 79.30, 'Wajah cocok. (kiosk)', '2026-05-13 03:51:57', '2026-05-13 03:51:57'),
(1153, 2, NULL, 'success', 0.28, 85.43, 'Wajah cocok. (kiosk)', '2026-05-13 03:52:19', '2026-05-13 03:52:19'),
(1154, 2, NULL, 'success', 0.21, 91.49, 'Wajah cocok. (kiosk)', '2026-05-13 03:52:33', '2026-05-13 03:52:33'),
(1155, 2, NULL, 'success', 0.28, 84.88, 'Wajah cocok. (kiosk)', '2026-05-13 03:52:38', '2026-05-13 03:52:38'),
(1156, 2, NULL, 'failed', 0.37, 74.28, 'Confidence terlalu rendah (74.28%, minimum 75%). (kiosk)', '2026-05-13 03:52:49', '2026-05-13 03:52:49'),
(1157, 2, NULL, 'success', 0.29, 84.32, 'Wajah cocok. (kiosk)', '2026-05-13 03:52:54', '2026-05-13 03:52:54'),
(1158, 2, NULL, 'success', 0.33, 79.63, 'Wajah cocok. (kiosk)', '2026-05-13 03:52:59', '2026-05-13 03:52:59'),
(1159, 2, NULL, 'success', 0.24, 89.37, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:04', '2026-05-13 03:53:04'),
(1160, 2, NULL, 'success', 0.28, 84.92, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:09', '2026-05-13 03:53:09'),
(1161, 2, NULL, 'success', 0.28, 85.23, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:14', '2026-05-13 03:53:14'),
(1162, 2, NULL, 'success', 0.24, 89.12, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:19', '2026-05-13 03:53:19'),
(1163, 2, NULL, 'success', 0.26, 87.04, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:24', '2026-05-13 03:53:24'),
(1164, 2, NULL, 'success', 0.24, 88.86, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:29', '2026-05-13 03:53:29'),
(1165, 2, NULL, 'success', 0.28, 85.41, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:34', '2026-05-13 03:53:34'),
(1166, 2, NULL, 'success', 0.22, 90.65, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:39', '2026-05-13 03:53:39'),
(1167, 2, NULL, 'success', 0.27, 86.36, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:44', '2026-05-13 03:53:44'),
(1168, 2, NULL, 'success', 0.24, 88.72, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:49', '2026-05-13 03:53:49'),
(1169, 2, NULL, 'success', 0.28, 85.03, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:54', '2026-05-13 03:53:54'),
(1170, 2, NULL, 'success', 0.24, 89.08, 'Wajah cocok. (kiosk)', '2026-05-13 03:53:59', '2026-05-13 03:53:59'),
(1171, 2, NULL, 'success', 0.28, 85.09, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:04', '2026-05-13 03:54:04'),
(1172, 2, NULL, 'success', 0.26, 87.06, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:09', '2026-05-13 03:54:09'),
(1173, 2, NULL, 'success', 0.23, 89.91, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:14', '2026-05-13 03:54:14'),
(1174, 2, NULL, 'success', 0.25, 88.31, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:19', '2026-05-13 03:54:19'),
(1175, 2, NULL, 'success', 0.23, 89.78, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:24', '2026-05-13 03:54:24'),
(1176, 2, NULL, 'success', 0.33, 79.76, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:30', '2026-05-13 03:54:30'),
(1177, 2, NULL, 'success', 0.13, 96.70, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:35', '2026-05-13 03:54:35'),
(1178, 2, NULL, 'success', 0.19, 93.31, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:40', '2026-05-13 03:54:40'),
(1179, 2, NULL, 'failed', 0.39, 71.95, 'Confidence terlalu rendah (71.95%, minimum 75%). (kiosk)', '2026-05-13 03:54:41', '2026-05-13 03:54:41'),
(1180, 2, NULL, 'success', 0.18, 93.79, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:45', '2026-05-13 03:54:45'),
(1181, 2, NULL, 'success', 0.14, 96.21, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:50', '2026-05-13 03:54:50'),
(1182, 2, NULL, 'success', 0.18, 93.72, 'Wajah cocok. (kiosk)', '2026-05-13 03:54:55', '2026-05-13 03:54:55'),
(1183, 2, NULL, 'success', 0.25, 88.24, 'Wajah cocok. (kiosk)', '2026-05-13 10:50:02', '2026-05-13 10:50:02'),
(1184, 2, 67, 'success', 0.25, 88.24, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-13 10:50:02', '2026-05-13 10:50:02'),
(1185, 2, NULL, 'success', 0.23, 90.39, 'Wajah cocok. (kiosk)', '2026-05-13 10:50:07', '2026-05-13 10:50:07'),
(1186, 2, NULL, 'success', 0.22, 90.65, 'Wajah cocok. (kiosk)', '2026-05-13 10:50:12', '2026-05-13 10:50:12'),
(1187, 2, NULL, 'success', 0.28, 84.96, 'Wajah cocok. (kiosk)', '2026-05-13 12:23:09', '2026-05-13 12:23:09'),
(1188, 2, 71, 'success', 0.28, 84.96, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-13 12:23:09', '2026-05-13 12:23:09'),
(1189, 2, NULL, 'success', 0.28, 85.19, 'Wajah cocok. (kiosk)', '2026-05-13 12:23:14', '2026-05-13 12:23:14'),
(1190, 2, NULL, 'success', 0.19, 93.28, 'Wajah cocok. (kiosk)', '2026-05-19 05:43:25', '2026-05-19 05:43:25'),
(1191, 2, 72, 'success', 0.19, 93.28, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-19 05:43:25', '2026-05-19 05:43:25'),
(1192, 2, NULL, 'success', 0.18, 93.72, 'Wajah cocok. (kiosk)', '2026-05-19 05:43:30', '2026-05-19 05:43:30'),
(1193, 2, NULL, 'success', 0.17, 94.45, 'Wajah cocok. (kiosk)', '2026-05-19 06:06:23', '2026-05-19 06:06:23'),
(1194, 2, 73, 'success', 0.17, 94.45, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-19 06:06:23', '2026-05-19 06:06:23'),
(1195, 2, NULL, 'success', 0.18, 94.09, 'Wajah cocok. (kiosk)', '2026-05-19 06:06:28', '2026-05-19 06:06:28'),
(1196, 2, NULL, 'success', 0.19, 92.89, 'Wajah cocok. (kiosk)', '2026-05-19 06:06:33', '2026-05-19 06:06:33'),
(1197, 2, NULL, 'success', 0.18, 93.85, 'Wajah cocok. (kiosk)', '2026-05-19 06:06:38', '2026-05-19 06:06:38'),
(1198, 2, NULL, 'success', 0.21, 91.70, 'Wajah cocok. (kiosk)', '2026-05-19 06:06:43', '2026-05-19 06:06:43'),
(1199, 2, NULL, 'success', 0.21, 91.73, 'Wajah cocok. (kiosk)', '2026-05-19 06:06:49', '2026-05-19 06:06:49'),
(1200, 2, NULL, 'success', 0.19, 93.09, 'Wajah cocok. (kiosk)', '2026-05-19 06:06:54', '2026-05-19 06:06:54'),
(1201, 2, NULL, 'success', 0.31, 82.59, 'Wajah cocok. (kiosk)', '2026-05-19 06:06:59', '2026-05-19 06:06:59'),
(1202, 2, NULL, 'success', 0.27, 86.36, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:04', '2026-05-19 06:07:04'),
(1203, 2, NULL, 'success', 0.27, 86.32, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:09', '2026-05-19 06:07:09'),
(1204, 2, NULL, 'success', 0.26, 86.81, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:14', '2026-05-19 06:07:14'),
(1205, 2, NULL, 'success', 0.25, 87.86, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:19', '2026-05-19 06:07:19'),
(1206, 2, NULL, 'success', 0.25, 88.51, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:24', '2026-05-19 06:07:24'),
(1207, 2, NULL, 'success', 0.23, 89.55, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:29', '2026-05-19 06:07:29'),
(1208, 2, NULL, 'success', 0.27, 86.65, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:38', '2026-05-19 06:07:38'),
(1209, 2, NULL, 'success', 0.22, 91.12, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:43', '2026-05-19 06:07:43'),
(1210, 2, NULL, 'success', 0.19, 93.27, 'Wajah cocok. (kiosk)', '2026-05-19 06:07:58', '2026-05-19 06:07:58'),
(1211, 2, NULL, 'success', 0.19, 92.85, 'Wajah cocok. (kiosk)', '2026-05-19 06:08:11', '2026-05-19 06:08:11'),
(1212, 2, NULL, 'success', 0.32, 80.85, 'Wajah cocok. (kiosk)', '2026-05-19 06:08:16', '2026-05-19 06:08:16'),
(1213, 2, NULL, 'success', 0.22, 90.80, 'Wajah cocok. (kiosk)', '2026-05-19 06:08:20', '2026-05-19 06:08:20'),
(1214, 2, NULL, 'success', 0.19, 93.22, 'Wajah cocok. (kiosk)', '2026-05-19 06:08:35', '2026-05-19 06:08:35'),
(1215, 2, NULL, 'success', 0.24, 89.18, 'Wajah cocok. (kiosk)', '2026-05-19 06:08:40', '2026-05-19 06:08:40'),
(1216, 2, NULL, 'success', 0.30, 83.59, 'Wajah cocok. (kiosk)', '2026-05-19 06:08:46', '2026-05-19 06:08:46'),
(1217, 2, NULL, 'success', 0.20, 92.68, 'Wajah cocok. (kiosk)', '2026-05-19 06:12:45', '2026-05-19 06:12:45'),
(1218, 2, 72, 'success', 0.20, 92.68, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-19 06:12:45', '2026-05-19 06:12:45'),
(1219, 2, NULL, 'success', 0.19, 93.47, 'Wajah cocok. (kiosk)', '2026-05-19 06:12:50', '2026-05-19 06:12:50'),
(1220, 2, NULL, 'success', 0.22, 90.59, 'Wajah cocok. (kiosk)', '2026-05-19 06:12:55', '2026-05-19 06:12:55'),
(1221, 2, NULL, 'success', 0.23, 90.19, 'Wajah cocok. (kiosk)', '2026-05-19 06:13:00', '2026-05-19 06:13:00'),
(1222, 2, NULL, 'success', 0.24, 89.33, 'Wajah cocok. (kiosk)', '2026-05-19 06:13:07', '2026-05-19 06:13:07'),
(1223, 2, NULL, 'success', 0.24, 89.48, 'Wajah cocok. (kiosk)', '2026-05-19 06:13:12', '2026-05-19 06:13:12'),
(1224, 2, NULL, 'success', 0.25, 88.25, 'Wajah cocok. (kiosk)', '2026-05-19 06:13:17', '2026-05-19 06:13:17'),
(1225, 2, NULL, 'success', 0.19, 93.01, 'Wajah cocok. (kiosk)', '2026-05-19 06:13:22', '2026-05-19 06:13:22'),
(1226, 2, NULL, 'success', 0.22, 91.05, 'Wajah cocok. (kiosk)', '2026-05-19 06:13:27', '2026-05-19 06:13:27'),
(1227, 2, NULL, 'failed', 0.43, 66.50, 'Wajah tidak cocok. (kiosk)', '2026-05-19 07:01:44', '2026-05-19 07:01:44'),
(1228, 2, NULL, 'failed', 0.43, 65.76, 'Wajah tidak cocok. (kiosk)', '2026-05-19 07:01:49', '2026-05-19 07:01:49'),
(1229, 2, NULL, 'failed', 0.44, 65.19, 'Wajah tidak cocok. (kiosk)', '2026-05-19 07:01:54', '2026-05-19 07:01:54'),
(1230, 2, NULL, 'success', 0.17, 94.49, 'Wajah cocok. (kiosk)', '2026-05-19 07:01:54', '2026-05-19 07:01:54'),
(1231, 2, 72, 'success', 0.17, 94.49, 'Identifikasi kiosk Face ID oleh dosen.', '2026-05-19 07:01:54', '2026-05-19 07:01:54'),
(1232, 2, NULL, 'success', 0.21, 91.41, 'Wajah cocok. (kiosk)', '2026-05-19 07:01:59', '2026-05-19 07:01:59'),
(1233, 2, NULL, 'failed', 0.43, 66.09, 'Wajah tidak cocok. (kiosk)', '2026-05-19 07:02:00', '2026-05-19 07:02:00'),
(1234, 2, NULL, 'success', 0.18, 93.55, 'Wajah cocok. (kiosk)', '2026-05-19 07:02:04', '2026-05-19 07:02:04'),
(1235, 2, NULL, 'success', 0.21, 91.84, 'Wajah cocok. (kiosk)', '2026-06-15 07:12:53', '2026-06-15 07:12:53'),
(1236, 2, 74, 'success', 0.21, 91.84, 'Identifikasi kiosk Face ID oleh dosen.', '2026-06-15 07:12:53', '2026-06-15 07:12:53'),
(1237, 2, NULL, 'success', 0.19, 93.04, 'Wajah cocok. (kiosk)', '2026-06-15 07:12:58', '2026-06-15 07:12:58');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_kelas`
--

CREATE TABLE `jadwal_kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `mata_kuliah_id` bigint(20) UNSIGNED NOT NULL,
  `hari` enum('senin','selasa','rabu','kamis','jumat','sabtu') NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `ruangan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jadwal_kelas`
--

INSERT INTO `jadwal_kelas` (`id`, `kelas_id`, `mata_kuliah_id`, `hari`, `jam_mulai`, `jam_selesai`, `ruangan`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'senin', '09:30:00', '12:03:00', 'J1', '2026-04-10 05:04:04', '2026-04-10 11:29:00'),
(2, 7, 5, 'sabtu', '11:00:00', '14:30:00', 'J1', '2026-04-10 11:28:47', '2026-04-25 04:42:44'),
(3, 6, 3, 'selasa', '12:50:00', '15:20:00', 'J2', '2026-04-10 11:31:03', '2026-04-10 11:31:03'),
(4, 3, 2, 'rabu', '12:00:00', '15:30:00', 'J3', '2026-04-10 11:31:39', '2026-04-21 22:29:27'),
(5, 5, 6, 'senin', '01:00:00', '03:40:00', NULL, '2026-04-21 08:06:27', '2026-04-21 08:06:27'),
(6, 5, 4, 'selasa', '21:00:00', '23:59:00', NULL, '2026-04-21 08:38:40', '2026-04-21 08:41:28'),
(7, 7, 7, 'senin', '12:00:00', '15:30:00', NULL, '2026-05-13 12:17:15', '2026-05-13 12:17:15'),
(8, 5, 8, 'senin', '13:00:00', '15:30:00', 'J1', '2026-06-15 07:07:58', '2026-06-15 07:07:58');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kelas` varchar(255) NOT NULL,
  `ruang_kelas` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `nama_kelas`, `ruang_kelas`, `created_at`, `updated_at`) VALUES
(1, 'J001', 'GD A', '2026-04-10 05:02:20', '2026-04-10 05:02:20'),
(2, 'J002', 'GD A', '2026-04-10 08:51:48', '2026-04-10 08:51:48'),
(3, 'J003', 'GD A', '2026-04-10 08:51:57', '2026-04-10 08:51:57'),
(4, 'J004', 'GD A', '2026-04-10 08:52:06', '2026-04-10 08:52:06'),
(5, 'C001', 'GD B', '2026-04-10 08:52:27', '2026-04-10 08:52:27'),
(6, 'C002', 'GD B', '2026-04-10 08:52:43', '2026-04-10 08:52:43'),
(7, 'C003', 'GD B', '2026-04-10 08:52:53', '2026-04-10 08:52:53'),
(8, 'J005', 'GD A', '2026-06-15 07:06:01', '2026-06-15 07:06:01');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `nim` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id`, `user_id`, `kelas_id`, `nim`, `nama`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '230403010030\r\n', 'Andhika Kurniawan', '2026-04-10 08:04:52', '2026-04-10 08:04:52'),
(2, 6, 5, '230403010033', 'Krisna Halim', '2026-04-10 11:12:03', '2026-04-10 11:12:03'),
(3, 7, 5, '230403010034', 'Krisna Putra', '2026-04-10 11:12:17', '2026-04-10 11:12:17'),
(4, 10, 5, '230403010038', 'Irvin', '2026-04-12 22:26:29', '2026-04-12 22:26:29'),
(5, 11, 5, '230403010039', 'Ahmad Zam Zami', '2026-04-20 22:54:38', '2026-04-20 22:54:38'),
(6, 12, 5, '230403010040', 'Febri Brilian Barkah', '2026-04-20 23:02:49', '2026-04-20 23:02:49'),
(8, 15, 5, '230403010051', 'Pandu Arta', '2026-04-27 09:57:12', '2026-04-27 09:57:12'),
(9, 16, 5, '230403010045', 'Zidan', '2026-05-04 05:32:41', '2026-05-04 05:32:41');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa_mata_kuliah`
--

CREATE TABLE `mahasiswa_mata_kuliah` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mahasiswa_id` bigint(20) UNSIGNED NOT NULL,
  `mata_kuliah_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mahasiswa_mata_kuliah`
--

INSERT INTO `mahasiswa_mata_kuliah` (`id`, `mahasiswa_id`, `mata_kuliah_id`, `created_at`, `updated_at`) VALUES
(2, 2, 1, '2026-04-10 11:32:48', '2026-04-10 11:32:48'),
(3, 2, 4, '2026-04-10 11:32:48', '2026-04-10 11:32:48'),
(4, 2, 3, '2026-04-10 11:32:48', '2026-04-10 11:32:48'),
(5, 2, 5, '2026-04-10 11:32:48', '2026-04-10 11:32:48'),
(6, 2, 2, '2026-04-10 11:32:48', '2026-04-10 11:32:48'),
(10, 1, 1, '2026-04-10 12:03:41', '2026-04-10 12:03:41'),
(11, 1, 4, '2026-04-10 12:03:41', '2026-04-10 12:03:41'),
(12, 1, 3, '2026-04-10 12:03:41', '2026-04-10 12:03:41'),
(13, 1, 5, '2026-04-10 12:03:41', '2026-04-10 12:03:41'),
(14, 1, 2, '2026-04-10 12:03:41', '2026-04-10 12:03:41'),
(15, 3, 1, '2026-04-10 12:04:58', '2026-04-10 12:04:58'),
(16, 3, 4, '2026-04-10 12:04:58', '2026-04-10 12:04:58'),
(17, 3, 3, '2026-04-10 12:04:58', '2026-04-10 12:04:58'),
(18, 3, 5, '2026-04-10 12:04:58', '2026-04-10 12:04:58'),
(19, 3, 2, '2026-04-10 12:04:58', '2026-04-10 12:04:58'),
(20, 4, 1, '2026-04-12 22:28:27', '2026-04-12 22:28:27'),
(21, 4, 4, '2026-04-12 22:28:27', '2026-04-12 22:28:27'),
(22, 4, 3, '2026-04-12 22:28:27', '2026-04-12 22:28:27'),
(23, 4, 5, '2026-04-12 22:28:27', '2026-04-12 22:28:27'),
(24, 4, 2, '2026-04-12 22:28:27', '2026-04-12 22:28:27'),
(25, 6, 1, '2026-04-21 00:31:30', '2026-04-21 00:31:30'),
(26, 6, 4, '2026-04-21 00:31:30', '2026-04-21 00:31:30'),
(27, 6, 3, '2026-04-21 00:31:30', '2026-04-21 00:31:30'),
(28, 6, 5, '2026-04-21 00:31:30', '2026-04-21 00:31:30'),
(29, 6, 2, '2026-04-21 00:31:30', '2026-04-21 00:31:30'),
(30, 5, 1, '2026-04-21 00:33:01', '2026-04-21 00:33:01'),
(31, 5, 4, '2026-04-21 00:33:01', '2026-04-21 00:33:01'),
(32, 5, 3, '2026-04-21 00:33:01', '2026-04-21 00:33:01'),
(33, 5, 5, '2026-04-21 00:33:01', '2026-04-21 00:33:01'),
(34, 5, 2, '2026-04-21 00:33:01', '2026-04-21 00:33:01'),
(35, 1, 6, '2026-04-21 08:44:20', '2026-04-21 08:44:20'),
(42, 8, 1, '2026-04-27 10:01:24', '2026-04-27 10:01:24'),
(43, 8, 4, '2026-04-27 10:01:24', '2026-04-27 10:01:24'),
(44, 8, 3, '2026-04-27 10:01:24', '2026-04-27 10:01:24'),
(45, 8, 6, '2026-04-27 10:01:24', '2026-04-27 10:01:24'),
(46, 8, 5, '2026-04-27 10:01:24', '2026-04-27 10:01:24'),
(47, 8, 2, '2026-04-27 10:01:24', '2026-04-27 10:01:24'),
(48, 9, 1, '2026-05-04 05:34:45', '2026-05-04 05:34:45'),
(49, 9, 4, '2026-05-04 05:34:45', '2026-05-04 05:34:45'),
(50, 9, 3, '2026-05-04 05:34:45', '2026-05-04 05:34:45'),
(51, 9, 6, '2026-05-04 05:34:45', '2026-05-04 05:34:45'),
(52, 9, 5, '2026-05-04 05:34:45', '2026-05-04 05:34:45'),
(53, 9, 2, '2026-05-04 05:34:45', '2026-05-04 05:34:45'),
(54, 2, 6, '2026-05-04 05:43:21', '2026-05-04 05:43:21'),
(55, 6, 6, '2026-05-12 08:15:29', '2026-05-12 08:15:29'),
(56, 1, 7, '2026-05-13 12:22:41', '2026-05-13 12:22:41'),
(57, 1, 8, '2026-06-15 07:10:07', '2026-06-15 07:10:07');

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dosen_id` bigint(20) UNSIGNED NOT NULL,
  `kode_mk` varchar(255) NOT NULL,
  `nama_mk` varchar(255) NOT NULL,
  `sks` tinyint(3) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`id`, `dosen_id`, `kode_mk`, `nama_mk`, `sks`, `created_at`, `updated_at`) VALUES
(1, 1, 'F4E2', 'Basis Data', 3, '2026-04-10 05:03:12', '2026-04-10 05:03:12'),
(2, 2, 'F4E3', 'Pemrograman Dasar', 3, '2026-04-10 11:23:14', '2026-04-10 11:23:14'),
(3, 3, 'F4E4', 'IoT', 3, '2026-04-10 11:23:34', '2026-04-10 11:23:34'),
(4, 5, 'F4E5', 'Big Data', 3, '2026-04-10 11:27:23', '2026-04-10 11:27:23'),
(5, 4, 'F4E6', 'Pemrograman Bergerak', 3, '2026-04-10 11:27:52', '2026-04-10 11:27:52'),
(6, 6, 'F4E7', 'Jaringan Komputer', 3, '2026-04-21 08:05:40', '2026-04-21 08:05:40'),
(7, 4, 'F4E9', 'Game Lanjut', 3, '2026-05-13 12:14:47', '2026-05-13 12:14:47'),
(8, 4, 'F4E8', 'Animasi 3D', 3, '2026-06-15 07:07:19', '2026-06-15 07:07:19');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2026_04_10_105122_create_kelas_table', 1),
(6, '2026_04_10_105127_create_mahasiswas_table', 1),
(7, '2026_04_10_105133_create_dosens_table', 1),
(8, '2026_04_10_105139_create_mata_kuliahs_table', 1),
(9, '2026_04_10_105145_create_face_data_table', 1),
(10, '2026_04_10_105151_create_absensis_table', 1),
(11, '2026_04_10_112733_create_face_logs_table', 2),
(12, '2026_04_10_112742_create_activity_logs_table', 2),
(13, '2026_04_10_112747_create_jadwal_kelas_table', 2),
(14, '2026_04_10_112753_add_face_verification_columns_to_absensi_table', 2),
(15, '2026_04_10_114224_create_attendance_sessions_table', 3),
(16, '2026_04_10_114246_add_attendance_session_id_to_absensi_table', 3),
(17, '2026_04_10_115759_add_ruang_kelas_to_kelas_table', 4),
(18, '2026_04_10_130000_create_mahasiswa_mata_kuliah_table', 5),
(19, '2026_04_10_150929_alter_status_enum_on_absensi_table', 6),
(20, '2026_04_21_120000_add_snapshot_path_to_absensi_table', 7),
(21, '2026_04_21_151806_add_host_ip_to_attendance_sessions_table', 7),
(22, '2026_04_25_000001_add_faceid_opened_at_to_attendance_sessions_table', 8),
(23, '2026_04_27_000001_add_confidence_index_to_absensi_table', 9);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('andhika123@gmail.com', '$2y$10$LqhJCpjw2eRkFwmk60sT0OKAqbvHU4NegsYThUcS.Cu11G2BKE.mu', '2026-05-13 10:50:36');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `role` enum('admin','dosen','mahasiswa') NOT NULL DEFAULT 'mahasiswa',
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `role`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin SIAKAD', 'admin@siakad.com', NULL, 'admin', '$2y$10$ZIy/pf47OoyLZ1wD/y49ze7aidwylcgOc/LUfy7dpp5xRu4I.pu5S', 'Qat2wnnLajVRJNryVyupexMBV8CLcGlpOkQExtaCcVmBtHQkTaFj5JQYKcU9', '2026-04-10 04:11:23', '2026-04-10 04:37:59'),
(2, 'Andhika Kurniawan', 'andhika123@gmail.com', NULL, 'mahasiswa', '$2y$10$o0L4fqvgV4O7OorVjCxJk.KI6Sfzj.ZA5Lr3G/RiDoXiDsEu.Gj7S', NULL, '2026-04-10 04:19:48', '2026-04-10 04:56:08'),
(3, 'ZIdan S.Kom, M.Kom', 'Zidan123@gmail.com', NULL, 'dosen', '$2y$10$/cklZET1ZfOS.aLwckwsCuDOrgl/qO4RMj8SyxpyvkbR.EZC5pxnq', NULL, '2026-04-10 04:38:27', '2026-04-10 08:56:17'),
(4, 'Pandu Arta S.Kom, M.Kom', 'Pandu123@gmail.com', NULL, 'dosen', '$2y$10$3.sM/UBql4o/XcYOmIfCQOVKqEwgLIzGSU41xxI1q0eQIIxMHk8bK', NULL, '2026-04-10 08:54:43', '2026-04-10 08:55:23'),
(5, 'Agus S.Kom, M.Kom', 'agus123@gmail.com', NULL, 'dosen', '$2y$10$L64ATn25NxolD1CHOhLzoOSti32F4C1N/B1S.m/52fG8.3k8ps1fW', NULL, '2026-04-10 08:58:20', '2026-04-10 08:58:20'),
(6, 'Krisna Halim', 'halim123@gmail.com', NULL, 'mahasiswa', '$2y$10$uFtoKk1wTBae7iiTbapzh.Q.WCL9UgvfCtEeFBBXE1ta9OEkQFurm', NULL, '2026-04-10 10:13:22', '2026-04-10 10:13:22'),
(7, 'Krisna Putra', 'putra123@gmail.com', NULL, 'mahasiswa', '$2y$10$fzZOW1azPc4Y/bFOGtJG0u03SmqVg4TC25yDpGa2g5pPl0x7BNapu', NULL, '2026-04-10 10:14:28', '2026-04-25 05:02:32'),
(8, 'Zami S.Kom, M.Kom', 'zami123@gmail.com', NULL, 'dosen', '$2y$10$nTXxHfY6hjpNbERBVgDV8OaSyiDGF3NE.DJVoPfqt9RpPI73.IUhe', NULL, '2026-04-10 11:25:26', '2026-04-10 11:25:26'),
(9, 'Gilang S.Kom, M.Kom', 'gilang123@gmail.com', NULL, 'dosen', '$2y$10$fm0BS7xK9qlKUtkfubhwaO9U5fQdRUmKOjurK4TiwR.fvmE3nOh4m', NULL, '2026-04-10 11:26:29', '2026-04-10 11:26:29'),
(10, 'Irvin', 'irvin123@gmail.com', NULL, 'mahasiswa', '$2y$10$6VE4i1U9.HYcR8g4tbH.7O4IVpWknF8jsowLy/Ojw84ipK0kTvbdK', NULL, '2026-04-12 22:26:29', '2026-04-12 22:27:26'),
(11, 'Ahmad Zam Zami', 'zami@gmail.com', NULL, 'mahasiswa', '$2y$10$aaXsUKiGsxZHJoI8z8/t9ueb4sFFmozIWSqUUs4WcevFlGj.gxkRC', NULL, '2026-04-20 22:54:38', '2026-04-20 22:54:38'),
(12, 'Febri Brilian Barkah', 'febri123@gmail.com', NULL, 'mahasiswa', '$2y$10$7w2V9Qqbl0UWazfkwP0eJekXgnPHxHV6TMMA8gSkCKXqY5vFMyYYe', NULL, '2026-04-20 23:02:49', '2026-04-20 23:02:49'),
(13, 'Wahyu S.Kom M.Kom', 'wahyu123@gmail.com', NULL, 'dosen', '$2y$10$TdIL8uo1Iq3QV/A5cQeJC.rAeeb1PPpSXVL5AtOnMUkTT3Y8oYROm', NULL, '2026-04-21 07:49:43', '2026-04-21 07:49:43'),
(15, 'Pandu Arta', 'pandu111@gmail.com', NULL, 'mahasiswa', '$2y$10$0KVRQRr2xLADIS1WZuuoY.F3AKBlp8N2AhCgD37FqujgxPrbqIO9a', NULL, '2026-04-27 09:57:12', '2026-04-27 09:57:12'),
(16, 'Zidan', 'Zidan@gmail.com', NULL, 'mahasiswa', '$2y$10$igG9pocbYoWTtLvJY5W/D.tnq8M.KtXSVmHBRTd/SIQZ2ouZaMrky', NULL, '2026-05-04 05:32:41', '2026-05-04 05:32:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_absensi_harian` (`mahasiswa_id`,`mata_kuliah_id`,`tanggal`),
  ADD KEY `absensi_mata_kuliah_id_foreign` (`mata_kuliah_id`),
  ADD KEY `absensi_verified_by_dosen_foreign` (`verified_by_dosen`),
  ADD KEY `absensi_attendance_session_id_foreign` (`attendance_session_id`),
  ADD KEY `idx_absensi_confidence` (`confidence`),
  ADD KEY `idx_absensi_metode_confidence` (`metode`,`confidence`);

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_logs_user_id_foreign` (`user_id`);

--
-- Indexes for table `attendance_sessions`
--
ALTER TABLE `attendance_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attendance_sessions_barcode_token_unique` (`barcode_token`),
  ADD KEY `attendance_sessions_dosen_id_foreign` (`dosen_id`),
  ADD KEY `attendance_sessions_kelas_id_foreign` (`kelas_id`),
  ADD KEY `attendance_sessions_mata_kuliah_id_foreign` (`mata_kuliah_id`);

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dosen_nidn_unique` (`nidn`),
  ADD KEY `dosen_user_id_foreign` (`user_id`);

--
-- Indexes for table `face_data`
--
ALTER TABLE `face_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `face_data_user_id_unique` (`user_id`);

--
-- Indexes for table `face_logs`
--
ALTER TABLE `face_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `face_logs_user_id_foreign` (`user_id`),
  ADD KEY `face_logs_absensi_id_foreign` (`absensi_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jadwal_kelas`
--
ALTER TABLE `jadwal_kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jadwal_kelas_kelas_id_foreign` (`kelas_id`),
  ADD KEY `jadwal_kelas_mata_kuliah_id_foreign` (`mata_kuliah_id`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mahasiswa_nim_unique` (`nim`),
  ADD KEY `mahasiswa_user_id_foreign` (`user_id`),
  ADD KEY `mahasiswa_kelas_id_foreign` (`kelas_id`);

--
-- Indexes for table `mahasiswa_mata_kuliah`
--
ALTER TABLE `mahasiswa_mata_kuliah`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_mhs_mk` (`mahasiswa_id`,`mata_kuliah_id`),
  ADD KEY `mahasiswa_mata_kuliah_mata_kuliah_id_foreign` (`mata_kuliah_id`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mata_kuliah_kode_mk_unique` (`kode_mk`),
  ADD KEY `mata_kuliah_dosen_id_foreign` (`dosen_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=379;

--
-- AUTO_INCREMENT for table `attendance_sessions`
--
ALTER TABLE `attendance_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `face_data`
--
ALTER TABLE `face_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `face_logs`
--
ALTER TABLE `face_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1238;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jadwal_kelas`
--
ALTER TABLE `jadwal_kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mahasiswa_mata_kuliah`
--
ALTER TABLE `mahasiswa_mata_kuliah`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_attendance_session_id_foreign` FOREIGN KEY (`attendance_session_id`) REFERENCES `attendance_sessions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `absensi_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswa` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `absensi_mata_kuliah_id_foreign` FOREIGN KEY (`mata_kuliah_id`) REFERENCES `mata_kuliah` (`id`),
  ADD CONSTRAINT `absensi_verified_by_dosen_foreign` FOREIGN KEY (`verified_by_dosen`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `attendance_sessions`
--
ALTER TABLE `attendance_sessions`
  ADD CONSTRAINT `attendance_sessions_dosen_id_foreign` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendance_sessions_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendance_sessions_mata_kuliah_id_foreign` FOREIGN KEY (`mata_kuliah_id`) REFERENCES `mata_kuliah` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `dosen_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `face_data`
--
ALTER TABLE `face_data`
  ADD CONSTRAINT `face_data_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `face_logs`
--
ALTER TABLE `face_logs`
  ADD CONSTRAINT `face_logs_absensi_id_foreign` FOREIGN KEY (`absensi_id`) REFERENCES `absensi` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `face_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jadwal_kelas`
--
ALTER TABLE `jadwal_kelas`
  ADD CONSTRAINT `jadwal_kelas_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwal_kelas_mata_kuliah_id_foreign` FOREIGN KEY (`mata_kuliah_id`) REFERENCES `mata_kuliah` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`),
  ADD CONSTRAINT `mahasiswa_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mahasiswa_mata_kuliah`
--
ALTER TABLE `mahasiswa_mata_kuliah`
  ADD CONSTRAINT `mahasiswa_mata_kuliah_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswa` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mahasiswa_mata_kuliah_mata_kuliah_id_foreign` FOREIGN KEY (`mata_kuliah_id`) REFERENCES `mata_kuliah` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD CONSTRAINT `mata_kuliah_dosen_id_foreign` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
