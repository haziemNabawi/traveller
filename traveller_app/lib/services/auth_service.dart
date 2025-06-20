import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserData = 'user_data';

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      // Cek API token dari SharedPreferences
      final hasApiToken = await ApiService.isLoggedIn();
      print('API token exists: $hasApiToken');

      if (hasApiToken) {
        // Double check dengan test API call
        final response = await ApiService.getCurrentUser();
        if (response.success) {
          return true;
        }
      }

      // Clear invalid token
      await clearAuthData();
      return false;
    } catch (e) {
      print('Error checking login status: $e');
      await clearAuthData();
      return false;
    }
  }

  // Get current user data
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final response = await ApiService.getCurrentUser();
      if (response.success) {
        return response.data;
      }
    } catch (e) {
      print('Failed to get user from API: $e');
    }
    return null;
  }

  // Test API connection
  static Future<bool> testApiConnection() async {
    try {
      final response = await ApiService.testConnection();
      print('API Connection Test: ${response.success}');
      return response.success;
    } catch (e) {
      print('API Connection Failed: $e');
      return false;
    }
  }

  // Login - HANYA Laravel API
  static Future<AuthResult> login(String email, String password) async {
    try {
      print('=== Starting Login Process ===');
      print('Email: $email');

      // Test API connection first
      final apiAvailable = await testApiConnection();
      print('API Available: $apiAvailable');

      if (!apiAvailable) {
        return AuthResult(
          success: false,
          message:
              'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
        );
      }

      // Try Laravel API login
      final response = await ApiService.login(
        email: email,
        password: password,
      );

      print('API Response Success: ${response.success}');
      print('API Response Message: ${response.message}');

      if (response.success) {
        // Save login state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_keyIsLoggedIn, true);
        await prefs.setString(_keyUserData, email);

        return AuthResult(
          success: true,
          message: response.message ?? 'Login berhasil',
          user: UserData.fromJson(response.data['user']),
        );
      } else {
        return AuthResult(
          success: false,
          message: response.message ?? 'Email atau password salah',
        );
      }
    } catch (e) {
      print('Login error: $e');
      return AuthResult(
        success: false,
        message: 'Terjadi kesalahan saat login. Coba lagi.',
      );
    }
  }

  // Register - HANYA Laravel API
  static Future<AuthResult> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      print('=== Starting Registration Process ===');
      print('Name: $name');
      print('Email: $email');
      print('Phone: $phone');

      // Test API connection first
      final apiAvailable = await testApiConnection();
      print('API Available: $apiAvailable');

      if (!apiAvailable) {
        return AuthResult(
          success: false,
          message:
              'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
        );
      }

      // Try Laravel API register
      final response = await ApiService.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      print('API Response Success: ${response.success}');
      print('API Response Message: ${response.message}');

      if (response.success) {
        // JANGAN auto login setelah register
        // User harus login manual
        return AuthResult(
          success: true,
          message: response.message ?? 'Registrasi berhasil! Silakan login.',
          user: UserData.fromJson(response.data['user']),
        );
      } else {
        return AuthResult(
          success: false,
          message: response.message ?? 'Registrasi gagal',
          errors: response.errors,
        );
      }
    } catch (e) {
      print('Register error: $e');
      return AuthResult(
        success: false,
        message: 'Terjadi kesalahan saat registrasi. Coba lagi.',
      );
    }
  }

  // Logout
  static Future<void> logout() async {
    try {
      // Try to logout from Laravel API
      await ApiService.logout();
    } catch (e) {
      print('API logout failed: $e');
    }

    // Clear local storage anyway
    await clearAuthData();
  }

  // Clear all authentication data
  static Future<void> clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print('All auth data cleared');
    } catch (e) {
      print('Error clearing auth data: $e');
    }
  }

  // Force logout (untuk testing)
  static Future<void> forceLogout() async {
    await clearAuthData();
    print('Force logout completed');
  }

  // Update user profile
  static Future<bool> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      final response = await ApiService.updateProfile(
        name: name,
        phone: phone,
      );
      return response.success;
    } catch (e) {
      print('Update profile failed: $e');
      return false;
    }
  }

  // Change password
  static Future<AuthResult> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // TODO: Implement API call for change password
    await Future.delayed(const Duration(seconds: 1));
    return AuthResult(
      success: true,
      message: 'Password berhasil diubah',
    );
  }
}

class AuthResult {
  final bool success;
  final String message;
  final UserData? user;
  final dynamic errors;

  AuthResult({
    required this.success,
    required this.message,
    this.user,
    this.errors,
  });

  @override
  String toString() {
    return 'AuthResult(success: $success, message: $message, user: $user)';
  }
}

class UserData {
  final String name;
  final String email;
  final String phone;

  UserData({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return 'UserData(name: $name, email: $email, phone: $phone)';
  }
}
