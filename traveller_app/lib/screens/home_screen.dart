import 'package:flutter/material.dart';
import '../models/travel_route.dart';
import '../widgets/route_card.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'create_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String userName = 'Traveller';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await AuthService.getCurrentUser();
      if (userData != null && mounted) {
        setState(() {
          userName = userData['name'] ?? 'Traveller';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  // FIXED: Navigation helper using simple approach
  void _navigateToTab(int tabIndex) {
    print('Navigating to tab $tabIndex');

    switch (tabIndex) {
      case 1: // Search
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gunakan tab "Cari" di bawah untuk mencari rute'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 3: // Profile
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Gunakan tab "Profile" di bawah untuk melihat profil'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selamat Datang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Quick Search - Navigate to Search Tab
                    GestureDetector(
                      onTap: () {
                        print('Search bar tapped');
                        _navigateToTab(1); // Navigate to search tab
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Cari rute perjalanan...',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Quick Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickAction(
                      icon: Icons.directions_bus,
                      label: 'Shuttle',
                      color: Colors.blue,
                      isActive: true,
                      onTap: () => _showTodayBusList(),
                    ),
                    _buildQuickAction(
                      icon: Icons.card_travel,
                      label: 'Trip',
                      color: Colors.green,
                      isActive: false,
                      onTap: () => _showComingSoon('Trip'),
                    ),
                    _buildQuickAction(
                      icon: Icons.local_shipping,
                      label: 'Cargo',
                      color: Colors.orange,
                      isActive: false,
                      onTap: () => _showComingSoon('Cargo'),
                    ),
                    _buildQuickAction(
                      icon: Icons.schedule,
                      label: 'Jadwal',
                      color: Colors.purple,
                      isActive: false,
                      onTap: () => _showComingSoon('Jadwal'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Coming Soon Liburan/Trip Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple[400]!,
                        Colors.indigo[400]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withValues(alpha: 0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'COMING SOON',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Paket Liburan & Trip',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Explore destinasi menarik dengan paket wisata lengkap',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Notify Me',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.landscape,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Promo Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange[400]!, Colors.red[400]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Promo Spesial!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Diskon hingga 30% untuk perjalanan pertama',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.local_offer,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Services Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Layanan Kami',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildServiceCard(
                            icon: Icons.business_center,
                            title: 'Business Trip',
                            subtitle: 'Perjalanan bisnis nyaman',
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildServiceCard(
                            icon: Icons.family_restroom,
                            title: 'Family Trip',
                            subtitle: 'Liburan keluarga seru',
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildServiceCard(
                            icon: Icons.beach_access,
                            title: 'Holiday Package',
                            subtitle: 'Paket wisata lengkap',
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildServiceCard(
                            icon: Icons.workspace_premium,
                            title: 'VIP Service',
                            subtitle: 'Layanan premium eksklusif',
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isActive
                  ? color.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
              border: isActive ? Border.all(color: color, width: 2) : null,
            ),
            child: Icon(
              icon,
              color: isActive ? color : Colors.grey,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? color : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _showComingSoon(title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTodayBusList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => TodayBusListModal(),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Text('Fitur $feature akan segera hadir!'),
          ],
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class TodayBusListModal extends StatefulWidget {
  @override
  TodayBusListModalState createState() => TodayBusListModalState();
}

class TodayBusListModalState extends State<TodayBusListModal> {
  List<TravelRoute> _todayRoutes = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadTodayRoutes();
  }

  Future<void> _loadTodayRoutes() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final response = await ApiService.getTravelRoutes();

      if (response.success && mounted) {
        final routes = response.data ?? [];
        final currentTime = TimeOfDay.now();

        print('=== FIXED TODAY BUS FILTERING ===');
        print(
            'Current time: ${currentTime.hour}:${currentTime.minute.toString().padLeft(2, '0')}');
        print('Total routes from API: ${routes.length}');

        final List<TravelRoute> availableRoutes = [];

        for (var route in routes) {
          try {
            // Safe parsing untuk price
            int price = 0;
            if (route['price'] != null) {
              if (route['price'] is int) {
                price = route['price'];
              } else if (route['price'] is double) {
                price = route['price'].toInt();
              } else if (route['price'] is String) {
                price = int.tryParse(route['price']) ?? 0;
              }
            }

            // Safe parsing untuk available_seats
            int availableSeats = 0;
            if (route['available_seats'] != null) {
              if (route['available_seats'] is int) {
                availableSeats = route['available_seats'];
              } else if (route['available_seats'] is double) {
                availableSeats = route['available_seats'].toInt();
              } else if (route['available_seats'] is String) {
                availableSeats = int.tryParse(route['available_seats']) ?? 0;
              }
            }

            // FIXED: Extract time from datetime string
            final departureTimeStr = route['departure_time']?.toString() ?? '';
            final arrivalTimeStr = route['arrival_time']?.toString() ?? '';

            final cleanDepartureTime =
                _extractTimeFromDateTime(departureTimeStr);
            final cleanArrivalTime = _extractTimeFromDateTime(arrivalTimeStr);

            final travelRoute = TravelRoute(
              id: route['id']?.toString() ?? '0',
              from: route['from_city']?.toString() ?? '',
              to: route['to_city']?.toString() ?? '',
              price: price,
              duration: route['duration']?.toString() ?? '',
              busType: route['bus_type']?.toString() ?? '',
              departure: cleanDepartureTime,
              arrival: cleanArrivalTime,
              availableSeats: availableSeats,
              busOperator: route['bus_operator']?.toString(),
              facilities: route['facilities'] != null
                  ? List<String>.from(route['facilities'])
                  : null,
            );

            // Filter: Only show buses that depart 15+ minutes from now
            if (_isDepartureTimeValid(cleanDepartureTime, currentTime)) {
              availableRoutes.add(travelRoute);
              print(
                  '✅ Available: ${route['from_city']} -> ${route['to_city']} at $cleanDepartureTime');
            } else {
              print(
                  '❌ Filtered (< 15min): ${route['from_city']} -> ${route['to_city']} at $cleanDepartureTime');
            }
          } catch (e) {
            print('Error parsing route: $e');
          }
        }

        // Sort by departure time
        availableRoutes.sort((a, b) {
          final timeA = _parseTimeString(a.departure);
          final timeB = _parseTimeString(b.departure);
          return timeA.hour * 60 +
              timeA.minute -
              (timeB.hour * 60 + timeB.minute);
        });

        setState(() {
          _todayRoutes = availableRoutes;
          _isLoading = false;
        });

        print('Total available buses today: ${availableRoutes.length}');
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Gagal memuat data bus';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading today routes: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Terjadi kesalahan koneksi';
          _isLoading = false;
        });
      }
    }
  }

  // FIXED: Extract time from full datetime string
  String _extractTimeFromDateTime(String dateTimeStr) {
    try {
      if (dateTimeStr.contains(' ')) {
        // Full datetime format: "2025-06-20 07:00:00"
        final parts = dateTimeStr.split(' ');
        if (parts.length >= 2) {
          final timePart = parts[1]; // "07:00:00"
          final timeParts = timePart.split(':');
          if (timeParts.length >= 2) {
            return '${timeParts[0]}:${timeParts[1]}'; // "07:00"
          }
        }
      } else {
        // Already time format: "07:00:00" or "07:00"
        final timeParts = dateTimeStr.split(':');
        if (timeParts.length >= 2) {
          return '${timeParts[0]}:${timeParts[1]}'; // "07:00"
        }
      }

      return dateTimeStr; // Return as-is if parsing fails
    } catch (e) {
      print('Error extracting time from: $dateTimeStr - $e');
      return dateTimeStr;
    }
  }

  // Filter logic: Bus must depart at least 15 minutes from now
  bool _isDepartureTimeValid(String departureTimeStr, TimeOfDay currentTime) {
    try {
      final departureTime = _parseTimeString(departureTimeStr);
      final currentMinutes = currentTime.hour * 60 + currentTime.minute;
      final departureMinutes = departureTime.hour * 60 + departureTime.minute;

      // Bus must depart at least 15 minutes from now
      return departureMinutes >= (currentMinutes + 15);
    } catch (e) {
      print('Error parsing departure time: $departureTimeStr - $e');
      return true;
    }
  }

  TimeOfDay _parseTimeString(String timeStr) {
    try {
      final parts = timeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = parts.length > 1 ? int.parse(parts[1]) : 0;
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shuttle Tersedia Hari Ini',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: _loadTodayRoutes,
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Text(
                'Tanggal: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Sekarang ${TimeOfDay.now().format(context)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat shuttle hari ini dari server...'),
          ],
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadTodayRoutes,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (_todayRoutes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_bus_outlined,
              size: 60,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada shuttle tersedia saat ini',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Semua shuttle mungkin sudah berangkat.\nPeriksa jadwal untuk hari lain di pencarian.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Gunakan tab "Cari" untuk mencari jadwal lain'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                'Cari Jadwal Lain',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _todayRoutes.length,
      itemBuilder: (context, index) {
        final route = _todayRoutes[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context); // Close modal

                // Navigate to booking
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateBookingScreen(
                      route: route,
                      travelDate: DateTime.now(),
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Route info
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                route.from,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                route.departure,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColor,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                route.to,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                route.arrival,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              route.formattedPrice,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              route.busType,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              route.availabilityText,
                              style: TextStyle(
                                fontSize: 12,
                                color: route.isAvailable
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: route.isAvailable
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                route.isAvailable ? 'Pesan' : 'Penuh',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
