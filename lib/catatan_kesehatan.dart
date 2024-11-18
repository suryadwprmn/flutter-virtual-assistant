import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CatatanKesehatan extends StatefulWidget {
  const CatatanKesehatan({super.key});

  @override
  _CatatanKesehatanState createState() => _CatatanKesehatanState();
}

class _CatatanKesehatanState extends State<CatatanKesehatan> {
  int gulaDarah = 0; // Inisialisasi nilai gula darah dengan 0

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catatan Kesehatan',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff113499),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/davi.png',
                  width: 120,
                  height: 80,
                ),
                SizedBox(width: 1),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Pertahankan Nilai Gula Darah \nAnda Dalam Batas Normal',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              height: 300,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kadar gula darah',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showAddDataModal(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                          backgroundColor: Colors.green,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 160, // Atur ukuran lebar yang diinginkan
                        height: 180,
                        child: Stack(
                          alignment:
                              Alignment.center, // Menempatkan teks di tengah
                          children: [
                            Transform.scale(
                              scale:
                                  4.0, // Skala indikator, semakin besar nilainya, semakin besar ukurannya
                              child: CircularProgressIndicator(
                                value: gulaDarah / 150,
                                strokeWidth: 12, // Ketebalan garis lebih besar
                                backgroundColor: Colors.white.withOpacity(0.3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red, // Warna indikator
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '$gulaDarah \nmg/dL', // Menampilkan nilai gula darah di tengah
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16, // Ukuran teks yang lebih besar
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                          backgroundColor: Colors.green,
                        ),
                        child: Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDataModal(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    dateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now()); // Tanggal sekarang

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tambah Data Kadar Gula Darah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Kadar Gula Darah',
                    border: const OutlineInputBorder(),
                    suffixText: 'mg/dL',
                    suffixStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // Memperbarui nilai gula darah
                    setState(() {
                      gulaDarah = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Waktu',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Pagi', child: Text('Pagi')),
                    DropdownMenuItem(value: 'Siang', child: Text('Siang')),
                    DropdownMenuItem(value: 'Malam', child: Text('Malam')),
                  ],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
