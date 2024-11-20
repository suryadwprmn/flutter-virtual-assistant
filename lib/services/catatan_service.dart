import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
        Uri.parse('$_baseUrl/gula_darah'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData
            .map((json) => CatatanGulaDarah.fromJson(json))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('Sesi telah berakhir. Silakan login kembali.');
      } else {
        throw Exception('Gagal mengambil data catatan gula darah');
      }
    } catch (e) {
      print('Error getting records: $e'); // Debugging
      rethrow;
    }
  }

  // Method untuk mendapatkan catatan gula darah berdasarkan tanggal
  Future<List<CatatanGulaDarah>> getCatatanByTanggal(String tanggal) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/gula_darah/tanggal/$tanggal'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData
            .map((json) => CatatanGulaDarah.fromJson(json))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('Sesi telah berakhir. Silakan login kembali.');
      } else {
        throw Exception('Gagal mengambil data catatan untuk tanggal tersebut');
      }
    } catch (e) {
      print('Error getting records by date: $e'); // Debugging
      rethrow;
    }
  }
}
