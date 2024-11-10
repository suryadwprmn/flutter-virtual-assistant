import 'package:flutter/material.dart';

class FirstStep extends StatelessWidget {
  const FirstStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A459F),
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
                  const SizedBox(
                      height:
                          10), // Kurangi tinggi jarak untuk menggeser teks ke atas
                  const Text(
                    '"Diabetes Virtual Assistant"',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10), // Kurangi tinggi jarak ini juga
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
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
                  const Spacer(), // Menambahkan Spacer untuk mendorong elemen lainnya ke bawah
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
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 80),
            color: Colors.white,
            child: Column(
              children: [
                const Text(
                  'Hai, user 134729384',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'kenalan dengan Davi yuk!',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0A459F), // Warna biru tombol
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
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
    );
  }
}
