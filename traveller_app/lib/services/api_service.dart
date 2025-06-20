import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String _tokenKey = 'auth_token';

  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Save token
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Clear token
  static Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  // Test connection
  static Future<ApiResponse> testConnection() async {
    try {
      print('Testing API connection to: $baseUrl/test');

      final response = await http
          .get(
            Uri.parse('$baseUrl/test'),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      print('API Test Response Status: ${response.statusCode}');
      print('API Test Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          success: true,
          message: 'API connection successful',
          data: data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'API connection failed: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('API Test Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Register
  static Future<ApiResponse> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      print('Registering user: $email');

      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/register'),
            headers: await _getHeaders(),
            body: jsonEncode({
              'name': name,
              'email': email,
              'phone': phone,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 15));

      print('Register Response Status: ${response.statusCode}');
      print('Register Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['success']) {
        await _saveToken(data['data']['token']);
        return ApiResponse(
          success: true,
          message: data['message'],
          data: data['data'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Registration failed',
          errors: data['errors'],
        );
      }
    } catch (e) {
      print('Register Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Login
  static Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      print('Logging in user: $email');

      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/login'),
            headers: await _getHeaders(),
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 15));

      print('Login Response Status: ${response.statusCode}');
      print('Login Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        await _saveToken(data['data']['token']);
        return ApiResponse(
          success: true,
          message: data['message'],
          data: data['data'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Login failed',
        );
      }
    } catch (e) {
      print('Login Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Logout
  static Future<ApiResponse> logout() async {
    try {
      print('Logging out user');

      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/logout'),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      await _clearToken();

      if (response.statusCode == 200) {
        return ApiResponse(success: true, message: 'Logout successful');
      } else {
        return ApiResponse(success: false, message: 'Logout failed');
      }
    } catch (e) {
      print('Logout Error: $e');
      await _clearToken(); // Clear token anyway
      return ApiResponse(success: true, message: 'Logged out');
    }
  }

  // Get current user
  static Future<ApiResponse> getCurrentUser() async {
    try {
      print('Getting current user');

      final response = await http
          .get(
            Uri.parse('$baseUrl/auth/me'),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      print('Get User Response Status: ${response.statusCode}');
      print('Get User Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        return ApiResponse(
          success: true,
          data: data['data'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Failed to get user data',
        );
      }
    } catch (e) {
      print('Get User Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Update profile
  static Future<ApiResponse> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      print('Updating profile');

      final response = await http
          .put(
            Uri.parse('$baseUrl/auth/profile'),
            headers: await _getHeaders(),
            body: jsonEncode({
              'name': name,
              'phone': phone,
            }),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      return ApiResponse(
        success: data['success'] ?? false,
        message: data['message'] ?? 'Update failed',
        data: data['data'],
        errors: data['errors'],
      );
    } catch (e) {
      print('Update Profile Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Get travel routes
  static Future<ApiResponse> getTravelRoutes({
    String? from,
    String? to,
    String? busType,
  }) async {
    try {
      print('Getting travel routes...');
      print('From: $from');
      print('To: $to');
      print('Bus Type: $busType');

      String url = '$baseUrl/routes';
      List<String> queryParams = [];

      if (from != null && from.isNotEmpty) {
        queryParams.add('from=${Uri.encodeComponent(from)}');
      }
      if (to != null && to.isNotEmpty) {
        queryParams.add('to=${Uri.encodeComponent(to)}');
      }
      if (busType != null && busType.isNotEmpty) {
        queryParams.add('bus_type=${Uri.encodeComponent(busType)}');
      }

      if (queryParams.isNotEmpty) {
        url += '?${queryParams.join('&')}';
      }

      print('Final URL: $url');

      final response = await http
          .get(
            Uri.parse(url),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      print('Get Routes Response Status: ${response.statusCode}');
      print('Get Routes Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Debug: print raw data structure
        if (data['data'] != null && data['data'].isNotEmpty) {
          print('Sample route data structure:');
          print('First route: ${data['data'][0]}');

          // Check data types
          final firstRoute = data['data'][0];
          print('price type: ${firstRoute['price'].runtimeType}');
          print(
              'available_seats type: ${firstRoute['available_seats'].runtimeType}');
        }

        return ApiResponse(
          success: data['success'] ?? false,
          data: data['data'],
          message: data['message'],
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Failed to get routes',
          data: data['data'],
        );
      }
    } catch (e) {
      print('Get Routes Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Get popular routes
  static Future<ApiResponse> getPopularRoutes() async {
    try {
      print('Getting popular routes');

      final response = await http
          .get(
            Uri.parse('$baseUrl/routes/popular'),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      print('Get Popular Routes Response Status: ${response.statusCode}');
      print('Get Popular Routes Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      return ApiResponse(
        success: data['success'] ?? false,
        data: data['data'],
        message: data['message'],
      );
    } catch (e) {
      print('Get Popular Routes Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Get cities
  static Future<ApiResponse> getCities() async {
    try {
      print('Getting cities');

      final response = await http
          .get(
            Uri.parse('$baseUrl/routes/cities'),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      print('Get Cities Response Status: ${response.statusCode}');
      print('Get Cities Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      return ApiResponse(
        success: data['success'] ?? false,
        data: data['data'],
        message: data['message'],
      );
    } catch (e) {
      print('Get Cities Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Get travel route detail
  static Future<ApiResponse> getTravelRouteDetail(String id) async {
    try {
      print('Getting route detail for ID: $id');

      final response = await http
          .get(
            Uri.parse('$baseUrl/routes/$id'),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      return ApiResponse(
        success: data['success'] ?? false,
        data: data['data'],
        message: data['message'],
      );
    } catch (e) {
      print('Get Route Detail Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Get bookings
  static Future<ApiResponse> getBookings() async {
    try {
      print('Getting bookings');

      final response = await http
          .get(
            Uri.parse('$baseUrl/bookings'),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      return ApiResponse(
        success: data['success'] ?? false,
        data: data['data'],
        message: data['message'],
      );
    } catch (e) {
      print('Get Bookings Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Create booking
  static Future<ApiResponse> createBooking({
    required int travelRouteId,
    required String travelDate,
    required int passengerCount,
    required List<Map<String, String>> passengerDetails,
  }) async {
    try {
      print('Creating booking');

      final response = await http
          .post(
            Uri.parse('$baseUrl/bookings'),
            headers: await _getHeaders(),
            body: jsonEncode({
              'travel_route_id': travelRouteId,
              'travel_date': travelDate,
              'passenger_count': passengerCount,
              'passenger_details': passengerDetails,
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      return ApiResponse(
        success: data['success'] ?? false,
        message: data['message'] ?? 'Booking failed',
        data: data['data'],
        errors: data['errors'],
      );
    } catch (e) {
      print('Create Booking Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  // Cancel booking - NEW METHOD
  static Future<ApiResponse> cancelBooking(dynamic bookingId) async {
    try {
      print('Cancelling booking ID: $bookingId');

      final response = await http
          .put(
            Uri.parse('$baseUrl/bookings/$bookingId/cancel'),
            headers: await _getHeaders(),
          )
          .timeout(const Duration(seconds: 15));

      print('Cancel Booking Response Status: ${response.statusCode}');
      print('Cancel Booking Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      return ApiResponse(
        success: data['success'] ?? false,
        message: data['message'] ?? 'Cancel booking failed',
        data: data['data'],
        errors: data['errors'],
      );
    } catch (e) {
      print('Cancel Booking Error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
      );
    }
  }
}

class ApiResponse {
  final bool success;
  final String? message;
  final dynamic data;
  final dynamic errors;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.errors,
  });

  @override
  String toString() {
    return 'ApiResponse(success: $success, message: $message, data: $data)';
  }
}
