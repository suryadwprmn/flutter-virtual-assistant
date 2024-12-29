import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_assistant/model/user_model.dart'; 

void main() {
  group('UserModel Tests', () {
    test('fromJson should correctly create a UserModel instance', () {
      // Contoh data JSON
      final json = {
        'name': 'John Doe',
        'email': 'john@example.com',
        'password': 'securepassword',
        'gender': 'male',
        'diabetes_category': 'type2',
        'phone': '123456789',
        'access_token': 'abcdef123456',
      };

      // Membuat objek UserModel dari JSON
      final user = UserModel.fromJson(json);

      // Verifikasi apakah data dari JSON di-convert dengan benar ke dalam objek
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'securepassword');
      expect(user.gender, 'male');
      expect(user.diabetesCategory, 'type2');
      expect(user.phone, '123456789');
      expect(user.accessToken, 'abcdef123456');
    });

    test('toJson should correctly convert UserModel to JSON', () {
      // Membuat objek UserModel
      final user = UserModel(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'securepassword',
        gender: 'male',
        diabetesCategory: 'type2',
        phone: '123456789',
        accessToken: 'abcdef123456',
      );

      // Mengonversi objek UserModel ke JSON
      final json = user.toJson();

      // Verifikasi bahwa JSON berisi data yang benar
      expect(json['name'], 'John Doe');
      expect(json['email'], 'john@example.com');
      expect(json['password'], 'securepassword');
      expect(json['gender'], 'male');
      expect(json['diabetes_category'], 'type2');
      expect(json['phone'], '123456789');
      expect(json['access_token'], 'abcdef123456');
    });

    test('toJson should exclude access_token if it is null', () {
      // Membuat objek UserModel dengan accessToken null
      final user = UserModel(
        name: 'John Doe',
        email: 'john@gmail.com',
        password: 'securepassword',
        gender: 'male',
        diabetesCategory: 'type2',
        phone: '123456789',
        accessToken: null,
      );

      // Mengonversi objek UserModel ke JSON
      final json = user.toJson();

      // Verifikasi bahwa access_token tidak ada dalam JSON
      expect(json.containsKey('access_token'), false);
    });
  });
}
