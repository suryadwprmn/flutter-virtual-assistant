import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:virtual_assistant/grafik.dart';
import 'package:virtual_assistant/model/blood_sugar_record_model.dart';
import 'package:virtual_assistant/services/catatan_service.dart';

class CatatanKesehatan extends StatefulWidget {
  const CatatanKesehatan({super.key});

  @override
  _CatatanKesehatanState createState() => _CatatanKesehatanState();
}

class _CatatanKesehatanState extends State<CatatanKesehatan> {
  int gulaDarah = 0;
  bool _isLoading = true;
  final CatatanService _catatanService = CatatanService();

  @override
  void initState() {
    super.initState();
    _fetchLatestBloodSugarRecord();
  }

  void _fetchLatestBloodSugarRecord() async {
    try {
      final records = await _catatanService.getCatatanGulaDarah();
      if (records.isNotEmpty) {
        setState(() {
          gulaDarah = records.first.gulaDarah.toInt();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
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

  @override
  Widget build(BuildContext context) {
    String pesan = getPesan(gulaDarah);
    return Scaffold(
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
                      color: Colors.blue,
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
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.blue,
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
                      fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }

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
}
