import 'package:flutter/material.dart';

class MakananDeteksi extends StatelessWidget {
  const MakananDeteksi({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> makanan = [
      {'image': 'assets/ayam-bakar.jpg', 'name': 'Ayam Bakar'},
      {'image': 'assets/ayam-goreng.jpeg', 'name': 'Ayam Goreng'},
      {'image': 'assets/bakso.jpg', 'name': 'Bakso'},
      {'image': 'assets/ikan-bakar.jpeg', 'name': 'Ikan Bakar'},
      {'image': 'assets/ikan-goreng.jpeg', 'name': 'Ikan Goreng'},
      {'image': 'assets/mie-ayam.jpeg', 'name': 'Mie Ayam'},
      {'image': 'assets/mie-instan.jpeg', 'name': 'Mie Instan'},
      {'image': 'assets/nasi-goreng.jpeg', 'name': 'Nasi Goreng'},
      {'image': 'assets/nasi-merah.jpeg', 'name': 'Nasi Merah'},
      {'image': 'assets/nasi.jpeg', 'name': 'Nasi Putih'},
      {'image': 'assets/pepes-ikan.jpg', 'name': 'Pepes Ikan'},
      {'image': 'assets/pepes-tahu.jpg', 'name': 'Pepes Tahu'},
      {'image': 'assets/singkong-rebus.jpeg', 'name': 'Singkong Rebus'},
      {'image': 'assets/tahu-goreng.jpg', 'name': 'Tahu Goreng'},
      {'image': 'assets/telur-rebus.jpeg', 'name': 'Telur Rebus'},
      {'image': 'assets/tempe-goreng.jpg', 'name': 'Tempe Goreng'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Makanan Deteksi",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff113499),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: makanan.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      makanan[index]['image']!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      makanan[index]['name']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
