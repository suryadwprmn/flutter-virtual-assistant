import 'package:get/get.dart';
import 'package:virtual_assistant/auth/forgot-password.dart';
import 'package:virtual_assistant/auth/login.dart';
import 'package:virtual_assistant/auth/register.dart';
import 'package:virtual_assistant/beranda.dart';
import 'package:virtual_assistant/catatan_kesehatan.dart';
import 'package:virtual_assistant/chatbot_page.dart';
import 'package:virtual_assistant/deteksi.dart';
import 'package:virtual_assistant/grafik.dart';
import 'package:virtual_assistant/layout/second_step.dart';
import 'package:virtual_assistant/layout/third_step.dart';
import 'package:virtual_assistant/notifikasi.dart';
import 'package:virtual_assistant/profile.dart';
import 'package:virtual_assistant/sentimen_page.dart';
import 'package:virtual_assistant/splash_profile.dart';
import 'package:virtual_assistant/splash_screen.dart';
import 'package:virtual_assistant/layout/first_step.dart';

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
  static const about = '/about';
  static const sentimen = '/sentimen';
  static const forgot_password = '/forgot-password';
  static const chat = '/chat';
  static const feedback = '/feedback';
  static const settings = '/settings';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => const Login()),
    GetPage(name: register, page: () => Register()),
    GetPage(name: first_step, page: () => FirstStep()),
    GetPage(name: second_step, page: () => const TwoStep()),
    GetPage(name: third_step, page: () => const ThirdStep()),
    GetPage(name: home, page: () => const Beranda()),
    GetPage(name: forgot_password, page: () => const ForgotPassword()),
    GetPage(name: chat, page: () => const ChatbotPage()),
    GetPage(name: feedback, page: () => const SentimenPage()),
    GetPage(name: settings, page: () => Setting()),
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
