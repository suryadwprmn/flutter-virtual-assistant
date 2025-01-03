import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/routes/app_routes.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  Future<void> _logout() async {
    bool? confirmLogout = await showDialog<bool>(
      context: Get.overlayContext!,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      Get.offAllNamed(
          AppRoutes.login); // Menyelesaikan logout dan menuju ke halaman login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff113499),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                Icon(Icons.account_circle, color: Colors.grey[700], size: 100),
                const SizedBox(height: 30),
                _buildListItem(
                  icon: Icons.edit,
                  label: 'Edit Profile',
                  onTap: () {
                    Get.toNamed(AppRoutes.profile);
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                _buildListItem(
                  icon: Icons.feedback,
                  label: 'Ulasan',
                  onTap: () {
                    Get.toNamed(AppRoutes.feedback);
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                _buildListItem(
                  icon: Icons.logout,
                  label: 'Logout',
                  onTap: _logout, // Memanggil fungsi logout
                ),
              ],
            ),
          ),
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
                      'assets/Home.png', 'Beranda', false, AppRoutes.home),
                  _buildNavItem('assets/Customer.png', 'Profile', true,
                      AppRoutes.settings),
                  // _buildNavItem('assets/contract.png', 'Setting', false,
                  //     AppRoutes.),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey[700],
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
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
        mainAxisAlignment:
            MainAxisAlignment.center, // Menambahkan center alignment
        crossAxisAlignment:
            CrossAxisAlignment.center, // Menambahkan center alignment
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: isSelected ? const Color(0xFF1a237e) : Colors.grey,
          ),
          const SizedBox(height: 2), // Mengurangi jarak antara icon dan label
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
