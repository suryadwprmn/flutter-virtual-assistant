import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff113499),
      body: Padding(
        padding: const EdgeInsets.only(top: 279),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 200,
                height: 195,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 93, right: 93),
              child: Text('“Diabetes Virtual Assistant”',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Text('Powered by DIVISTANT',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
