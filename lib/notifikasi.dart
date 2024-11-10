import 'package:flutter/material.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notifikasi'),
        ),
        body: const Center(
          child: Text('Halaman Notifikasi'),
        ),
      ),
    );
  }
}
