import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/blood_sugar_model.dart';
import 'auth_service.dart';
import '../utils/custom_exception.dart';

class BloodSugarService {
  final String _baseUrl = 'http://127.0.0.1:5000/api';
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    if (token == null) {
      throw CustomException('Tidak ada token. Silakan login kembali.');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<BloodSugarRecord>> getGrafik() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/gula_darah/seminggu'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return (data['data'] as List)
            .map((json) => BloodSugarRecord.fromJson(json))
            .toList();
      } else if (response.statusCode == 404) {
        throw CustomException('Data grafik tidak ditemukan.');
      } else {
        throw CustomException(
          'Gagal mendapatkan data grafik: ${response.statusCode}. '
          'Silakan coba lagi nanti.',
        );
      }
    } catch (e) {
      print('Error di getGrafik: $e');
      if (e is CustomException) {
        rethrow; // Jika sudah custom, lempar ulang.
      }
      throw CustomException('Terjadi kesalahan tak terduga. Coba lagi nanti.');
    }
  }
}
