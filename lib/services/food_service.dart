import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/food_model.dart';

class FoodService {
  static const String baseUrl =
      'http://ox-nearby-kangaroo.ngrok-free.app/api/search_food';

  Future<List<FoodModel>> searchFood(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?query=$query'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];
        return data.map((item) => FoodModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load food data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching food: $e');
    }
  }
}
