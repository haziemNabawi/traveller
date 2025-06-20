<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();
            $table->string('booking_code')->unique();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('travel_route_id')->constrained()->onDelete('cascade');
            $table->date('travel_date');
            $table->integer('passenger_count');
            $table->decimal('total_price', 10, 2);
            $table->enum('status', ['pending_payment', 'confirmed', 'cancelled', 'completed'])->default('pending_payment');
            $table->json('passenger_details');
            $table->timestamp('booking_date');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bookings');
    }
};