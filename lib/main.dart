import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/auth/login.dart';
import 'package:virtual_assistant/auth/register.dart';
import 'package:virtual_assistant/routes/app_routes.dart';
import 'package:virtual_assistant/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return GetMaterialApp(
  //     title: 'Divistant',
  //     debugShowCheckedModeBanner: false,
  //     initialRoute: AppRoutes.splash,
  //     getPages: AppRoutes.routes,

  //     /// [Transition.fadeIn].
  //     ///
  //     /// This widget is the root of the application.
  //     defaultTransition: Transition.fadeIn,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtual Assistant',
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home : first_step,
  //   );
  // }
}
