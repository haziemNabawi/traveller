<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Booking extends Model
{
    use HasFactory;

    protected $fillable = [
        'booking_code',
        'user_id',
        'travel_route_id',
        'travel_date',
        'passenger_count',
        'total_price',
        'status',
        'passenger_details',
        'booking_date',
    ];

    protected $casts = [
        'passenger_details' => 'array',
        'travel_date' => 'date',
        'booking_date' => 'datetime',
        'total_price' => 'decimal:2',
    ];

    protected $attributes = [
        'status' => 'pending_payment', // Default status: menunggu pembayaran
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function travelRoute()
    {
        return $this->belongsTo(TravelRoute::class);
    }

    public function getFormattedTotalPriceAttribute()
    {
        return 'Rp ' . number_format($this->total_price, 0, ',', '.');
    }

    // Method untuk mendapatkan status text yang user-friendly
    public function getStatusTextAttribute()
    {
        switch ($this->status) {
            case 'pending_payment':
                return 'Menunggu Pembayaran';
            case 'confirmed':
                return 'Dikonfirmasi';
            case 'completed':
                return 'Selesai';
            case 'cancelled':
                return 'Dibatalkan';
            default:
                return ucfirst($this->status);
        }
    }

    // Method untuk mendapatkan warna status
    public function getStatusColorAttribute()
    {
        switch ($this->status) {
            case 'pending_payment':
                return '#f59e0b'; // Orange
            case 'confirmed':
                return '#10b981'; // Green
            case 'completed':
                return '#3b82f6'; // Blue
            case 'cancelled':
                return '#ef4444'; // Red
            default:
                return '#6b7280'; // Gray
        }
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($booking) {
            if (empty($booking->booking_code)) {
                $booking->booking_code = 'TRV' . strtoupper(Str::random(6));
            }
            if (empty($booking->booking_date)) {
                $booking->booking_date = now();
            }
        });
    }

    public function scopeByUser($query, $userId)
    {
        return $query->where('user_id', $userId);
    }

    public function scopeByStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    public function scopePendingPayment($query)
    {
        return $query->where('status', 'pending_payment');
    }

    public function scopeConfirmed($query)
    {
        return $query->where('status', 'confirmed');
    }
}