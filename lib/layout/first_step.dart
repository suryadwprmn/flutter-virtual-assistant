import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF0A459F), // Warna biru latar belakang atas
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tambahkan gambar logo di sini
                    Image.asset(
                      'assets/logo.png',
                      width: 100, // Sesuaikan ukuran logo
                      height: 100,
                    ),
                    SizedBox(height: 10), // Kurangi tinggi jarak untuk menggeser teks ke atas
                    Text(
                      '"Diabetes Virtual Assistant"',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10), // Kurangi tinggi jarak ini juga
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Halo Divister! kenalan dulu yuk, namaku Davi, virtual assistant yang akan menemani kamu menjelajah aplikasi ini, gimana udah ga sabar kan?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5, // Untuk mengatur jarak antar baris teks
                        ),
                      ),
                    ),
                    Spacer(), // Menambahkan Spacer untuk mendorong elemen lainnya ke bawah
                  ],
                ),
              ),
            ),
            // Tambahkan gambar Davi.png di sini sebelum Container putih
            Image.asset(
              'assets/davi.png',
              width: 200, // Sesuaikan ukuran gambar
              height: 200,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 80),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Hai, user 134729384',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'kenalan dengan Davi yuk!',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0A459F), // Warna biru tombol
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Ayo Kenalan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

