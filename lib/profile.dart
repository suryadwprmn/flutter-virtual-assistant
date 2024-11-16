import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/model/user_model.dart';
import '../controllers/login_controller.dart';
import '../services/auth_service.dart';
import 'model/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  final AuthService _authService = AuthService();
  final LoginController _loginController = Get.find<LoginController>();

  late Future<UserModel> _userProfile;

  @override
  void initState() {
    super.initState();
    _userProfile = _fetchProfile();
  }

  Future<UserModel> _fetchProfile() async {
    return await _authService.getProfile(_loginController.token);
  }

  // Custom bottom nav item builder for improved visual feedback on selected state
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
              fontWeight: FontWeight.w500,
              color: isSelected ? const Color(0xFF1a237e) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xff113499),
      ),
      body: FutureBuilder<UserModel>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Name: ${user.name ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Email: ${user.email ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Gender: ${user.gender ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Diabetes Category: ${user.diabetesCategory ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Phone: ${user.phone ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("No profile data available."),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem('assets/Home.png', 'Beranda', false, '/home'),
            _buildNavItem('assets/Customer.png', 'Profile', true, '/profile'),
          ],
        ),
      ),
    );
  }
}
