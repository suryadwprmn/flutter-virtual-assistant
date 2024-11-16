import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class AuthService {
  final String _baseUrl = 'http://127.0.0.1:5000/api';

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
        return UserModel.fromJson(responseData);
      } else {
        throw _handleError(response.statusCode, responseData);
      }
    } on http.ClientException {
      throw Exception('Tidak dapat terhubung ke server');
    } catch (e) {
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

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw _handleError(response.statusCode, jsonDecode(response.body));
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<UserModel> getProfile(String token) async {
    final url = Uri.parse('$_baseUrl/profile');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception("Failed to fetch profile: ${response.body}");
    }
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
