import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  // Variables for dropdown selections
  String? selectedGender;
  String? selectedDiabetesCategory;

  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      try {
        UserModel newUser = UserModel(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          gender: selectedGender!,
          diabetesCategory: selectedDiabetesCategory!,
          phone: phoneController.text,
        );

        final response = await _authService.register(newUser);
        Get.snackbar("Success", "User registered successfully!");

        // Kirim data user ke FirstStep
        Get.toNamed(AppRoutes.first_step, arguments: {
          'name': nameController.text,
        });

        clearForm();
      } catch (error) {
        Get.snackbar("Error", error.toString());
      }
    }
  }

  // Function to clear form fields
  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    selectedGender = null;
    selectedDiabetesCategory = null;

    update();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
