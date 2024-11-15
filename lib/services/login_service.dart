import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class LoginService {
  final String _baseUrl = 'http://127.0.0.1:5000/api/login';

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      // Parse response body
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserModel.fromJson(responseData);
      } else {
        // Handle different error status codes
        switch (response.statusCode) {
          case 400:
            throw Exception(responseData['error'] ?? 'Invalid input data');
          case 401:
            throw Exception('Email atau password salah');
          case 404:
            throw Exception('User tidak ditemukan');
          case 500:
            throw Exception('Terjadi kesalahan server');
          default:
            throw Exception(responseData['error'] ?? 'Gagal login');
        }
      }
    } on http.ClientException {
      throw Exception('Tidak dapat terhubung ke server');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
