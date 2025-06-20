<?php
// app/Http/Controllers/Api/TravelRouteController.php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\TravelRoute;
use Illuminate\Http\Request;

class TravelRouteController extends Controller
{
    public function index(Request $request)
    {
        // Debug logs
        \Log::info('TravelRoute search request', [
            'from' => $request->get('from'),
            'to' => $request->get('to'),
            'bus_type' => $request->get('bus_type'),
            'available_only' => $request->boolean('available_only', true)
        ]);

        try {
            $query = TravelRoute::query();

            // Filter by route - EXACT MATCH untuk city names
            if ($request->filled('from') && $request->filled('to')) {
                $from = $request->get('from');
                $to = $request->get('to');
                
                \Log::info('Filtering routes', [
                    'from_city' => $from,
                    'to_city' => $to
                ]);
                
                // EXACT match instead of LIKE to fix search issue
                $query->where('from_city', $from)
                      ->where('to_city', $to);
            }

            // Filter by bus type
            if ($request->filled('bus_type')) {
                $query->where('bus_type', $request->get('bus_type'));
            }

            // Only available routes
            if ($request->boolean('available_only', true)) {
                $query->available();
            }

            $routes = $query->orderBy('departure_time')->get();
            
            \Log::info('Found routes', [
                'count' => $routes->count(),
                'routes' => $routes->pluck('id', 'from_city')->toArray()
            ]);

            // Convert to array dan pastikan data types benar
            $routesArray = $routes->map(function ($route) {
                return [
                    'id' => (int) $route->id,
                    'from_city' => (string) $route->from_city,
                    'to_city' => (string) $route->to_city,
                    'price' => (int) $route->price,  // Pastikan integer
                    'duration' => (string) $route->duration,
                    'bus_type' => (string) $route->bus_type,
                    'departure_time' => (string) $route->departure_time,
                    'arrival_time' => (string) $route->arrival_time,
                    'available_seats' => (int) $route->available_seats,  // Pastikan integer
                    'total_seats' => (int) $route->total_seats,
                    'bus_operator' => (string) $route->bus_operator,
                    'facilities' => $route->facilities ?: [],
                    'status' => (string) $route->status,
                ];
            })->toArray();

            return response()->json([
                'success' => true,
                'data' => $routesArray,
                'debug' => [
                    'query_params' => $request->all(),
                    'total_found' => count($routesArray),
                    'sample_route' => count($routesArray) > 0 ? $routesArray[0] : null
                ]
            ]);

        } catch (\Exception $e) {
            \Log::error('Error in TravelRoute index', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error fetching routes: ' . $e->getMessage(),
                'data' => []
            ], 500);
        }
    }

    public function show($id)
    {
        $route = TravelRoute::find($id);

        if (!$route) {
            return response()->json([
                'success' => false,
                'message' => 'Route not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $route
        ]);
    }

    public function popular()
    {
        // Get popular routes based on booking count
        $routes = TravelRoute::withCount('bookings')
            ->available()
            ->orderBy('bookings_count', 'desc')
            ->limit(10)
            ->get();

        return response()->json([
            'success' => true,
            'data' => $routes
        ]);
    }

    public function cities()
    {
        // Get unique cities from database instead of hardcoded
        $fromCities = TravelRoute::distinct()->pluck('from_city');
        $toCities = TravelRoute::distinct()->pluck('to_city');
        $cities = $fromCities->merge($toCities)->unique()->sort()->values();

        return response()->json([
            'success' => true,
            'data' => $cities
        ]);
    }
}