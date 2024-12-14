import 'package:flutter/material.dart';

class MakananDeteksi extends StatelessWidget {
  const MakananDeteksi({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('Makanan yang bisa di deteksi'),
          SizedBox(height: 10),
          Text('Nasi')
        ],
      ),
    );
  }
}
