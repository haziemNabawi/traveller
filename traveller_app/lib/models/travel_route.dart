class TravelRoute {
  final String id;
  final String from;
  final String to;
  final int price;
  final String duration;
  final String busType;
  final String departure;
  final String arrival;
  final int availableSeats;
  final String? busOperator;
  final List<String>? facilities;

  TravelRoute({
    required this.id,
    required this.from,
    required this.to,
    required this.price,
    required this.duration,
    required this.busType,
    required this.departure,
    required this.arrival,
    required this.availableSeats,
    this.busOperator,
    this.facilities,
  });

  String get formattedPrice {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  String get routeInfo {
    return '$from → $to';
  }

  bool get isAvailable {
    return availableSeats > 0;
  }

  String get availabilityText {
    if (availableSeats > 10) {
      return 'Tersedia';
    } else if (availableSeats > 0) {
      return '$availableSeats kursi tersisa';
    } else {
      return 'Penuh';
    }
  }
}

class BookingData {
  final String id;
  final TravelRoute route;
  final DateTime bookingDate;
  final DateTime travelDate;
  final int passengerCount;
  final List<Passenger> passengers;
  String status; // Mutable untuk bisa diubah saat cancel
  final String bookingCode;

  BookingData({
    required this.id,
    required this.route,
    required this.bookingDate,
    required this.travelDate,
    required this.passengerCount,
    required this.passengers,
    required this.status,
    required this.bookingCode,
  });

  int get totalPrice {
    return route.price * passengerCount;
  }

  String get formattedTotalPrice {
    return 'Rp ${totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}

class Passenger {
  final String name;
  final String idNumber;
  final String phoneNumber;
  final String seatNumber;

  Passenger({
    required this.name,
    required this.idNumber,
    required this.phoneNumber,
    required this.seatNumber,
  });
}
