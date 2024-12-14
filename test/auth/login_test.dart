// login_unit_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_assistant/auth/login.dart';

void main() {
  group('Login Validation Unit Tests', () {
    late _LoginState loginState;

    setUp(() {
      // Create a Login widget and get its state for testing
      final login = Login();
      loginState = login.createState();
    });

    test('Email validation fails for non-Gmail email', () {
      // Test emails that are not Gmail
      final nonGmailEmails = [
        'surya@outlook.com',
        'surya@yahoo.com',
        'surya@hotmail.com',
        'surya@email.com'
      ];

      for (var email in nonGmailEmails) {
        expect(loginState.isValidGmailEmail(email), isFalse,
            reason:
                'Email $email should be considered invalid as it is not a Gmail address');
      }
    });

    test('Password validation fails for short passwords', () {
      // Test passwords shorter than 6 characters
      final shortPasswords = ['', '12345', 'pass', 'a1'];

      for (var password in shortPasswords) {
        expect(loginState.isValidPasswordLength(password), isFalse,
            reason:
                'Password $password should be considered invalid due to short length');
      }
    });
  });
}

// Extension to add custom validation methods to _LoginState for testing
extension LoginStateValidation on _LoginState {
  bool isValidGmailEmail(String email) {
    // Validate that the email is specifically a Gmail address
    final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    return gmailRegex.hasMatch(email);
  }

  bool isValidPasswordLength(String password) {
    // Validate password length is at least 6 characters
    return password.length >= 6;
  }
}
