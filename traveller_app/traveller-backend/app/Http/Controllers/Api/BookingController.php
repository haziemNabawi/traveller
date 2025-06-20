<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\TravelRoute;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class BookingController extends Controller
{
    public function index(Request $request)
    {
        try {
            \Log::info('Getting bookings for user', ['user_id' => $request->user()->id]);
            
            $bookings = Booking::with('travelRoute')
                ->byUser($request->user()->id)
                ->orderBy('created_at', 'desc')
                ->get();

            \Log::info('Found bookings', ['count' => $bookings->count()]);

            return response()->json([
                'success' => true,
                'data' => $bookings,
                'message' => 'Bookings retrieved successfully'
            ]);
        } catch (\Exception $e) {
            \Log::error('Error getting bookings', ['error' => $e->getMessage()]);
            
            return response()->json([
                'success' => false,
                'message' => 'Failed to get bookings',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        \Log::info('Creating booking', $request->all());

        $validator = Validator::make($request->all(), [
            'travel_route_id' => 'required|exists:travel_routes,id',
            'travel_date' => 'required|date|after_or_equal:today',
            'passenger_count' => 'required|integer|min:1|max:10',
            'passenger_details' => 'required|array',
            'passenger_details.*.name' => 'required|string',
            'passenger_details.*.id_number' => 'required|string',
            'passenger_details.*.phone' => 'required|string',
            'passenger_details.*.seat_number' => 'required|string',
        ]);

        if ($validator->fails()) {
            \Log::warning('Booking validation failed', $validator->errors()->toArray());
            
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $route = TravelRoute::find($request->travel_route_id);

        if (!$route) {
            return response()->json([
                'success' => false,
                'message' => 'Travel route not found'
            ], 404);
        }

        if ($route->available_seats < $request->passenger_count) {
            return response()->json([
                'success' => false,
                'message' => 'Kursi tidak tersedia'
            ], 400);
        }

        DB::beginTransaction();
        try {
            // Create booking with PENDING status (bukan confirmed)
            $booking = Booking::create([
                'user_id' => $request->user()->id,
                'travel_route_id' => $request->travel_route_id,
                'travel_date' => $request->travel_date,
                'passenger_count' => $request->passenger_count,
                'total_price' => $route->price * $request->passenger_count,
                'passenger_details' => $request->passenger_details,
                'status' => 'pending_payment', // Status awal: menunggu pembayaran
            ]);

            // JANGAN update available_seats dulu, tunggu sampai dibayar
            // $route->decrement('available_seats', $request->passenger_count);

            $booking->load('travelRoute');

            DB::commit();

            \Log::info('Booking created successfully', [
                'booking_id' => $booking->id,
                'booking_code' => $booking->booking_code,
                'user_id' => $booking->user_id
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Booking berhasil dibuat. Silakan lakukan pembayaran.',
                'data' => $booking,
                'payment_info' => [
                    'bank_name' => 'Bank BCA',
                    'account_number' => '1234567890',
                    'account_name' => 'PT Traveller Indonesia',
                    'amount' => $route->price * $request->passenger_count,
                    'admin_whatsapp' => '+6281234567890',
                    'payment_deadline' => now()->addHours(24)->format('Y-m-d H:i:s')
                ]
            ], 201);

        } catch (\Exception $e) {
            DB::rollback();
            
            \Log::error('Booking creation failed', [
                'error' => $e->getMessage(),
                'user_id' => $request->user()->id
            ]);
            
            return response()->json([
                'success' => false,
                'message' => 'Booking gagal dibuat: ' . $e->getMessage()
            ], 500);
        }
    }

    public function show($id, Request $request)
    {
        try {
            $booking = Booking::with('travelRoute')
                ->byUser($request->user()->id)
                ->find($id);

            if (!$booking) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $booking
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to get booking'
            ], 500);
        }
    }

    public function cancel($id, Request $request)
    {
        try {
            \Log::info('Cancelling booking', ['booking_id' => $id, 'user_id' => $request->user()->id]);

            $booking = Booking::byUser($request->user()->id)->find($id);

            if (!$booking) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking not found'
                ], 404);
            }

            if (!in_array($booking->status, ['pending_payment', 'confirmed'])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking tidak dapat dibatalkan. Status: ' . $booking->status
                ], 400);
            }

            DB::beginTransaction();
            try {
                $oldStatus = $booking->status;
                
                // Update booking status to cancelled
                $booking->update(['status' => 'cancelled']);

                // Return available seats jika booking sudah confirmed sebelumnya
                if ($oldStatus === 'confirmed') {
                    $booking->travelRoute->increment('available_seats', $booking->passenger_count);
                    \Log::info('Returned seats to route', [
                        'route_id' => $booking->travel_route_id,
                        'returned_seats' => $booking->passenger_count
                    ]);
                }

                DB::commit();

                \Log::info('Booking cancelled successfully', [
                    'booking_id' => $id,
                    'old_status' => $oldStatus,
                    'new_status' => 'cancelled'
                ]);

                return response()->json([
                    'success' => true,
                    'message' => 'Booking berhasil dibatalkan',
                    'data' => [
                        'booking_id' => $booking->id,
                        'old_status' => $oldStatus,
                        'new_status' => 'cancelled'
                    ]
                ]);

            } catch (\Exception $e) {
                DB::rollback();
                throw $e;
            }
        } catch (\Exception $e) {
            \Log::error('Failed to cancel booking', [
                'booking_id' => $id,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Gagal membatalkan booking: ' . $e->getMessage()
            ], 500);
        }
    }

    // Method baru untuk konfirmasi pembayaran (admin only)
    public function confirmPayment($id, Request $request)
    {
        try {
            $booking = Booking::find($id);

            if (!$booking) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking not found'
                ], 404);
            }

            if ($booking->status !== 'pending_payment') {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking sudah dikonfirmasi atau dibatalkan'
                ], 400);
            }

            DB::beginTransaction();
            try {
                // Update status ke confirmed
                $booking->update(['status' => 'confirmed']);

                // Baru kurangi available seats
                $booking->travelRoute->decrement('available_seats', $booking->passenger_count);

                DB::commit();

                return response()->json([
                    'success' => true,
                    'message' => 'Pembayaran berhasil dikonfirmasi'
                ]);

            } catch (\Exception $e) {
                DB::rollback();
                throw $e;
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal konfirmasi pembayaran'
            ], 500);
        }
    }
}