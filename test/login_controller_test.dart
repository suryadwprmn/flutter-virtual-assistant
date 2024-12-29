import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/controllers/login_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LoginController controller;

  setUp(() {
    controller = LoginController();
    Get.testMode = true;
  });

  

  group('Email Validation', () {
    //Email menggunakan gmail -> true
    test('should return true for valid Gmail address', () {
      expect(controller.validateEmail('test@gmail.com'), true);
    });

    //Email tidak menggunakan gmail -> false
    test('should return false for non-Gmail address', () {
      expect(controller.validateEmail('test@yahoo.com'), false);
    });

    //Email tidak memiliki @ symbol -> false
    test('should return false for email without @ symbol', () {
      expect(controller.validateEmail('invalidemail.com'), false);
    });

    //Email kosong -> false
    test('should return false for empty email', () {
      expect(controller.validateEmail(''), false);
    });
  });

  group('Password Validation', () {
    test('should return true for valid password', () {
      expect(controller.validatePassword('password123'), true);
    });

    test('should return false for password with less than 6 characters', () {
      expect(controller.validatePassword('123'), false);
    });
  });
}
