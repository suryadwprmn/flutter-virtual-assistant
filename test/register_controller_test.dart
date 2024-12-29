import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/controllers/register_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late RegisterController controller;

  setUp(() {
    controller = RegisterController();
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

  group('Gender validation', () {
    test('should set gender to Laki-laki when selected', () {
      controller.setGender('Laki-laki');
      expect(controller.selectedGender, 'Laki-laki');
    });

    test('should set gender to Perempuan when selected', () {
      controller.setGender('Perempuan');
      expect(controller.selectedGender, 'Perempuan');
    });
  });

  group('Diabetes Category validation', () {
    test('should set diabetes category to Non Diabetes when selected', () {
      controller.setDiabetesCategory('Non Diabetes');
      expect(controller.selectedDiabetesCategory, 'Non Diabetes');
    });

    test('should set diabetes category to Diabetes 1 when selected', () {
      controller.setDiabetesCategory('Diabetes 1');
      expect(controller.selectedDiabetesCategory, 'Diabetes 1');
    });

    test('should set diabetes category to Diabetes 2 when selected', () {
      controller.setDiabetesCategory('Diabetes 2');
      expect(controller.selectedDiabetesCategory, 'Diabetes 2');
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
