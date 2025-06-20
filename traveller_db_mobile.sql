-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2025 at 11:02 AM
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
-- Database: `traveller_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `booking_code` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `travel_route_id` bigint(20) UNSIGNED NOT NULL,
  `travel_date` date NOT NULL,
  `passenger_count` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending_payment','confirmed','cancelled','completed') DEFAULT 'pending_payment',
  `passenger_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`passenger_details`)),
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `booking_code`, `user_id`, `travel_route_id`, `travel_date`, `passenger_count`, `total_price`, `status`, `passenger_details`, `booking_date`, `created_at`, `updated_at`) VALUES
(1, 'TRVOKFMGK', 1, 25, '2025-06-21', 1, 165000.00, 'cancelled', '[{\"name\":\"yasir\",\"id_number\":\"23123123\",\"phone\":\"14124\",\"seat_number\":\"A1\"}]', '2025-06-19 23:07:01', '2025-06-19 15:46:10', '2025-06-19 16:07:01'),
(2, 'TRVB6DDRO', 1, 9, '2025-06-21', 1, 48000.00, 'confirmed', '[{\"name\":\"asu\",\"id_number\":\"123\",\"phone\":\"123\",\"seat_number\":\"A1\"}]', '2025-06-19 23:08:15', '2025-06-19 16:07:31', '2025-06-19 16:07:31'),
(3, 'TRVIINZDV', 1, 5, '2025-06-21', 1, 85000.00, 'pending_payment', '[{\"name\":\"sadfdf\",\"id_number\":\"315513\",\"phone\":\"341143\",\"seat_number\":\"A1\"}]', '2025-06-19 20:42:49', '2025-06-19 20:42:49', '2025-06-19 20:42:49'),
(4, 'TRVG333HI', 1, 8, '2025-06-21', 1, 55000.00, 'confirmed', '[{\"name\":\"asdas\",\"id_number\":\"4123124\",\"phone\":\"42141\",\"seat_number\":\"A1\"}]', '2025-06-20 05:56:58', '2025-06-19 21:49:25', '2025-06-19 21:49:25'),
(5, 'TRV9KQXJG', 3, 26, '2025-06-21', 2, 290000.00, 'pending_payment', '[{\"name\":\"sadasd\",\"id_number\":\"31241243\",\"phone\":\"342341\",\"seat_number\":\"A1\"},{\"name\":\"asdas\",\"id_number\":\"34125135\",\"phone\":\"352235\",\"seat_number\":\"A2\"}]', '2025-06-19 21:51:32', '2025-06-19 21:51:32', '2025-06-19 21:51:32'),
(6, 'TRV6QFNUN', 4, 8, '2025-06-20', 1, 55000.00, 'cancelled', '[{\"name\":\"Yasir\",\"id_number\":\"313131\",\"phone\":\"313131\",\"seat_number\":\"A1\"}]', '2025-06-20 07:47:58', '2025-06-20 00:45:54', '2025-06-20 00:47:58'),
(7, 'TRVDPQ8XN', 4, 8, '2025-06-21', 2, 110000.00, 'pending_payment', '[{\"name\":\"sidjfisdjf\",\"id_number\":\"32525\",\"phone\":\"42525\",\"seat_number\":\"A1\"},{\"name\":\"asep\",\"id_number\":\"245424\",\"phone\":\"2424242\",\"seat_number\":\"A2\"}]', '2025-06-20 00:49:45', '2025-06-20 00:49:45', '2025-06-20 00:49:45');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel_cache_a3affa0d1e1a3c72b78aa984c3367a05', 'i:4;', 1750405907),
('laravel_cache_a3affa0d1e1a3c72b78aa984c3367a05:timer', 'i:1750405907;', 1750405907),
('laravel_cache_a75f3f172bfb296f2e10cbfc6dfc1883', 'i:1;', 1750405859),
('laravel_cache_a75f3f172bfb296f2e10cbfc6dfc1883:timer', 'i:1750405859;', 1750405859),
('laravel_cache_d2bfa8e8b749d2772a21edee7b70a2b3', 'i:9;', 1750395114),
('laravel_cache_d2bfa8e8b749d2772a21edee7b70a2b3:timer', 'i:1750395114;', 1750395114),
('laravel_cache_f1f70ec40aaa556905d4a030501c0ba4', 'i:5;', 1750399711),
('laravel_cache_f1f70ec40aaa556905d4a030501c0ba4:timer', 'i:1750399711;', 1750399711);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(19, '0001_01_01_000000_create_users_table', 1),
(20, '0001_01_01_000001_create_cache_table', 1),
(21, '0001_01_01_000002_create_jobs_table', 1),
(22, '2025_06_19_125751_create_personal_access_tokens_table', 1),
(23, '2025_06_19_130101_create_travel_routes_table', 1),
(24, '2025_06_19_130102_create_bookings_table', 1),
(25, '2025_06_19_221903_update_booking_status_enum', 1),
(26, '2025_06_20_055234_enhance_seat_management', 2);

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
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', 'b9333a9c1c648e514630bd8c1bf602ffc332760e87a2673bd0a37e8dcd0c2283', '[\"*\"]', NULL, NULL, '2025-06-19 15:41:25', '2025-06-19 15:41:25'),
(2, 'App\\Models\\User', 1, 'auth_token', '5cddc2845baf15a9d2c6ae82bd5822a166a707d818b820766bd9025cd5e82d31', '[\"*\"]', '2025-06-19 15:41:38', NULL, '2025-06-19 15:41:35', '2025-06-19 15:41:38'),
(3, 'App\\Models\\User', 1, 'auth_token', '2801908652b77a23a756abb575a69bbbfaecd860d6769d9b55f767ff9e176863', '[\"*\"]', '2025-06-19 15:46:38', NULL, '2025-06-19 15:45:24', '2025-06-19 15:46:38'),
(4, 'App\\Models\\User', 1, 'auth_token', '50d9c8f16cb655d83fc9d3f12505f0c0b21e2525c5e2f5803eb08e1d0e3d945e', '[\"*\"]', '2025-06-19 16:08:21', NULL, '2025-06-19 16:06:55', '2025-06-19 16:08:21'),
(5, 'App\\Models\\User', 1, 'auth_token', '7771c4a9d5cc0294f1538b6538e3c0bbabb7677ef63158f3694285bdd65b3c56', '[\"*\"]', NULL, NULL, '2025-06-19 20:37:00', '2025-06-19 20:37:00'),
(6, 'App\\Models\\User', 1, 'auth_token', 'bdab47810ae7fadbe21c5ddc13222c1dcc4a2c2169e1a7bc5ab8ed7b3cfedd87', '[\"*\"]', '2025-06-19 20:43:18', NULL, '2025-06-19 20:42:20', '2025-06-19 20:43:18'),
(7, 'App\\Models\\User', 1, 'auth_token', '7f269aa7f4298d7e71055a89cce50f8329f3252058a5764642c1e1467e8ed244', '[\"*\"]', '2025-06-19 20:45:58', NULL, '2025-06-19 20:45:58', '2025-06-19 20:45:58'),
(8, 'App\\Models\\User', 1, 'auth_token', 'c33ec4e4715c71d9f219b9f9bb9159ded05eae9ece27c28134feef5a5a692d7c', '[\"*\"]', '2025-06-19 20:48:58', NULL, '2025-06-19 20:48:58', '2025-06-19 20:48:58'),
(9, 'App\\Models\\User', 1, 'auth_token', 'add951c1986676e0919ef85b34c217e3e8750514731caa3c11e5f43918af460b', '[\"*\"]', '2025-06-19 20:51:43', NULL, '2025-06-19 20:51:43', '2025-06-19 20:51:43'),
(10, 'App\\Models\\User', 1, 'auth_token', 'f2379b051939618f7ea671ebf63ef43c689d477ecdbae558db96e410bbb7bf3d', '[\"*\"]', '2025-06-19 20:53:37', NULL, '2025-06-19 20:53:36', '2025-06-19 20:53:37'),
(11, 'App\\Models\\User', 1, 'auth_token', '9f735c95add92bbed4eae5c2b31fa10a554a095556171ded8a0067625a7c75e5', '[\"*\"]', '2025-06-19 20:55:56', NULL, '2025-06-19 20:55:55', '2025-06-19 20:55:56'),
(12, 'App\\Models\\User', 1, 'auth_token', '5f117fefdc73373ec1c4c6ec6382e3a9be9f75df1ac28f8becc94e4afa29268f', '[\"*\"]', '2025-06-19 20:58:17', NULL, '2025-06-19 20:57:57', '2025-06-19 20:58:17'),
(13, 'App\\Models\\User', 1, 'auth_token', 'b499db25d74862a7e2eedc586f580cc1f3be041246a50852da0a38a0ce8e13dd', '[\"*\"]', '2025-06-19 21:01:06', NULL, '2025-06-19 20:59:34', '2025-06-19 21:01:06'),
(14, 'App\\Models\\User', 1, 'auth_token', 'b9ea4cbc27ff4e42d313cb51583a2ae29a7b1a9fc29498d925c5025cba61ade7', '[\"*\"]', '2025-06-19 21:02:29', NULL, '2025-06-19 21:01:41', '2025-06-19 21:02:29'),
(15, 'App\\Models\\User', 2, 'auth_token', '28663d26e58b4790bf19a40c94ba2c24b345da88ed361e93d3122875f180a685', '[\"*\"]', NULL, NULL, '2025-06-19 21:17:04', '2025-06-19 21:17:04'),
(16, 'App\\Models\\User', 1, 'auth_token', 'b0af9af362459204ddd5a2cc375880e60fcc170e846949fca41a79c33fe704cc', '[\"*\"]', '2025-06-19 21:19:42', NULL, '2025-06-19 21:17:15', '2025-06-19 21:19:42'),
(17, 'App\\Models\\User', 1, 'auth_token', '00e3abb3ca809e1248aaf26c3bee224275b577136e69648a09733e4ffef212d1', '[\"*\"]', '2025-06-19 21:21:50', NULL, '2025-06-19 21:21:49', '2025-06-19 21:21:50'),
(18, 'App\\Models\\User', 1, 'auth_token', '8d318de50f3c5bb9195c14924eda6e6a2514ecc88747f86617419ca7226b7d19', '[\"*\"]', '2025-06-19 21:36:18', NULL, '2025-06-19 21:36:17', '2025-06-19 21:36:18'),
(19, 'App\\Models\\User', 1, 'auth_token', 'ebeed8e214dbff170addd54468daa2a2124358a3045417d13dde186b63b9b979', '[\"*\"]', '2025-06-19 21:46:11', NULL, '2025-06-19 21:46:03', '2025-06-19 21:46:11'),
(20, 'App\\Models\\User', 1, 'auth_token', 'f79ea89f1c81a57d41f9cac348178f592f8d48b9037a7e5da0848623ba1c6320', '[\"*\"]', '2025-06-19 21:49:25', NULL, '2025-06-19 21:47:02', '2025-06-19 21:49:25'),
(21, 'App\\Models\\User', 3, 'auth_token', '66f8e1cb7a0fb872e9b14a39e89270f93f8f48a7129a728b60054d7ff8d8f60f', '[\"*\"]', NULL, NULL, '2025-06-19 21:50:46', '2025-06-19 21:50:46'),
(22, 'App\\Models\\User', 3, 'auth_token', 'fc02cccd7fcda25d39695c0411111e1bed05938642c8f3686b1980e5cc96cb52', '[\"*\"]', '2025-06-19 21:51:32', NULL, '2025-06-19 21:50:54', '2025-06-19 21:51:32'),
(23, 'App\\Models\\User', 1, 'auth_token', 'e9c7bbb2e95cd5c9ea24b28187db4d3293dac000d8f9d613b8bd24d433767465', '[\"*\"]', '2025-06-19 22:36:52', NULL, '2025-06-19 22:36:52', '2025-06-19 22:36:52'),
(24, 'App\\Models\\User', 1, 'auth_token', 'e23ccef4596e3e45c3e822497f357b1bfa775c8afb4ba91a5d24ea13ae3accdd', '[\"*\"]', '2025-06-19 22:38:58', NULL, '2025-06-19 22:38:30', '2025-06-19 22:38:58'),
(25, 'App\\Models\\User', 1, 'auth_token', 'a26acb88d2ef66b79e5aa13b55cdb420d2a4de1a7236a4561d38c38dbd468136', '[\"*\"]', '2025-06-19 22:41:18', NULL, '2025-06-19 22:41:18', '2025-06-19 22:41:18'),
(26, 'App\\Models\\User', 1, 'auth_token', '8a409201e79879fbd4db5d5278e9d998a6c9c0cb4bad5f9f8b5fc9ce8e215914', '[\"*\"]', '2025-06-19 22:41:53', NULL, '2025-06-19 22:41:52', '2025-06-19 22:41:53'),
(27, 'App\\Models\\User', 1, 'auth_token', 'f9b69045495df6232faffd7c2b02cf5bea05b631331a20b04fb03aaa52815380', '[\"*\"]', '2025-06-19 22:43:12', NULL, '2025-06-19 22:42:07', '2025-06-19 22:43:12'),
(28, 'App\\Models\\User', 1, 'auth_token', '9800e6bd18067c800657b46e70f6b4958a58ef22c18de9b6be5d7f924772aeec', '[\"*\"]', '2025-06-19 22:55:45', NULL, '2025-06-19 22:55:31', '2025-06-19 22:55:45'),
(29, 'App\\Models\\User', 1, 'auth_token', '70e3836d5005bcefbecfbd503b7451d82136e5fef4ecffa52c23403568dca70d', '[\"*\"]', '2025-06-19 23:01:59', NULL, '2025-06-19 23:00:30', '2025-06-19 23:01:59'),
(30, 'App\\Models\\User', 1, 'auth_token', 'ff7495ce1c4ab16a66d2e0b24717559ac427ba03f34154ef0b76bd220f91d396', '[\"*\"]', '2025-06-19 23:04:41', NULL, '2025-06-19 23:02:33', '2025-06-19 23:04:41'),
(32, 'App\\Models\\User', 1, 'auth_token', '9dc163612d85099a38a649cd3e43587dd9cec030f055a2be9ad8344b4dce4279', '[\"*\"]', '2025-06-19 23:07:36', NULL, '2025-06-19 23:06:11', '2025-06-19 23:07:36'),
(33, 'App\\Models\\User', 4, 'auth_token', 'aee000e862209bb1064dd6719a6d59cde6c4080e3cc19bb6d94e332746f0d435', '[\"*\"]', NULL, NULL, '2025-06-20 00:44:12', '2025-06-20 00:44:12');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `travel_routes`
--

CREATE TABLE `travel_routes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from_city` varchar(255) NOT NULL,
  `to_city` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration` varchar(255) NOT NULL,
  `bus_type` enum('economy','executive','luxury') NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `total_seats` int(11) NOT NULL,
  `available_seats` int(11) NOT NULL,
  `bus_operator` varchar(255) DEFAULT NULL,
  `facilities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`facilities`)),
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `travel_routes`
--

INSERT INTO `travel_routes` (`id`, `from_city`, `to_city`, `price`, `duration`, `bus_type`, `departure_time`, `arrival_time`, `total_seats`, `available_seats`, `bus_operator`, `facilities`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Jakarta', 'Bandung', 50000.00, '3 jam', 'executive', '08:00:00', '11:00:00', 40, 15, 'Primajasa', '[\"AC\",\"WiFi\",\"Charging Port\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(2, 'Jakarta', 'Bandung', 45000.00, '3 jam', 'economy', '12:00:00', '15:00:00', 50, 25, 'Damri', '[\"AC\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(3, 'Jakarta', 'Yogyakarta', 120000.00, '8 jam', 'luxury', '21:00:00', '05:00:00', 30, 8, 'Pahala Kencana', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(4, 'Jakarta', 'Yogyakarta', 100000.00, '9 jam', 'executive', '19:00:00', '04:00:00', 40, 18, 'Rosalia Indah', '[\"AC\",\"WiFi\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(5, 'Jakarta', 'Semarang', 85000.00, '6 jam', 'executive', '07:00:00', '13:00:00', 35, 18, 'Harapan Jaya', '[\"AC\",\"WiFi\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(6, 'Jakarta', 'Solo', 110000.00, '7 jam', 'executive', '20:00:00', '03:00:00', 40, 14, 'Nusantara', '[\"AC\",\"WiFi\",\"Reclining Seat\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(7, 'Jakarta', 'Surabaya', 180000.00, '12 jam', 'luxury', '18:00:00', '06:00:00', 28, 6, 'Pahala Kencana', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(8, 'Bandung', 'Jakarta', 55000.00, '3.5 jam', 'executive', '15:00:00', '18:30:00', 40, 13, 'Primajasa', '[\"AC\",\"WiFi\",\"Charging Port\"]', 'active', '2025-06-19 15:39:17', '2025-06-20 00:47:58'),
(9, 'Bandung', 'Jakarta', 48000.00, '3.5 jam', 'economy', '09:00:00', '12:30:00', 50, 28, 'Damri', '[\"AC\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(10, 'Bandung', 'Yogyakarta', 95000.00, '6 jam', 'executive', '22:00:00', '04:00:00', 40, 16, 'Sumber Alam', '[\"AC\",\"WiFi\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(11, 'Surabaya', 'Malang', 35000.00, '2 jam', 'economy', '14:00:00', '16:00:00', 50, 20, 'Gunung Harta', '[\"AC\",\"Music\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(12, 'Surabaya', 'Malang', 45000.00, '2 jam', 'executive', '10:00:00', '12:00:00', 40, 15, 'Eka', '[\"AC\",\"WiFi\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(13, 'Surabaya', 'Yogyakarta', 75000.00, '5 jam', 'executive', '08:00:00', '13:00:00', 40, 18, 'Rosalia Indah', '[\"AC\",\"WiFi\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(14, 'Surabaya', 'Jakarta', 175000.00, '12 jam', 'luxury', '19:00:00', '07:00:00', 28, 10, 'Pahala Kencana', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(15, 'Surabaya', 'Bali', 150000.00, '12 jam', 'luxury', '19:00:00', '07:00:00', 28, 5, 'Safari Dharma Raya', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(16, 'Yogyakarta', 'Solo', 25000.00, '1.5 jam', 'economy', '10:00:00', '11:30:00', 45, 25, 'Sumber Alam', '[\"AC\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(17, 'Yogyakarta', 'Solo', 35000.00, '1.5 jam', 'executive', '16:00:00', '17:30:00', 40, 18, 'Trans Jogja', '[\"AC\",\"WiFi\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(18, 'Yogyakarta', 'Jakarta', 115000.00, '8 jam', 'executive', '21:30:00', '05:30:00', 40, 20, 'Rosalia Indah', '[\"AC\",\"WiFi\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(19, 'Yogyakarta', 'Semarang', 45000.00, '2.5 jam', 'executive', '13:00:00', '15:30:00', 40, 22, 'Gunung Mulia', '[\"AC\",\"WiFi\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(20, 'Solo', 'Yogyakarta', 28000.00, '1.5 jam', 'economy', '14:00:00', '15:30:00', 45, 30, 'Sumber Alam', '[\"AC\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(21, 'Solo', 'Jakarta', 105000.00, '7.5 jam', 'executive', '20:00:00', '03:30:00', 40, 16, 'Nusantara', '[\"AC\",\"WiFi\",\"Reclining Seat\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(22, 'Semarang', 'Jakarta', 90000.00, '6.5 jam', 'executive', '19:00:00', '01:30:00', 40, 24, 'Harapan Jaya', '[\"AC\",\"WiFi\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(23, 'Semarang', 'Surabaya', 70000.00, '4 jam', 'executive', '11:00:00', '15:00:00', 40, 19, 'Gunung Mulia', '[\"AC\",\"WiFi\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(24, 'Malang', 'Surabaya', 38000.00, '2 jam', 'economy', '17:00:00', '19:00:00', 50, 26, 'Gunung Harta', '[\"AC\",\"Music\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(25, 'Malang', 'Jakarta', 165000.00, '11 jam', 'luxury', '18:30:00', '05:30:00', 28, 12, 'Pahala Kencana', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(26, 'Bali', 'Surabaya', 145000.00, '12 jam', 'luxury', '19:00:00', '07:00:00', 28, 6, 'Safari Dharma Raya', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(27, 'Bali', 'Yogyakarta', 200000.00, '16 jam', 'luxury', '17:00:00', '09:00:00', 28, 4, 'Safari Dharma Raya', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(28, 'Medan', 'Palembang', 280000.00, '18 jam', 'luxury', '15:00:00', '09:00:00', 28, 8, 'Antar Lintas Sumatra', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(29, 'Palembang', 'Jakarta', 220000.00, '14 jam', 'luxury', '16:00:00', '06:00:00', 28, 10, 'DAMRI Sumatra', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17'),
(30, 'Palembang', 'Medan', 275000.00, '18 jam', 'luxury', '14:00:00', '08:00:00', 28, 5, 'Antar Lintas Sumatra', '[\"AC\",\"WiFi\",\"Reclining Seat\",\"Meal\",\"Toilet\"]', 'active', '2025-06-19 15:39:17', '2025-06-19 15:39:17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `email_verified_at`, `password`, `profile_picture`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Haziem', 'a@a.com', '08521877651278', NULL, '$2y$12$GCG6Bqa5K75vjWVOl9jD6.ISTjwTj6aizOEBR7z6PSwu61YIdJCta', NULL, 'active', NULL, '2025-06-19 15:41:25', '2025-06-19 22:38:46'),
(2, '3sdadas', 'sdadas@gg.com', '1241244124123', NULL, '$2y$12$S/Ei6pS35GSKlRJEKBH57OogDg/vzA.Z8rMqFNDkemDyqj31UIf4i', NULL, 'active', NULL, '2025-06-19 21:17:04', '2025-06-19 21:17:04'),
(3, 'kanjut', 'a@b.com', '1253252345235', NULL, '$2y$12$qo1puUBjmN9epoHD/BRYSunLKTzpOMVcUPwnjHZmpM9MmcSqMZhK.', NULL, 'active', NULL, '2025-06-19 21:50:46', '2025-06-19 21:50:46'),
(4, 'haziemnbw', 'haziem@h.com', '099999', NULL, '$2y$12$q97H360.BofeyDcKWlyyiuv4TJ3ngRncfoJ.ZmhQe2SyLe1sVlo1a', NULL, 'active', NULL, '2025-06-20 00:44:12', '2025-06-20 00:50:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bookings_booking_code_unique` (`booking_code`),
  ADD KEY `bookings_user_id_foreign` (`user_id`),
  ADD KEY `bookings_travel_route_id_foreign` (`travel_route_id`),
  ADD KEY `idx_status_travel_date` (`status`,`travel_date`),
  ADD KEY `idx_travel_date_status` (`travel_date`,`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `travel_routes`
--
ALTER TABLE `travel_routes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status_available_seats` (`status`,`available_seats`),
  ADD KEY `idx_route_search` (`from_city`,`to_city`,`status`);

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
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `travel_routes`
--
ALTER TABLE `travel_routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_travel_route_id_foreign` FOREIGN KEY (`travel_route_id`) REFERENCES `travel_routes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
