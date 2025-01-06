import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';
import '../model/konsumsi_model.dart';
import '../model/konsumsi_harian_model.dart';

class KonsumsiService {
  final String _baseUrl = 'https://ox-nearby-kangaroo.ngrok-free.app/api';
  final AuthService _authService = AuthService();

  Future<KonsumsiModel> createKonsumsi({
    required double jumlahKonsumsi,
    required String waktu,
  }) async {
    try {
      // Get the auth token
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found');
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/konsumsi'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'jumlah_konsumsi': jumlahKonsumsi,
          'waktu': waktu,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          return KonsumsiModel.fromJson(responseData['data']);
        } else {
          throw Exception(
              responseData['message'] ?? 'Failed to create konsumsi');
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to create konsumsi');
      }
    } catch (e) {
      throw Exception('Error creating konsumsi: $e');
    }
  }

  Future<DailyConsumption> getDailyConsumption(String token,
      {DateTime? date}) async {
    try {
      String dateParam = '';
      if (date != null) {
        dateParam =
            '?date=${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/konsumsi/daily-total$dateParam'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DailyConsumption.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('Sesi telah berakhir. Silakan login kembali.');
      } else {
        throw Exception('Gagal mengambil data konsumsi harian');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
