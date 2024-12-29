import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:virtual_assistant/controllers/register_controller.dart';
import 'package:virtual_assistant/auth/register.dart';

class MockRegisterController extends Mock implements RegisterController {
  @override
  final formKey = GlobalKey<FormState>();
  @override
  final nameController = TextEditingController();
  @override
  final emailController = TextEditingController();
  @override
  final passwordController = TextEditingController();
  @override
  final phoneController = TextEditingController();
  @override
  String? selectedGender;
  @override
  String? selectedDiabetesCategory;

  @override
  bool validateName(String name) =>
      name.isNotEmpty && RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
  @override
  bool validateEmail(String email) =>
      email.isNotEmpty && email.contains('@gmail.com');
  @override
  bool validatePassword(String password) => password.length > 6;
  @override
  void setPhone(String phone) {}
  // Updated to match the original method signature
  @override
  Future<void> registerUser() async {}
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

  testWidgets('Register screen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      GetMaterialApp(
        home: Register(),
      ),
    );

    // Verify that the register screen has key elements
    expect(find.byType(Image), findsNWidgets(2)); // Logo and wave image
    expect(find.text('Nama'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);
    expect(find.text('Jenis Kelamin'), findsOneWidget);
    expect(find.text('Kategori Diabetes'), findsOneWidget);
    expect(find.text('Nomor Telepon'), findsOneWidget);
    expect(find.text('Buat Akun'), findsOneWidget);
    expect(find.text('Sudah punya akun? Login'), findsOneWidget);
  });

  testWidgets('Dropdown selections work', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      GetMaterialApp(
        home: Register(),
      ),
    );

    // Open gender dropdown
    await tester.tap(find.text('Jenis Kelamin'));
    await tester.pumpAndSettle();

    // Select 'Laki-laki'
    await tester.tap(find.text('Laki-laki').last);
    await tester.pumpAndSettle();

    // Open diabetes category dropdown
    await tester.tap(find.text('Kategori Diabetes'));
    await tester.pumpAndSettle();

    // Select 'Diabetes 1'
    await tester.tap(find.text('Diabetes 1').last);
    await tester.pumpAndSettle();
  });

  testWidgets('Input fields accept correct input', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      GetMaterialApp(
        home: Register(),
      ),
    );

    // Enter valid name
    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');

    // Enter valid email
    await tester.enterText(
        find.byType(TextFormField).at(1), 'johndoe@gmail.com');

    // Enter valid password
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');

    // Enter valid phone number
    await tester.enterText(find.byType(TextFormField).at(3), '081234567890');

    await tester.pump();

    // Verify entered values
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('johndoe@gmail.com'), findsOneWidget);
    expect(find.text('081234567890'), findsOneWidget);
  });
}

// Mock Navigator for route testing
class MockNavigator extends Mock implements GetxController {}
