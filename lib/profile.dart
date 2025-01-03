import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/model/user_model.dart';
import '../controllers/login_controller.dart';
import '../services/auth_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  final AuthService _authService = AuthService();
  final LoginController _loginController = Get.find<LoginController>();

  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'gender': TextEditingController(),
    'diabetesCategory': TextEditingController(),
    'phone': TextEditingController(),
    'newPassword': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };

  late Future<UserModel> _userProfile;

  @override
  void initState() {
    super.initState();
    _userProfile = _fetchProfile();
  }

  // Fungsi validasi nama
  bool validateName(String name) {
    return name.isNotEmpty &&
        name.length >= 3 &&
        !RegExp(r'[0-9]').hasMatch(name);
  }

  // Fungsi validasi password
  bool validatePassword(String password) {
    // Misalnya password harus memiliki minimal 8 karakter dan mengandung angka serta huruf
    return password.isNotEmpty &&
        password.length >= 6 &&
        RegExp(r'(?=.*[0-9])(?=.*[a-zA-Z])').hasMatch(password);
  }

// Fungsi validasi nomor telepon
  bool validatePhone(String phone) {
    // Validasi nomor telepon dengan format angka 10 hingga 13 digit
    return RegExp(r'^\d{10,13}$').hasMatch(phone);
  }

  Future<void> _logout() async {
    bool? confirmLogout = await showDialog<bool>(
      context: context,
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
      await _authService.logout();
      Get.offAllNamed('/login');
    }
  }

  Future<UserModel> _fetchProfile() async {
    final user = await _authService.getProfile(_loginController.token);
    setState(() {
      _controllers['name']!.text = user.name ?? '';
      _controllers['email']!.text = user.email ?? '';
      _controllers['gender']!.text = user.gender ?? '';
      _controllers['diabetesCategory']!.text = user.diabetesCategory ?? '';
      _controllers['phone']!.text = user.phone ?? '';
    });
    return user;
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _saveChanges() async {
    // Validasi nama
    if (!validateName(_controllers['name']!.text)) {
      Get.snackbar("Gagal",
          "Nama harus terdiri dari minimal 3 karakter dan tidak mengandung angka",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    // Validasi nomor telepon
    if (!validatePhone(_controllers['phone']!.text)) {
      Get.snackbar("Gagal", "Nomor telepon tidak valid.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    // Validasi password update jika diberikan
    if (_controllers['newPassword']!.text.isNotEmpty) {
      // Validasi password
      if (!validatePassword(_controllers['newPassword']!.text)) {
        Get.snackbar("Gagal",
            "Password harus memiliki minimal 6 karakter, termasuk angka dan huruf.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }

      if (_controllers['newPassword']!.text !=
          _controllers['confirmPassword']!.text) {
        Get.snackbar("Gagal", "Konfirmasi password tidak cocok",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
    }

    try {
      // Update profil informasi
      await _authService.updateProfile(
        token: _loginController.token,
        name: _controllers['name']!.text,
        gender: _controllers['gender']!.text,
        diabetesCategory: _controllers['diabetesCategory']!.text,
        phone: _controllers['phone']!.text,
        // Hanya kirim password jika ada password baru yang diberikan
        password: _controllers['newPassword']!.text.isNotEmpty
            ? _controllers['newPassword']!.text
            : null,
      );

      Get.snackbar("Berhasil", "Profil dan password berhasil diperbarui",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      // Clear password fields setelah update berhasil
      _controllers['newPassword']!.clear();
      _controllers['confirmPassword']!.clear();

      // Segarkan data profil
      setState(() {
        _userProfile = _fetchProfile();
      });
    } catch (e) {
      Get.snackbar("Gagal", "Gagal memperbarui profil",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isReadOnly = false,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: isReadOnly ? Colors.grey.shade300 : Colors.white,
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String selectedValue,
    required List<String> options,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue.isEmpty ? null : selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: options
            .map((option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil Pengguna",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff113499),
       
      ),
      body: FutureBuilder<UserModel>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: Icon(
                        Icons.account_circle,
                        size: 100,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _buildInputField(
                        label: "Nama", controller: _controllers['name']!),
                    _buildInputField(
                        label: "Email",
                        controller: _controllers['email']!,
                        isReadOnly: true),
                    _buildDropdownField(
                      label: "Jenis Kelamin",
                      selectedValue: _controllers['gender']!.text,
                      options: ["Laki-laki", "Perempuan"],
                      onChanged: (value) {
                        setState(() {
                          _controllers['gender']!.text = value ?? '';
                        });
                      },
                    ),
                    _buildDropdownField(
                      label: "Kategori Diabetes",
                      selectedValue: _controllers['diabetesCategory']!.text,
                      options: ["Non Diabetes", "Diabetes 1", "Diabetes 2"],
                      onChanged: (value) {
                        setState(() {
                          _controllers['diabetesCategory']!.text = value ?? '';
                        });
                      },
                    ),
                    _buildInputField(
                      label: "Nomor Telepon",
                      controller: _controllers['phone']!,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildInputField(
                      label: "Password Baru",
                      controller: _controllers['newPassword']!,
                      obscureText: true,
                    ),
                    _buildInputField(
                      label: "Konfirmasi Password",
                      controller: _controllers['confirmPassword']!,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff113499),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Simpan Perubahan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("Tidak ada data profil."),
            );
          }
        },
      ),
    );
  }
}
