import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/controllers/login_controller.dart';

import 'package:virtual_assistant/routes/app_routes.dart';

void main() {
  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Menggunakan GetMaterialApp
      title: 'Virtual Assistant',
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Virtual Assistant',
  //     home: FirstStep(),
  //   );
  // }
}
