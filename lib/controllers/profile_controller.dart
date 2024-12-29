import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/model/user_model.dart';
import '../services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController diabetesCategoryController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late UserModel userProfile;

  // Validation functions
  bool validateName(String name) {
    return name.isNotEmpty &&
        name.length >= 3 &&
        !RegExp(r'[0-9]').hasMatch(name);
  }

  bool validateEmail(String email) {
    return email.isNotEmpty &&
        email.contains('@') &&
        email.endsWith('@gmail.com');
  }

  bool validatePassword(String password) {
    return password.length >= 6;
  }

  // Functions to set fields
  void setGender(String gender) {
    genderController.text = gender;
    update();
  }

  void setDiabetesCategory(String category) {
    diabetesCategoryController.text = category;
    update();
  }

  void setPhone(String phone) {
    if (RegExp(r'^[0-9]+$').hasMatch(phone) &&
        phone.length >= 12 &&
        phone.length <= 13) {
      phoneController.text = phone;
      update();
    }
  }

  Future<void> fetchProfile(String token) async {
    try {
      userProfile = await _authService.getProfile(token);
      nameController.text = userProfile.name ?? '';
      emailController.text = userProfile.email ?? '';
      genderController.text = userProfile.gender ?? '';
      diabetesCategoryController.text = userProfile.diabetesCategory ?? '';
      phoneController.text = userProfile.phone ?? '';
      update();
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> saveChanges(String token) async {
    // Validate password update if provided
    if (newPasswordController.text.isNotEmpty) {
      if (newPasswordController.text != confirmPasswordController.text) {
        Get.snackbar("Gagal", "Konfirmasi password tidak cocok",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
    }

    try {
      // Update profile information
      await _authService.updateProfile(
        token: token,
        name: nameController.text,
        gender: genderController.text,
        diabetesCategory: diabetesCategoryController.text,
        phone: phoneController.text,
        // Only send password if a new password is provided
        password: newPasswordController.text.isNotEmpty
            ? newPasswordController.text
            : null,
      );

      Get.snackbar("Berhasil", "Profil dan password berhasil diperbarui",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      // Clear password fields after successful update
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      Get.snackbar("Gagal", "Gagal memperbarui profil",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
