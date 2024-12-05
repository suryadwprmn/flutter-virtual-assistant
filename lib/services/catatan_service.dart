import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/blood_sugar_record_model.dart';
import 'auth_service.dart';

class CatatanService {
  final String _baseUrl = 'http://127.0.0.1:5000/api';
  final AuthService _authService = AuthService();

  // Method untuk mendapatkan header dengan token
  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    if (token == null) {
      throw Exception('Tidak ada token. Silakan login kembali.');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Method untuk menambah catatan gula darah
  Future<String> tambahCatatanGulaDarah(CatatanGulaDarah catatan) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/gula_darah'),
        headers: await _getHeaders(),
        body: jsonEncode(catatan.toJson()),
      );

      if (response.statusCode == 201) {
        return 'Data berhasil disimpan';
      } else if (response.statusCode == 401) {
        // Token expired
        throw Exception('Sesi telah berakhir. Silakan login kembali.');
      } else {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['error'] ?? 'Gagal menambahkan catatan');
      }
    } catch (e) {
      print('Error: $e'); // Debugging
      rethrow;
    }
  }

  // Method untuk mendapatkan semua catatan gula darah
  Future<List<CatatanGulaDarah>> getCatatanGulaDarah() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/gula_darah/terakhir'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        // Convert dynamic map to Map<String, dynamic>
        if (responseBody is Map) {
          final Map<String, dynamic> typedMap =
              Map<String, dynamic>.from(responseBody);
          return [CatatanGulaDarah.fromJson(typedMap)];
        } else if (responseBody is List) {
          return responseBody
              .map((json) =>
                  CatatanGulaDarah.fromJson(Map<String, dynamic>.from(json)))
              .toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Sesi telah berakhir. Silakan login kembali.');
      } else {
        throw Exception('Gagal mengambil data catatan gula darah');
      }
    } catch (e) {
      print('Error getting records: $e');
      rethrow;
    }
  }

  Future<String> tambahCatatanHbA1c(CatatanHbA1c catatan) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/hba1c'),
        headers: await _getHeaders(),
        body: jsonEncode(catatan.toJson()),
      );

      if (response.statusCode == 201) {
        return 'Data HbA1c berhasil disimpan';
      } else if (response.statusCode == 401) {
        throw Exception('Sesi telah berakhir. Silakan login kembali.');
      } else {
        final responseData = jsonDecode(response.body);
        throw Exception(
            responseData['error'] ?? 'Gagal menambahkan catatan HbA1c');
      }
    } catch (e) {
      print('Error: $e'); // Debugging
      rethrow;
    }
  }

  Future<CatatanHbA1c> getHba1cTerakhir() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/hba1c/terakhir'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        // Check for null or empty response
        if (responseBody == null || responseBody.isEmpty) {
          return CatatanHbA1c(
              createdAt: DateTime.now().toIso8601String(), hba1c: 0.0);
        }

        // Ensure responseBody is a Map before parsing
        if (responseBody is Map) {
          return CatatanHbA1c.fromJson(responseBody);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Gagal mengambil data HbA1c');
      }
    } catch (e) {
      print('Error getting HbA1c: $e');
      return CatatanHbA1c(
          createdAt: DateTime.now().toIso8601String(), hba1c: 0.0);
    }
  }
}
