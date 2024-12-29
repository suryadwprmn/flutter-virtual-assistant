import 'package:flutter/material.dart';
import 'package:virtual_assistant/search_page.dart';
import 'package:virtual_assistant/kamera_deteksi.dart';

class Deteksi extends StatelessWidget {
  const Deteksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Penghitung Nutrisi',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color(0xff113499),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10), // Memberikan jarak 10 dari atas
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Navigasi ke halaman pencarian
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: Colors.grey[200],
                padding: const EdgeInsets.all(10),
                child: const Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Text(
                      'Cari Makanan',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'atau',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Navigasi langsung ke halaman kamera
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraPage(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 140,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Membuat sudut membulat
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 50, // Ukuran ikon diperbesar
                      color: Colors.black54,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Scan Makanan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
