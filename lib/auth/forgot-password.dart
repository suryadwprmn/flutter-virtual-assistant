import 'package:flutter/material.dart';
import 'package:virtual_assistant/controllers/forgot_password_controller.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ForgotPasswordController _forgotPasswordController =
      ForgotPasswordController();

  @override
  void dispose() {
    _forgotPasswordController.emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color(0xff113499),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _forgotPasswordController.emailController,
              keyboardType: TextInputType.emailAddress,
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
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Obx(
                () => ElevatedButton(
                  onPressed: _forgotPasswordController.isLoading.value
                      ? null
                      : () {
                          final email = _forgotPasswordController
                              .emailController.text
                              .trim();
                          if (email.isNotEmpty) {
                            _forgotPasswordController.sendResetPasswordEmail();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff113499),
                    foregroundColor: Colors.white,
                  ),
                  child: _forgotPasswordController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Kirim Reset Password'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
