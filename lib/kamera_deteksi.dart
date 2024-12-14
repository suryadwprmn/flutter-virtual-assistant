import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:virtual_assistant/makanan_deteksi.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;
  bool _showInstructionDialog = true;

  @override
  void initState() {
    super.initState();
    _showCameraInstructions();
  }

  void _showCameraInstructions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_showInstructionDialog) {
        showDialog(
          context: context,
          barrierDismissible: false, // Tidak bisa ditutup di luar dialog
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Petunjuk Scan Makanan'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Pastikan makanan berada di area foto'),
                  Text('• Foto dari atas dengan pencahayaan yang baik'),
                  Text('• Hindari bayangan atau refleksi'),
                  Text('• Fokus pada satu jenis makanan'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showInstructionDialog = false;
                    });
                    Navigator.of(context).pop();
                    _openCamera(); // Buka kamera setelah tombol "Mengerti" diklik
                  },
                  child: const Text('Mengerti'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      _processScanResult(_imageFile!);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _processScanResult(File image) {
    print('Gambar di-scan: ${image.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Makanan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff113499),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xff113499), // Sesuaikan warna latar belakang
              foregroundColor: Colors.white, // Warna teks atau ikon
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MakananDeteksi(),
                ),
              );
            },
            child: const Icon(
              Icons.info,
              size: 24,
            ),
          )
        ],
      ),
      body: Center(
        child: _imageFile != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(
                    _imageFile!,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
