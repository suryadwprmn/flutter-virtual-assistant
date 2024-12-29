import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:virtual_assistant/controllers/login_controller.dart';
import 'package:virtual_assistant/auth/login.dart';

// Mock LoginController
class MockLoginController extends Mock implements LoginController {
  @override
  final formKey = GlobalKey<FormState>();
  @override
  final emailController = TextEditingController();
  @override
  final passwordController = TextEditingController();

  @override
  bool validateEmail(String email) =>
      email.isNotEmpty && email.contains('@gmail.com');
  @override
  bool validatePassword(String password) => password.length >= 6;

  @override
  Future<void> loginUser() async {
    // Mock implementation for login
  }
}

void main() {
  setUp(() {
    // Initialize GetX navigation for testing
    Get.testMode = true;
  });

  tearDown(() {
    // Reset GetX test mode after each test
    Get.reset();
  });

  testWidgets('Login screen renders correctly', (WidgetTester tester) async {
    // Build the Login screen and trigger a frame
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Login(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify key elements in the Login screen

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);
    // Find the ElevatedButton using the key.
    final loginButton = find.byKey(const Key('loginButton'));

    expect(loginButton, findsOneWidget);
  });

  testWidgets('Input fields accept correct input', (WidgetTester tester) async {
    // Build the Login screen and trigger a frame
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Login(),
      ),
    );

    // Enter valid email
    await tester.enterText(find.byKey(const Key('emailField')), 'johndoe@gmail.com');
    // Enter valid password
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');

    await tester.pump();

    // Verify entered values
    expect(find.text('johndoe@gmail.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });
}
