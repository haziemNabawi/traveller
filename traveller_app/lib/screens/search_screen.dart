import 'package:flutter/material.dart';
import '../models/travel_route.dart';
import '../widgets/route_card.dart';
import '../services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  List<dynamic> _searchResults = [];
  List<String> _cities = [];
  bool _isSearching = false;
  bool _isLoadingCities = true;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    try {
      print('Loading cities from API...');
      final response = await ApiService.getCities();

      if (response.success && mounted) {
        setState(() {
          _cities = (response.data as List).cast<String>();
          _isLoadingCities = false;
        });
        print('Loaded ${_cities.length} cities: ${_cities.join(", ")}');
      } else {
        // Fallback cities if API fails
        setState(() {
          _cities = [
            'Jakarta',
            'Bandung',
            'Surabaya',
            'Yogyakarta',
            'Semarang',
            'Malang',
            'Solo',
            'Bali', // Pastikan Bali ada di fallback
            'Medan',
            'Palembang',
          ];
          _isLoadingCities = false;
        });
        print('Failed to load cities, using fallback');
      }
    } catch (e) {
      print('Error loading cities: $e');
      // Use fallback cities
      if (mounted) {
        setState(() {
          _cities = [
            'Jakarta',
            'Bandung',
            'Surabaya',
            'Yogyakarta',
            'Semarang',
            'Malang',
            'Solo',
            'Bali',
          ];
          _isLoadingCities = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Cari Perjalanan'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Form
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
              children: [
                // From and To fields
                Row(
                  children: [
                    Expanded(
                      child: _buildLocationField(
                        controller: _fromController,
                        hint: 'Dari',
                        icon: Icons.location_on,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _swapLocations,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.swap_horiz,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildLocationField(
                        controller: _toController,
                        hint: 'Ke',
                        icon: Icons.location_on,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Date picker
                GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey[600]),
                        const SizedBox(width: 10),
                        Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Search button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSearching ? null : _performSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: _isSearching
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Cari Perjalanan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),

          // Search Results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => _showCityPicker(controller),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600], size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                controller.text.isEmpty ? hint : controller.text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.text.isEmpty
                      ? Colors.grey[600]
                      : Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: _buildRouteCard(_searchResults[index]),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Cari perjalanan Anda',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Pilih kota asal dan tujuan untuk\nmelihat jadwal perjalanan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(dynamic route) {
    // Convert API data to TravelRoute model dengan safe parsing
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

      final travelRoute = TravelRoute(
        id: route['id']?.toString() ?? '0',
        from: route['from_city']?.toString() ?? '',
        to: route['to_city']?.toString() ?? '',
        price: price,
        duration: route['duration']?.toString() ?? '',
        busType: route['bus_type']?.toString() ?? '',
        departure: route['departure_time']?.toString() ?? '',
        arrival: route['arrival_time']?.toString() ?? '',
        availableSeats: availableSeats,
        busOperator: route['bus_operator']?.toString(),
        facilities: route['facilities'] != null
            ? List<String>.from(route['facilities'])
            : null,
      );

      return RouteCard(route: travelRoute);
    } catch (e) {
      print('Error parsing route data: $e');
      print('Route data: $route');

      // Return error card jika parsing gagal
      return Card(
        margin: const EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text('Error parsing route data',
                  style: TextStyle(color: Colors.red)),
              Text('$e', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      );
    }
  }

  void _showCityPicker(TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pilih Kota',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isLoadingCities)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _isLoadingCities
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _cities.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_cities[index]),
                            leading: const Icon(Icons.location_city),
                            onTap: () {
                              controller.text = _cities[index];
                              Navigator.pop(context);
                              setState(() {});
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _swapLocations() {
    final temp = _fromController.text;
    _fromController.text = _toController.text;
    _toController.text = temp;
    setState(() {});
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _performSearch() async {
    if (_fromController.text.isEmpty || _toController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon pilih kota asal dan tujuan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Cek jika kota asal dan tujuan sama
    if (_fromController.text.toLowerCase() ==
        _toController.text.toLowerCase()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kota asal dan tujuan tidak boleh sama'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isSearching = true;
      _searchResults = []; // Clear previous results
    });

    try {
      print('=== SEARCH DEBUG ===');
      print(
          'Searching routes: ${_fromController.text} -> ${_toController.text}');

      // EXACT match - tidak ada case conversion
      final response = await ApiService.getTravelRoutes(
        from: _fromController.text, // Kirim persis seperti yang dipilih user
        to: _toController.text, // Kirim persis seperti yang dipilih user
      );

      print('API Response Success: ${response.success}');
      print('API Response Data Length: ${response.data?.length ?? 0}');

      if (response.success && mounted) {
        final routes = response.data ?? [];

        print('Found ${routes.length} routes from API');

        // Debug: print all routes
        for (var route in routes) {
          print('Route: ${route['from_city']} -> ${route['to_city']}');
        }

        setState(() {
          _searchResults = routes; // Langsung pakai hasil dari API
          _isSearching = false;
        });

        if (routes.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Tidak ada rute dari ${_fromController.text} ke ${_toController.text}'),
              backgroundColor: Colors.orange,
            ),
          );
        } else {
          print('SUCCESS: Found ${routes.length} routes');
        }
      } else {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? 'Gagal mencari rute'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Search error: $e');

      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }
}
