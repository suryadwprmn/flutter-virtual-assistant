import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class AuthService {
  final String _baseUrl = 'http://127.0.0.1:5000/api';
  static const String TOKEN_KEY = 'access_token';
  static const String USER_KEY = 'user_data';

  // Fungsi untuk menyimpan token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, token);
  }

  // Fungsi untuk mendapatkan token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }

  // Fungsi untuk menghapus token (logout)
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    await prefs.remove(USER_KEY);
  }

  // Fungsi untuk menyimpan data user
  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_KEY, jsonEncode(userData));
  }

  // Login method
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Simpan token
        if (responseData.containsKey('access_token')) {
          await _saveToken(responseData['access_token']);
        }

        // Simpan data user
        if (responseData.containsKey('user')) {
          await _saveUserData(responseData['user']);
        }

        return UserModel.fromJson(responseData);
      } else {
        throw _handleError(response.statusCode, responseData);
      }
    } on http.ClientException {
      throw Exception('Tidak dapat terhubung ke server');
    } catch (e) {
      print('Login Error: $e'); // Untuk debugging
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Register method
  Future<Map<String, dynamic>> register(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Jika registrasi sekaligus login, simpan token
        if (responseData.containsKey('access_token')) {
          await _saveToken(responseData['access_token']);
        }
        return responseData;
      } else {
        throw _handleError(response.statusCode, responseData);
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<UserModel> getProfile(String token) async {
    try {
      final url = Uri.parse('$_baseUrl/profile');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Update saved user data
        await _saveUserData(data);
        return UserModel.fromJson(data);
      } else if (response.statusCode == 401) {
        // Token tidak valid atau expired
        throw Exception('Sesi telah berakhir. Silakan login kembali.');
      } else {
        throw Exception("Failed to fetch profile: ${response.body}");
      }
    } catch (e) {
      print('Get Profile Error: $e'); // Untuk debugging
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<UserModel> updateProfile({
    required String token,
    String? name,
    String? gender,
    String? diabetesCategory,
    String? phone,
    String? password,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/profile');
      final Map<String, dynamic> body = {};

      // Hanya tambahkan data yang ada
      if (name != null) body['name'] = name;
      if (gender != null) body['gender'] = gender;
      if (diabetesCategory != null)
        body['diabetes_category'] = diabetesCategory;
      if (phone != null) body['phone'] = phone;
      if (password != null) body['password'] = password;

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await _saveUserData(data);

        return UserModel.fromJson(data);
      } else if (response.statusCode == 401) {
        // Token tidak valid atau expired
        throw Exception('Sesi telah berakhir. Silakan login kembali.');
      } else {
        throw Exception("Failed to update profile: ${response.body}");
      }
    } catch (e) {
      print('Update Profile Error: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Fungsi untuk mengecek status login
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  // Fungsi untuk logout
  Future<void> logout() async {
    try {
      // Hapus token dan data pengguna yang tersimpan
      await removeToken(); // Hapus token
      await removeUserData(); // Hapus data pengguna
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

// Fungsi untuk menghapus data user
  Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(USER_KEY);
  }

  // Error handling method
  Exception _handleError(int statusCode, Map<String, dynamic> responseData) {
    switch (statusCode) {
      case 400:
        return Exception(responseData['error'] ?? 'Input data tidak valid');
      case 401:
        return Exception('Email atau password salah');
      case 404:
        return Exception('User tidak ditemukan');
      case 500:
        return Exception('Terjadi kesalahan server');
      default:
        return Exception(responseData['error'] ?? 'Gagal memproses permintaan');
    }
  }
}
