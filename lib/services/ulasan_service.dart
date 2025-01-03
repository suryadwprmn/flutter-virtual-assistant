import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/review_model.dart';

class ApiService {
  final String baseUrl = 'https://ox-nearby-kangaroo.ngrok-free.app//api';

  // Fungsi untuk menambah review baru
  Future<Review?> addReview(Review review) async {
    final url = Uri.parse('$baseUrl/add_review');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(review.toJson()),
      );

      // Cek status code
      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        // Parsing response JSON ke objek Review
        return Review.fromJson(responseData['review']);
      } else {
        // Jika gagal, tampilkan pesan error
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
