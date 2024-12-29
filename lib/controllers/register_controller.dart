import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class RegisterController extends GetxController {
  // Tambahkan variabel untuk status pendaftaran
  RxBool isRegistering = false.obs;
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
      isRegistering.value = true;
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

  // Fungsi validasi name
  bool validateName(String name) {
    return name.isNotEmpty &&
        name.length >= 3 &&
        !RegExp(r'[0-9]').hasMatch(name);
  }

  // Fungsi validasi email
  bool validateEmail(String email) {
    return email.isNotEmpty &&
        email.contains('@') &&
        email.endsWith('@gmail.com');
  }

  // Fungsi validasi password
  bool validatePassword(String password) {
    return password.length >= 6;
  }

  //Fungsi untuk menetapkan gender
  void setGender(String gender) {
    selectedGender = gender;
    update();
  }

  //Fungsi untuk menetapkan diabetes category
  void setDiabetesCategory(String category) {
    selectedDiabetesCategory = category;
    update();
  }

  // Fungsi untuk menetapkan phone hanya jika berupa angka dan panjangnya 12-13 digit
  void setPhone(String phone) {
    // Validasi untuk memastikan hanya angka yang diterima dan panjangnya antara 12-13 karakter
    if (RegExp(r'^[0-9]+$').hasMatch(phone) &&
        phone.length >= 12 &&
        phone.length <= 13) {
      phoneController.text = phone;
      update();
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
