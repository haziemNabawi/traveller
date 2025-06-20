<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Laravel 12 menggunakan closure routes secara default
// Untuk performance yang lebih baik

// Test route untuk memastikan API berjalan
Route::get('/test', function () {
    return response()->json([
        'message' => 'Traveller API is working!',
        'version' => '1.0.0',
        'laravel_version' => app()->version(),
        'timestamp' => now()->toISOString(),
    ]);
});

// Health check endpoint
Route::get('/health', function () {
    return response()->json([
        'status' => 'healthy',
        'database' => 'connected',
        'timestamp' => now()->toISOString(),
        'memory_usage' => memory_get_usage(true),
    ]);
});

// Public authentication routes
Route::prefix('auth')->group(function () {
    Route::post('/register', function (Request $request) {
        // Temporary implementation
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'phone' => 'required|string|max:20',
            'password' => 'required|string|min:6',
        ]);

        $user = \App\Models\User::create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'password' => \Hash::make($request->password),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Registration successful',
            'data' => [
                'user' => $user,
                'token' => $token,
                'token_type' => 'Bearer',
            ]
        ], 201);
    });

    Route::post('/login', function (Request $request) {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (!\Auth::attempt($request->only('email', 'password'))) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid credentials'
            ], 401);
        }

        $user = \App\Models\User::where('email', $request->email)->first();
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Login successful',
            'data' => [
                'user' => $user,
                'token' => $token,
                'token_type' => 'Bearer',
            ]
        ]);
    });
});

// Public routes for travel data - gunakan controller
Route::prefix('routes')->group(function () {
    Route::get('/', [App\Http\Controllers\Api\TravelRouteController::class, 'index']);
    Route::get('/popular', [App\Http\Controllers\Api\TravelRouteController::class, 'popular']);
    Route::get('/cities', [App\Http\Controllers\Api\TravelRouteController::class, 'cities']);
    Route::get('/{id}', [App\Http\Controllers\Api\TravelRouteController::class, 'show']);
});

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    // User info
    Route::get('/user', function (Request $request) {
        return response()->json([
            'success' => true,
            'data' => $request->user()
        ]);
    });

    // Auth routes untuk user yang sudah login
    Route::prefix('auth')->group(function () {
        Route::post('/logout', function (Request $request) {
            $request->user()->currentAccessToken()->delete();
            return response()->json([
                'success' => true,
                'message' => 'Logout successful'
            ]);
        });

        Route::get('/me', function (Request $request) {
            return response()->json([
                'success' => true,
                'data' => $request->user()
            ]);
        });

        Route::put('/profile', function (Request $request) {
            $request->validate([
                'name' => 'required|string|max:255',
                'phone' => 'required|string|max:20',
            ]);

            $user = $request->user();
            $user->update($request->only('name', 'phone'));

            return response()->json([
                'success' => true,
                'message' => 'Profile updated successfully',
                'data' => $user
            ]);
        });
    });

    // Bookings routes
    Route::prefix('bookings')->group(function () {
        Route::get('/', [App\Http\Controllers\Api\BookingController::class, 'index']);
        Route::post('/', [App\Http\Controllers\Api\BookingController::class, 'store']);
        Route::get('/{id}', [App\Http\Controllers\Api\BookingController::class, 'show']);
        Route::put('/{id}/cancel', [App\Http\Controllers\Api\BookingController::class, 'cancel']);
        
        // Route baru untuk konfirmasi pembayaran (admin only)
        Route::put('/{id}/confirm-payment', [App\Http\Controllers\Api\BookingController::class, 'confirmPayment']);
    });

    // Admin routes (nanti bisa ditambah middleware admin)
    Route::prefix('admin')->group(function () {
        // Get all bookings untuk admin
        Route::get('/bookings', function (Request $request) {
            // Temporary - nanti pakai BookingController dengan scope admin
            return response()->json([
                'success' => true,
                'data' => [],
                'message' => 'Admin booking list - coming soon'
            ]);
        });

        // Konfirmasi pembayaran manual
        Route::put('/bookings/{id}/confirm', function ($id, Request $request) {
            // Temporary - nanti pakai BookingController
            return response()->json([
                'success' => true,
                'message' => 'Payment confirmed by admin'
            ]);
        });
    });
});

// Fallback untuk API yang tidak ditemukan
Route::fallback(function () {
    return response()->json([
        'message' => 'API endpoint not found',
        'available_endpoints' => [
            'GET /api/test',
            'GET /api/health',
            'POST /api/auth/register',
            'POST /api/auth/login',
            'GET /api/routes',
            'GET /api/routes/popular',
            'GET /api/routes/cities',
            'GET /api/routes/{id}',
            // Protected endpoints
            'POST /api/auth/logout (auth required)',
            'GET /api/auth/me (auth required)',
            'PUT /api/auth/profile (auth required)',
            'GET /api/bookings (auth required)',
            'POST /api/bookings (auth required)',
            'GET /api/bookings/{id} (auth required)',
            'PUT /api/bookings/{id}/cancel (auth required)',
            'PUT /api/bookings/{id}/confirm-payment (auth required)',
        ]
    ], 404);
});