<?php
namespace Database\Seeders;

use App\Models\TravelRoute;
use Illuminate\Database\Seeder;

class TravelRouteSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $routes = [
            // Jakarta Routes
            [
                'from_city' => 'Jakarta',
                'to_city' => 'Bandung',
                'price' => 50000,
                'duration' => '3 jam',
                'bus_type' => 'executive',
                'departure_time' => '08:00',
                'arrival_time' => '11:00',
                'total_seats' => 40,
                'available_seats' => 15,
                'bus_operator' => 'Primajasa',
                'facilities' => ['AC', 'WiFi', 'Charging Port'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Jakarta',
                'to_city' => 'Bandung',
                'price' => 45000,
                'duration' => '3 jam',
                'bus_type' => 'economy',
                'departure_time' => '12:00',
                'arrival_time' => '15:00',
                'total_seats' => 50,
                'available_seats' => 25,
                'bus_operator' => 'Damri',
                'facilities' => ['AC'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Jakarta',
                'to_city' => 'Yogyakarta',
                'price' => 120000,
                'duration' => '8 jam',
                'bus_type' => 'luxury',
                'departure_time' => '21:00',
                'arrival_time' => '05:00',
                'total_seats' => 30,
                'available_seats' => 8,
                'bus_operator' => 'Pahala Kencana',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Jakarta',
                'to_city' => 'Yogyakarta',
                'price' => 100000,
                'duration' => '9 jam',
                'bus_type' => 'executive',
                'departure_time' => '19:00',
                'arrival_time' => '04:00',
                'total_seats' => 40,
                'available_seats' => 18,
                'bus_operator' => 'Rosalia Indah',
                'facilities' => ['AC', 'WiFi', 'Toilet'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Jakarta',
                'to_city' => 'Semarang',
                'price' => 85000,
                'duration' => '6 jam',
                'bus_type' => 'executive',
                'departure_time' => '07:00',
                'arrival_time' => '13:00',
                'total_seats' => 35,
                'available_seats' => 18,
                'bus_operator' => 'Harapan Jaya',
                'facilities' => ['AC', 'WiFi', 'Toilet'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Jakarta',
                'to_city' => 'Solo',
                'price' => 110000,
                'duration' => '7 jam',
                'bus_type' => 'executive',
                'departure_time' => '20:00',
                'arrival_time' => '03:00',
                'total_seats' => 40,
                'available_seats' => 14,
                'bus_operator' => 'Nusantara',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Jakarta',
                'to_city' => 'Surabaya',
                'price' => 180000,
                'duration' => '12 jam',
                'bus_type' => 'luxury',
                'departure_time' => '18:00',
                'arrival_time' => '06:00',
                'total_seats' => 28,
                'available_seats' => 6,
                'bus_operator' => 'Pahala Kencana',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],

            // Bandung Routes
            [
                'from_city' => 'Bandung',
                'to_city' => 'Jakarta',
                'price' => 55000,
                'duration' => '3.5 jam',
                'bus_type' => 'executive',
                'departure_time' => '15:00',
                'arrival_time' => '18:30',
                'total_seats' => 40,
                'available_seats' => 12,
                'bus_operator' => 'Primajasa',
                'facilities' => ['AC', 'WiFi', 'Charging Port'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Bandung',
                'to_city' => 'Jakarta',
                'price' => 48000,
                'duration' => '3.5 jam',
                'bus_type' => 'economy',
                'departure_time' => '09:00',
                'arrival_time' => '12:30',
                'total_seats' => 50,
                'available_seats' => 28,
                'bus_operator' => 'Damri',
                'facilities' => ['AC'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Bandung',
                'to_city' => 'Yogyakarta',
                'price' => 95000,
                'duration' => '6 jam',
                'bus_type' => 'executive',
                'departure_time' => '22:00',
                'arrival_time' => '04:00',
                'total_seats' => 40,
                'available_seats' => 16,
                'bus_operator' => 'Sumber Alam',
                'facilities' => ['AC', 'WiFi'],
                'status' => 'active'
            ],

            // Surabaya Routes
            [
                'from_city' => 'Surabaya',
                'to_city' => 'Malang',
                'price' => 35000,
                'duration' => '2 jam',
                'bus_type' => 'economy',
                'departure_time' => '14:00',
                'arrival_time' => '16:00',
                'total_seats' => 50,
                'available_seats' => 20,
                'bus_operator' => 'Gunung Harta',
                'facilities' => ['AC', 'Music'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Surabaya',
                'to_city' => 'Malang',
                'price' => 45000,
                'duration' => '2 jam',
                'bus_type' => 'executive',
                'departure_time' => '10:00',
                'arrival_time' => '12:00',
                'total_seats' => 40,
                'available_seats' => 15,
                'bus_operator' => 'Eka',
                'facilities' => ['AC', 'WiFi'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Surabaya',
                'to_city' => 'Yogyakarta',
                'price' => 75000,
                'duration' => '5 jam',
                'bus_type' => 'executive',
                'departure_time' => '08:00',
                'arrival_time' => '13:00',
                'total_seats' => 40,
                'available_seats' => 18,
                'bus_operator' => 'Rosalia Indah',
                'facilities' => ['AC', 'WiFi', 'Toilet'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Surabaya',
                'to_city' => 'Jakarta',
                'price' => 175000,
                'duration' => '12 jam',
                'bus_type' => 'luxury',
                'departure_time' => '19:00',
                'arrival_time' => '07:00',
                'total_seats' => 28,
                'available_seats' => 10,
                'bus_operator' => 'Pahala Kencana',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Surabaya',
                'to_city' => 'Bali',
                'price' => 150000,
                'duration' => '12 jam',
                'bus_type' => 'luxury',
                'departure_time' => '19:00',
                'arrival_time' => '07:00',
                'total_seats' => 28,
                'available_seats' => 5,
                'bus_operator' => 'Safari Dharma Raya',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],

            // Yogyakarta Routes
            [
                'from_city' => 'Yogyakarta',
                'to_city' => 'Solo',
                'price' => 25000,
                'duration' => '1.5 jam',
                'bus_type' => 'economy',
                'departure_time' => '10:00',
                'arrival_time' => '11:30',
                'total_seats' => 45,
                'available_seats' => 25,
                'bus_operator' => 'Sumber Alam',
                'facilities' => ['AC'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Yogyakarta',
                'to_city' => 'Solo',
                'price' => 35000,
                'duration' => '1.5 jam',
                'bus_type' => 'executive',
                'departure_time' => '16:00',
                'arrival_time' => '17:30',
                'total_seats' => 40,
                'available_seats' => 18,
                'bus_operator' => 'Trans Jogja',
                'facilities' => ['AC', 'WiFi'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Yogyakarta',
                'to_city' => 'Jakarta',
                'price' => 115000,
                'duration' => '8 jam',
                'bus_type' => 'executive',
                'departure_time' => '21:30',
                'arrival_time' => '05:30',
                'total_seats' => 40,
                'available_seats' => 20,
                'bus_operator' => 'Rosalia Indah',
                'facilities' => ['AC', 'WiFi', 'Toilet'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Yogyakarta',
                'to_city' => 'Semarang',
                'price' => 45000,
                'duration' => '2.5 jam',
                'bus_type' => 'executive',
                'departure_time' => '13:00',
                'arrival_time' => '15:30',
                'total_seats' => 40,
                'available_seats' => 22,
                'bus_operator' => 'Gunung Mulia',
                'facilities' => ['AC', 'WiFi'],
                'status' => 'active'
            ],

            // Solo Routes
            [
                'from_city' => 'Solo',
                'to_city' => 'Yogyakarta',
                'price' => 28000,
                'duration' => '1.5 jam',
                'bus_type' => 'economy',
                'departure_time' => '14:00',
                'arrival_time' => '15:30',
                'total_seats' => 45,
                'available_seats' => 30,
                'bus_operator' => 'Sumber Alam',
                'facilities' => ['AC'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Solo',
                'to_city' => 'Jakarta',
                'price' => 105000,
                'duration' => '7.5 jam',
                'bus_type' => 'executive',
                'departure_time' => '20:00',
                'arrival_time' => '03:30',
                'total_seats' => 40,
                'available_seats' => 16,
                'bus_operator' => 'Nusantara',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat'],
                'status' => 'active'
            ],

            // Semarang Routes
            [
                'from_city' => 'Semarang',
                'to_city' => 'Jakarta',
                'price' => 90000,
                'duration' => '6.5 jam',
                'bus_type' => 'executive',
                'departure_time' => '19:00',
                'arrival_time' => '01:30',
                'total_seats' => 40,
                'available_seats' => 24,
                'bus_operator' => 'Harapan Jaya',
                'facilities' => ['AC', 'WiFi', 'Toilet'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Semarang',
                'to_city' => 'Surabaya',
                'price' => 70000,
                'duration' => '4 jam',
                'bus_type' => 'executive',
                'departure_time' => '11:00',
                'arrival_time' => '15:00',
                'total_seats' => 40,
                'available_seats' => 19,
                'bus_operator' => 'Gunung Mulia',
                'facilities' => ['AC', 'WiFi'],
                'status' => 'active'
            ],

            // Malang Routes
            [
                'from_city' => 'Malang',
                'to_city' => 'Surabaya',
                'price' => 38000,
                'duration' => '2 jam',
                'bus_type' => 'economy',
                'departure_time' => '17:00',
                'arrival_time' => '19:00',
                'total_seats' => 50,
                'available_seats' => 26,
                'bus_operator' => 'Gunung Harta',
                'facilities' => ['AC', 'Music'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Malang',
                'to_city' => 'Jakarta',
                'price' => 165000,
                'duration' => '11 jam',
                'bus_type' => 'luxury',
                'departure_time' => '18:30',
                'arrival_time' => '05:30',
                'total_seats' => 28,
                'available_seats' => 12,
                'bus_operator' => 'Pahala Kencana',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],

            // Bali Routes
            [
                'from_city' => 'Bali',
                'to_city' => 'Surabaya',
                'price' => 145000,
                'duration' => '12 jam',
                'bus_type' => 'luxury',
                'departure_time' => '19:00',
                'arrival_time' => '07:00',
                'total_seats' => 28,
                'available_seats' => 6,
                'bus_operator' => 'Safari Dharma Raya',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Bali',
                'to_city' => 'Yogyakarta',
                'price' => 200000,
                'duration' => '16 jam',
                'bus_type' => 'luxury',
                'departure_time' => '17:00',
                'arrival_time' => '09:00',
                'total_seats' => 28,
                'available_seats' => 4,
                'bus_operator' => 'Safari Dharma Raya',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],

            // Medan Routes
            [
                'from_city' => 'Medan',
                'to_city' => 'Palembang',
                'price' => 280000,
                'duration' => '18 jam',
                'bus_type' => 'luxury',
                'departure_time' => '15:00',
                'arrival_time' => '09:00',
                'total_seats' => 28,
                'available_seats' => 8,
                'bus_operator' => 'Antar Lintas Sumatra',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],

            // Palembang Routes
            [
                'from_city' => 'Palembang',
                'to_city' => 'Jakarta',
                'price' => 220000,
                'duration' => '14 jam',
                'bus_type' => 'luxury',
                'departure_time' => '16:00',
                'arrival_time' => '06:00',
                'total_seats' => 28,
                'available_seats' => 10,
                'bus_operator' => 'DAMRI Sumatra',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],
            [
                'from_city' => 'Palembang',
                'to_city' => 'Medan',
                'price' => 275000,
                'duration' => '18 jam',
                'bus_type' => 'luxury',
                'departure_time' => '14:00',
                'arrival_time' => '08:00',
                'total_seats' => 28,
                'available_seats' => 5,
                'bus_operator' => 'Antar Lintas Sumatra',
                'facilities' => ['AC', 'WiFi', 'Reclining Seat', 'Meal', 'Toilet'],
                'status' => 'active'
            ],
        ];

        foreach ($routes as $route) {
            TravelRoute::create($route);
        }
    }
}