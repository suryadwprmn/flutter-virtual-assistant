import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  var isLoading = false.obs;

  Future<void> sendResetPasswordEmail() async {
    isLoading.value = true;
    try {
      final message =
          await _authService.requestResetPassword(emailController.text.trim());
      Get.snackbar('Success', message, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
