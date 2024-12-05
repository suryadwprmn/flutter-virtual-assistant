import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:virtual_assistant/grafik.dart';
import 'package:virtual_assistant/model/blood_sugar_record_model.dart';
import 'package:virtual_assistant/services/catatan_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatatanKesehatan extends StatefulWidget {
  const CatatanKesehatan({super.key});

  @override
  _CatatanKesehatanState createState() => _CatatanKesehatanState();
}

class _CatatanKesehatanState extends State<CatatanKesehatan> {
  int currentIntakeWater = 0;
  int gulaDarah = 0;
  double hba1cValue = 0;

  bool _isLoading = true;
  final CatatanService _catatanService = CatatanService();

  @override
  void initState() {
    super.initState();
    _fetchLatestBloodSugarRecord();
    _getHba1cTerakhir();
    _resetIfNewDay();
  }

  Future<void> _resetIfNewDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Cek apakah perlu reset
    DateTime today = DateTime.now();
    String todayString = "${today.year}-${today.month}-${today.day}";
    String? lastDate = prefs.getString('last_date');

    if (lastDate != todayString) {
      // Jika tanggal berubah, reset currentIntake
      setState(() {
        currentIntakeWater = 0;
      });
      await prefs.setString('last_date', todayString);
    } else {
      // Ambil nilai terakhir jika tanggal sama
      setState(() {
        currentIntakeWater = prefs.getInt('current_intake') ?? 0;
      });
    }
  }

  Future<void> _updateIntake(int newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentIntakeWater = newValue;
    });
    await prefs.setInt('current_intake', currentIntakeWater);
  }

  // Fungsi untuk mengambil HbA1c terakhir
  Future<void> _getHba1cTerakhir() async {
    try {
      CatatanHbA1c catatanHbA1c = await CatatanService().getHba1cTerakhir();

      // Always update state, even with default/zero value
      setState(() {
        hba1cValue = catatanHbA1c.hba1c;
      });
    } catch (e) {
      print('Error fetching latest HbA1c record: $e');
      setState(() {
        hba1cValue = 0; // Default value
      });
    }
  }

  @override
  void _fetchLatestBloodSugarRecord() async {
    try {
      final records = await _catatanService.getCatatanGulaDarah();
      if (records.isNotEmpty) {
        setState(() {
          gulaDarah = records.first.gulaDarah.toInt();
          pesan = getPesan(gulaDarah); // Set pesan based on blood sugar value
          _isLoading = false;
        });
      } else {
        setState(() {
          pesan = 'Catat hasil kesehatan untuk pantau kondisi tubuh Anda.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        pesan = 'Catat hasil kesehatan untuk pantau kondisi tubuh Anda.';
        _isLoading = false;
      });
    }
  }

  String getPesan(int gulaDarah) {
    switch (getRange(gulaDarah)) {
      case 'low':
        return 'Gula Darah Rendah.\nKonsumsi sedikit gula untuk menstabilkannya.';
      case 'normal':
        return 'Pertahankan! Nilai Gula Darah\nAnda Dalam Batas Normal.';
      case 'high':
        return 'Atur Pola Makan Anda, Karena\nKadar Gula Darah Anda Masih\nTinggi.';
      default:
        return 'Catat hasil kesehatan untuk pantau kondisi tubuh Anda.';
    }
  }

  String getRange(int gulaDarah) {
    if (gulaDarah >= 10 && gulaDarah <= 70) {
      return 'low';
    } else if (gulaDarah >= 80 && gulaDarah <= 130) {
      return 'normal';
    } else if (gulaDarah > 130) {
      return 'high';
    } else {
      return 'other';
    }
  }

  String pesan = 'Catat hasil kesehatan untuk pantau kondisi tubuh Anda.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Catatan Kesehatan',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xff113499),
        actions: [
          Tooltip(
            message:
                'Catatan Kesehatan ini membantu Anda dalam \nmemantau gula darah,HbA1c, dan konsumsi air putih secara rutin',
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 22,
              ),
            ),
          )
        ],
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
                const SizedBox(width: 1),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      pesan,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Kadar gula darah',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showAddDataModal(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.green,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          height: 180,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Transform.scale(
                                scale: 4.0,
                                child: CircularProgressIndicator(
                                  value: gulaDarah / 150,
                                  strokeWidth: 8,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.3),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Colors.red,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '$gulaDarah \nmg/dL',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(const Grafik());
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.green,
                            elevation: 0, // Menghilangkan bayangan
                            surfaceTintColor: Colors
                                .transparent, // Menghilangkan warna tambahan
                          ),
                          child: const Icon(
                            Icons.bar_chart,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                // Container HbA1c
                Expanded(
                  child: Container(
                    height: 180,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        // Header di atas
                        Positioned(
                          left: 10,
                          right: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'HbA1c',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Tooltip(
                                message:
                                    'Normal: jumlah HbA1c di bawah 5,7%\nDiabetes 1: jumlah HbA1c antara 5,7–6,4%\nDiabetes 2: jumlah HbA1c mencapai 6,5% atau lebih',
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        // Konten utama
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: _showHbA1cDialog,
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                    size: 22,
                                  )),
                              Text(
                                hba1cValue.toString(),
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Container Minum
                Expanded(
                  child: Container(
                    height: 180,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        // Header
                        Positioned(
                          left: 10,
                          right: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Minum',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Tooltip(
                                message:
                                    'Minum cukup air membantu \nmeningkatkan energi serta \nmenjaga cairan tubuh tetap seimbang',
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        // Konten utama
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _showInputDialogWater(context);
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                    size: 22,
                                  )),
                              Image.asset(
                                'assets/glass.png',
                                width: 80,
                                height: 80,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 140),
                          child: Center(
                              child: Text(
                            '$currentIntakeWater / 8',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
// Tutup Container

// Tambah Data HbA1c
  void _showHbA1cDialog() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Masukkan Nilai HbA1c"),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Masukkan nilai antara 1 - 10",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                final value = double.tryParse(_controller.text);
                if (value != null && value >= 1 && value <= 10) {
                  // Kirim data ke API menggunakan POST
                  final catatanHbA1c = CatatanHbA1c(
                    createdAt:
                        DateTime.now().toIso8601String(), // Waktu sekarang
                    hba1c: value,
                  );

                  try {
                    // Panggil method POST
                    await CatatanService().tambahCatatanHbA1c(catatanHbA1c);

                    // Perbarui UI dengan nilai baru
                    setState(() {
                      hba1cValue = value;
                    });

                    Navigator.of(context).pop(); // Tutup dialog
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Masukkan nilai antara 1 - 10."),
                    ),
                  );
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

// Tambah Data Gula Darah
  void _showAddDataModal(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    final TextEditingController gulaDarahController = TextEditingController();
    String? selectedWaktu;

    void tambahDataGulaDarah() async {
      if (gulaDarahController.text.isEmpty || selectedWaktu == null) {
        // Tampilkan dialog alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Data Belum Lengkap'),
              content: const Text(
                'Silakan isi semua data dengan benar sebelum menyimpan.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Parse nilai gula darah
      final double gulaDarah = double.tryParse(gulaDarahController.text) ?? 0;

      if (gulaDarah <= 0) {
        // Tampilkan dialog alert untuk validasi angka
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Nilai Tidak Valid'),
              content: const Text(
                'Masukkan nilai kadar gula darah yang valid.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Buat model data
      final catatan = CatatanGulaDarah(
        tanggal: dateController.text,
        waktu: selectedWaktu!,
        gulaDarah: gulaDarah,
      );

      // Panggil service untuk menyimpan data
      final catatanService = CatatanService();
      try {
        await catatanService.tambahCatatanGulaDarah(catatan);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil disimpan'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          this.gulaDarah = gulaDarah.toInt();
        });
        Navigator.pop(context); // Tutup modal
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

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
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Column(
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
                    Image.asset(
                      'assets/blood-analysis.png',
                      width: 100,
                      height: 100,
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
                          setModalState(() {
                            dateController.text =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: gulaDarahController,
                      decoration: const InputDecoration(
                        labelText: 'Kadar Gula Darah',
                        border: OutlineInputBorder(),
                        suffixText: 'mg/dL',
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      keyboardType: TextInputType.number,
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
                      onChanged: (value) {
                        setModalState(() {
                          selectedWaktu = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: tambahDataGulaDarah,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(50, 50),
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _showInputDialogWater(BuildContext context) async {
    await _resetIfNewDay(); // Pastikan nilai di-reset jika hari baru

    TextEditingController inputController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Jumlah Minum'),
          content: Column(
            mainAxisSize:
                MainAxisSize.min, // Membatasi ukuran dialog sesuai isi
            children: [
              SizedBox(
                height: 100, // Atur tinggi gambar
                child: Image.asset(
                  'assets/drink-water.png',
                  fit: BoxFit
                      .contain, // Menyesuaikan gambar agar tetap proporsional
                ),
              ),
              SizedBox(height: 16), // Jarak antara gambar dan konten
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50, // Lebar TextField disesuaikan
                    child: TextField(
                      controller: inputController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '',
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Jarak antara TextField dan teks
                  Text('x 250ml', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                // Ambil nilai dari TextField dan perbarui intake
                int newValue = int.tryParse(inputController.text) ?? 0;
                await _updateIntake(newValue);

                Navigator.of(context)
                    .pop(); // Tutup dialog setelah memperbarui nilai
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
