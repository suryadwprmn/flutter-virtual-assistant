import 'package:get/get.dart';
import 'package:virtual_assistant/auth/login.dart';
import 'package:virtual_assistant/auth/register.dart';
import 'package:virtual_assistant/splash_screen.dart';
import 'package:virtual_assistant/layout/first_step.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const register = '/register';
  static const first_step = '/first_step';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => Login()),
    GetPage(name: register, page: () => Register()),
  ];
}
