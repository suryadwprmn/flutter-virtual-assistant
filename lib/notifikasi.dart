import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/routes/app_routes.dart'; // Import app_routes

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Wave background at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'assets/wave-atas2.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          // Content Column
          Column(
            children: [
              // Header section with back button and logo
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 1),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.toNamed(AppRoutes
                          .home), // Menggunakan Get.toNamed untuk navigasi
                    ),
                    Image.asset(
                      'assets/logo3.png',
                      width: 185,
                      height: 80,
                    ),
                  ],
                ),
              ),

              // Expanded to push the center content to middle
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5271FF),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Belum ada Notifikasi',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5271FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'nih dari Davi',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5271FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
