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
        Schema::create('travel_routes', function (Blueprint $table) {
            $table->id();
            $table->string('from_city');
            $table->string('to_city');
            $table->decimal('price', 10, 2);
            $table->string('duration');
            $table->enum('bus_type', ['economy', 'executive', 'luxury']);
            $table->time('departure_time');
            $table->time('arrival_time');
            $table->integer('total_seats');
            $table->integer('available_seats');
            $table->string('bus_operator')->nullable();
            $table->json('facilities')->nullable();
            $table->enum('status', ['active', 'inactive'])->default('active');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('travel_routes');
    }
};