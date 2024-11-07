import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? selectedGender;
  String? selectedDiabetesCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar wave di bagian atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/wave-atas.png', width: double.infinity),
          ),

          // Mengatur Card dengan posisi lebih ke atas
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 100.0, bottom: 100.0), // Adjusted padding at the bottom
              child: Card(
                color: Color(0xFFFFFFFF), // Set color to white
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: 354,
                  height: 621,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 2),
                      Image.asset('assets/logo2.png', height: 87, width: 85),
                      SizedBox(height: 30),

                      // TextField untuk Nama
                      TextField(
                        decoration: InputDecoration(labelText: 'Nama'),
                      ),
                      SizedBox(height: 16),

                      // TextField untuk Kata Sandi
                      TextField(
                        decoration: InputDecoration(labelText: 'Kata Sandi'),
                        obscureText: true,
                      ),
                      SizedBox(height: 16),

                      // ComboBox untuk Jenis Kelamin
                      DropdownButtonFormField<String>(
                        value: selectedGender,
                        decoration: InputDecoration(
                          labelText: 'Jenis Kelamin',
                        ),
                        items: ['Laki-laki', 'Perempuan']
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      SizedBox(height: 16),

                      // ComboBox untuk Kategori Diabetes
                      DropdownButtonFormField<String>(
                        value: selectedDiabetesCategory,
                        decoration: InputDecoration(
                          labelText: 'Kategori Diabetes',
                        ),
                        items: ['Non Diabetes', 'Diabetes 1', 'Diabetes 2']
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDiabetesCategory = value;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Nomor Telepon',
                        ),
                      ),
                      SizedBox(height: 24),

                      // Tombol Buat Akun
                      ElevatedButton(
                        onPressed: () {
                          // Fungsi untuk membuat akun
                        },
                        child: Text(
                          'Buat Akun',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF113499),
                          minimumSize: Size(200, 50),
                        ),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Image.asset('assets/wave-bawah.png', width: double.infinity),
          // ),
        ],
      ),
    );
  }
}
