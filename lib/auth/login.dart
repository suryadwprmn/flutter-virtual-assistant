import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_assistant/routes/app_routes.dart';

class Login extends StatefulWidget {
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
                Spacer(flex: 2),
                Image.asset('assets/logo2.png', height: 87, width: 85),
                SizedBox(height: 46),
                Text('LOGIN',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff113499),
                    )),
                SizedBox(height: 65),
                TextField(
                  decoration: InputDecoration(labelText: 'Nama'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Kata Sandi'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Panggil fungsi login
                  },
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(166, 27),
                    backgroundColor:
                        Color(0xff113499), // Warna latar belakang tombol
                  ),
                ),
                SizedBox(height: 40),
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
                  icon: Icon(Icons.login, color: Colors.blue),
                ),
                Spacer(flex: 2),
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
