import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_assistant/routes/app_routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar wave di bagian atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/wave-atas.png', width: double.infinity),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Image.asset('assets/logo2.png', height: 87, width: 85),
                const SizedBox(height: 46),
                Text('LOGIN',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff113499),
                    )),
                const SizedBox(height: 65),
                const TextField(
                  decoration: InputDecoration(labelText: 'Nama'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(labelText: 'Kata Sandi'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.home);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(166, 27),
                    backgroundColor: const Color(0xff113499),
                  ),
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  child: Text(
                    'belum punya akun? Daftar',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  'Atau login menggunakan',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Login menggunakan Google
                  },
                  icon: const Icon(Icons.login, color: Colors.blue),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Image.asset('assets/wave-bawah.png', width: double.infinity),
          // ),
        ],
      ),
    );
  }
}
