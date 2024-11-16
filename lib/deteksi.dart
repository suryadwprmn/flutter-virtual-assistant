import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/routes/app_routes.dart';

class Deteksi extends StatelessWidget {
  const Deteksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background wave
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/wave-atas2.png', width: double.infinity),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Header section with logo
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/logo3.png',
                      width: 186,
                      height: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Center content with instruction and upload area
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Cek kadar gula makananmu sekarang!',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add, size: 48, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFF1a237e), // Updated to `backgroundColor`
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Upload File'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                      'assets/Home.png', 'Beranda', true, AppRoutes.home),
                  _buildNavItem('assets/Customer.png', 'Profile', false,
                      AppRoutes.profile),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildNavItem(
    String iconPath, String label, bool isSelected, String route) {
  return InkWell(
    onTap: () {
      Get.toNamed(route);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconPath,
          width: 24,
          height: 24,
          color: isSelected ? const Color(0xFF1a237e) : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? const Color(0xFF1a237e) : Colors.grey,
          ),
        ),
      ],
    ),
  );
}
