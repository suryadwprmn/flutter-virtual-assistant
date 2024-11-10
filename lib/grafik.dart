import 'package:flutter/material.dart';

class Grafik extends StatelessWidget {
  const Grafik({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik'),
      ),
      body: const Center(
        child: Text('Halaman Grafik'),
      ),
    );
  }
}
