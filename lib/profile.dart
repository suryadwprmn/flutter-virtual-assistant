import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/routes/app_routes.dart'; // Pastikan AppRoutes diimpor

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'This is the Profile Page',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

          // Bottom Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                  'assets/Home.png', 'Beranda', false, AppRoutes.home),
              _buildNavItem(
                  'assets/Customer.png', 'Profile', true, AppRoutes.profile),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      String iconPath, String label, bool isSelected, String route) {
    return InkWell(
      onTap: () {
        if (!isSelected) {
          // Prevents navigation if already selected
          Get.toNamed(route);
        }
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
