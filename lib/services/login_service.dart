import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class LoginService {
  final String _baseUrl = 'http://10.0.2.2:5000/api/login';

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to login');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}
