import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../controllers/login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // TextEditingController untuk form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // GlobalKey untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Loading state
  bool _isLoading = false;

  // Instansiasi AuthService dan LoginController
  final AuthService _authService = AuthService();
  final LoginController _loginController = Get.put(LoginController());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk menangani login
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Panggil login dan dapatkan UserModel
        final user = await _authService.login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Simpan accessToken ke LoginController
        if (user.accessToken != null) {
          _loginController.setToken(user.accessToken!);

          // Navigasi ke halaman home
          Get.offAllNamed(AppRoutes.home);

          // Tampilkan pesan sukses
          Get.snackbar(
            'Success',
            'Welcome ${user.name}!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          throw Exception("Access token is missing");
        }
      } catch (e) {
        // Tampilkan pesan error
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
                key: const Key('Image'),
                'assets/wave-atas.png',
                width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Image.asset('assets/logo2.png', height: 87, width: 85),
                  const SizedBox(height: 46),
                  Text(
                    'LOGIN',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff113499),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    key: const Key('emailField'),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff113499)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff113499)),
                      ),
                      // Border error dengan warna merah saat terjadi kesalahan
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      // Focused error border dengan warna merah saat terjadi kesalahan
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .red), // Warna border error merah saat fokus
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (!_loginController.validateEmail(email ?? '')) {
                        return 'Email tidak valid';
                      }
                      return null; // Valid
                    },
                  ),
                  const SizedBox(height: 10),
                  // Password TextFormField dengan validasi
                  TextFormField(
                    key: const Key('passwordField'),
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Kata Sandi',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (password) {
                      if (!_loginController.validatePassword(password ?? '')) {
                        return 'Password minimal 6 karakter';
                      }
                      return null; // Valid
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.forgot_password);
                        },
                        child: Text(
                          'Lupa Password?',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xff113499),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    key: const Key('loginButton'),
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40),
                      backgroundColor: const Color(0xff113499),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'LOGIN',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
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
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
