import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GenderSelectionScreen(),
    );
  }
}

class GenderSelectionScreen extends StatefulWidget {
  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sebelum berkenalan, Davi ingin\ntau dulu kamu?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),

            SizedBox(height: 30),
            GridView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 40),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                mainAxisExtent: 80,
              ),
              children: [
                buildGenderOption("Laki-Laki", "assets/man.png"),
                buildGenderOption("assets/ladies.png","Perempuan" ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi tombol di sini
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 16,
                ),
              ),
              child: Text(
                "Ayo Kenalan",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenderOption(String gender, String? imagePath) {
    bool isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[300] : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            if (imagePath != null) // Menampilkan gambar jika ada
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Untuk border gambar
                child: Image.asset(
                  imagePath,
                  width: 60, // Lebar gambar
                  height: 60, // Tinggi gambar
                  fit: BoxFit.cover, // Mengisi seluruh ruang gambar
                ),
              ),
            SizedBox(width: 15), // Memberi jarak antara gambar dan teks
            Expanded(
              child: Text(
                gender,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
