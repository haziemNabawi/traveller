<?php
// app/Models/TravelRoute.php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TravelRoute extends Model
{
    use HasFactory;

    protected $fillable = [
        'from_city',
        'to_city',
        'price',
        'duration',
        'bus_type',
        'departure_time',
        'arrival_time',
        'total_seats',
        'available_seats',
        'bus_operator',
        'facilities',
        'status',
    ];

    protected $casts = [
        'facilities' => 'array',
        'departure_time' => 'datetime:H:i',
        'arrival_time' => 'datetime:H:i',
        'price' => 'decimal:2',
    ];

    public function bookings()
    {
        return $this->hasMany(Booking::class);
    }

    public function getFormattedPriceAttribute()
    {
        return 'Rp ' . number_format($this->price, 0, ',', '.');
    }

    public function getRouteInfoAttribute()
    {
        return $this->from_city . ' → ' . $this->to_city;
    }

    public function getIsAvailableAttribute()
    {
        return $this->available_seats > 0;
    }

    public function scopeAvailable($query)
    {
        return $query->where('status', 'active')->where('available_seats', '>', 0);
    }

    public function scopeRoute($query, $from, $to)
    {
        return $query->where('from_city', $from)->where('to_city', $to);
    }
}