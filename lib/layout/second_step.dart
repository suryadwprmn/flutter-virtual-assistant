import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_assistant/routes/app_routes.dart';

class TwoStep extends StatefulWidget {
  const TwoStep({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TwoStep> {
  int? selectedIndex; // Variabel untuk melacak kotak yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A459F), // Warna latar belakang biru
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tombol kembali
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Get.toNamed(AppRoutes.first_step);
                },
              ),
            ),

            // Jarak antara ikon kembali dan teks
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),

            // Teks deskripsi di atas grid
            const Center(
              child: Text(
                'Sebelum berkenalan Davi ingin\n'
                'tau Tipe Diabetes anda',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 20), // Jarak antara teks dan grid

            // Flexible widget untuk grid pilihan
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    // Data tipe diabetes
                    List<String> titles = ["Tipe 1", "Tipe 2", "Pre-Diabet"];
                    List<String> descriptions = [
                      "dimana kondisi Divister tidak menghasilkan insulin",
                      "dimana kondisi insulin dalam tubuh Divister kurang bekerja efektif atau tidak cukup",
                      "kondisi ketika kadar gula darah seseorang melebihi batas normal, tetapi belum mencapai tingkat diabetes"
                    ];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index; // Mengubah kotak yang dipilih
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Colors
                                  .grey[300] // Warna abu-abu cerah jika dipilih
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              titles[index],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            // Jarak antara judul dan deskripsi di dalam kotak
                            const SizedBox(height: 8),

                            Text(
                              descriptions[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20), // Jarak antara grid dan tombol

            // Tombol "Ayo Kenalan" di bawah
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.third_step);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Ayo Kenalan',
                  style: TextStyle(
                    color: Color(0xFF0A459F),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
                height:
                    20), // Jarak di bawah tombol agar tidak terlalu rapat ke bawah
          ],
        ),
      ),
    );
  }
}
