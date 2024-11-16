import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/login_service.dart';
import '../model/user_model.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final LoginService _loginService = LoginService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final response = await _loginService.login(
          email: emailController.text,
          password: passwordController.text,
        );

        // // Store user data (you might want to use shared preferences or secure storage)
        // Get.find<UserCo>().setUser(response);

        Get.snackbar(
          "Success",
          "Login successful!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(AppRoutes.home);
      } catch (error) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
