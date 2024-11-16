import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'package:flutter/material.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final LoginController loginController = Get.find<LoginController>();

    // Cek apakah token ada dan valid
    if (loginController.token.isEmpty) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
