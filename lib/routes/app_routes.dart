import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/auth/login.dart';
import 'package:virtual_assistant/auth/register.dart';
import 'package:virtual_assistant/beranda.dart';
import 'package:virtual_assistant/catatan_kesehatan.dart';
import 'package:virtual_assistant/deteksi.dart';
import 'package:virtual_assistant/grafik.dart';
import 'package:virtual_assistant/layout/second_step.dart';
import 'package:virtual_assistant/layout/third_step.dart';
import 'package:virtual_assistant/notifikasi.dart';
import 'package:virtual_assistant/profile.dart';
import 'package:virtual_assistant/splash_screen.dart';
import 'package:virtual_assistant/layout/first_step.dart';
import '../middleware/auth_middleware.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const register = '/register';
  static const first_step = '/first_step';
  static const second_step = '/second_step';
  static const third_step = '/third_step';
  static const profile = '/profile';
  static const deteksi = '/deteksi';
  static const catatan_kesehatan = '/kesehatan';
  static const notifikasi = '/notifikasi';
  static const grafik = '/grafik';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => const Login()),
    GetPage(name: register, page: () => Register()),
    GetPage(name: first_step, page: () => FirstStep()),
    GetPage(name: second_step, page: () => const TwoStep()),
    GetPage(name: third_step, page: () => const ThirdStep()),
    GetPage(name: home, page: () => const Beranda()),
    GetPage(
      name: profile,
      page: () => const Profile(),
      // middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: deteksi,
      page: () => const Deteksi(),
      //    middlewares: [AuthMiddleware()]),
    ),
    GetPage(
      name: catatan_kesehatan,
      page: () => const CatatanKesehatan(),
      // middlewares: [AuthMiddleware()]),
    ),
    GetPage(
      name: notifikasi,
      page: () => const Notifikasi(),
      // middlewares: [AuthMiddleware()]),
    ),
    GetPage(
      name: grafik,
      page: () => const Grafik(),
      // middlewares: [AuthMiddleware()]),
    )
  ];
}
