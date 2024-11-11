import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class RegisterService {
  final String _baseUrl = 'http://127.0.0.1:5000/api/register';

  Future<Map<String, dynamic>> registerUser(UserModel user) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }
}
