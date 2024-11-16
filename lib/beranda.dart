import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/routes/app_routes.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                  padding: const EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/logo3.png',
                      width: 186,
                      height: 70,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20, right: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Welcome text section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo Divister!!',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff113499),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Bagaimana keadaanmu hari ini,\ncek gula hari ini yuk??',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Doctor image
                      Image.asset(
                        'assets/davi-kiri.png',
                        height: 180,
                        width: 150,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Blue Card Container with fixed height and width
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: const Color(0xFF113499),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildMenuItem(context, 'assets/mie.png',
                            'Penghitung\nnutrisi', AppRoutes.deteksi),
                        _buildMenuItem(context, 'assets/book.png',
                            'Catatan\nKesehatan', AppRoutes.catatan_kesehatan),
                        _buildMenuItem(context, 'assets/notification.png',
                            'Notifikasi', AppRoutes.notifikasi),
                        _buildMenuItem(context, 'assets/grafik.png', 'Grafik',
                            AppRoutes.grafik),
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

  Widget _buildMenuItem(
      BuildContext context, String iconPath, String label, String route) {
    return InkWell(
      onTap: () {
        Get.toNamed(route);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 32,
              height: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
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
}
