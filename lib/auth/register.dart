import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/register_controller.dart';
import '../routes/app_routes.dart';

class Register extends StatelessWidget {
  final RegisterController _controller = Get.put(RegisterController());

  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // Menyesuaikan ukuran layar saat keyboard muncul
      body: Stack(
        children: [
          // Top wave image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/wave-atas.png', width: double.infinity),
          ),
          // Container for the form
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              // Wrap the content in a scroll view
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Image.asset('assets/logo2.png', height: 87, width: 85),
                        const SizedBox(height: 30),

                        // Name TextField
                        TextFormField(
                            controller: _controller.nameController,
                            decoration:
                                const InputDecoration(labelText: 'Nama'),
                            validator: (value) {
                              if (!_controller.validateName(value!)) {
                                return 'Nama harus berupa huruf';
                              }
                              return null;
                            }),
                        const SizedBox(height: 16),

                        // Email TextField
                        TextFormField(
                            controller: _controller.emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            validator: (value) {
                              if (!_controller.validateEmail(value!)) {
                                return 'Email harus berupa gmail yang valid';
                              }
                              return null;
                            }),
                        const SizedBox(height: 16),

                        // Password TextField
                        TextFormField(
                          controller: _controller.passwordController,
                          decoration:
                              const InputDecoration(labelText: 'Kata Sandi'),
                          obscureText: true,
                          validator: (value) {
                            if (!_controller.validatePassword(value!)) {
                              return 'Kata sandi harus lebih dari 6 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Gender Dropdown
                        DropdownButtonFormField<String>(
                          value: _controller.selectedGender,
                          decoration: const InputDecoration(
                            labelText: 'Jenis Kelamin',
                          ),
                          items: ['Laki-laki', 'Perempuan']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _controller.selectedGender = value;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Diabetes Category Dropdown
                        DropdownButtonFormField<String>(
                          value: _controller.selectedDiabetesCategory,
                          decoration: const InputDecoration(
                            labelText: 'Kategori Diabetes',
                          ),
                          items: ['Non Diabetes', 'Diabetes 1', 'Diabetes 2']
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _controller.selectedDiabetesCategory = value;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Phone TextField
                        TextFormField(
                          controller: _controller.phoneController,
                          keyboardType: TextInputType
                              .number, // Agar hanya keyboard angka yang muncul
                          decoration: const InputDecoration(
                            labelText: 'Nomor Telepon',
                          ),
                          onChanged: (value) {
                            // Panggil fungsi setPhone untuk memvalidasi dan mengupdate nomor telepon
                            _controller.setPhone(value);
                          },
                        ),

                        const SizedBox(height: 24),

                        // Register Button
                        ElevatedButton(
                          onPressed: _controller.registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF113499),
                            minimumSize: const Size(200, 50),
                          ),
                          child: const Text(
                            'Buat Akun',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.login);
                          },
                          child: Text(
                            'Sudah punya akun? Login',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
