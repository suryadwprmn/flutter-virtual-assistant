import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/controllers/profile_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProfileController controller;

  setUp(() {
    controller = ProfileController();
    Get.testMode = true;
  });

  test('should validate name correctly', () {
    // Valid name
    expect(controller.validateName('John Doe'), true);
    // Invalid name with numbers
    expect(controller.validateName('John123'), false);
    // Invalid empty name
    expect(controller.validateName(''), false);
  });
  group('Password Validation', () {
    test('should return true for valid password', () {
      expect(controller.validatePassword('password123'), true);
    });

    test('should return false for password with less than 6 characters', () {
      expect(controller.validatePassword('123'), false);
    });
  });

  group('Phone validation', () {
    test('should set phone correctly when valid', () {
      controller.setPhone('081234567890');
      expect(controller.phoneController.text, '081234567890');
    });

    test('should show error when phone is invalid (too short)', () {
      controller.setPhone('08123456789'); // too short
      expect(controller.phoneController.text, ''); // no update
    });

    test('should show error when phone is invalid (contains non-numeric)', () {
      controller.setPhone('08123abc567890'); // contains non-numeric
      expect(controller.phoneController.text, ''); // no update
    });

    test('should show error when phone is invalid (too long)', () {
      controller.setPhone('081234567890123'); // too long
      expect(controller.phoneController.text, ''); // no update
    });
  });
}
