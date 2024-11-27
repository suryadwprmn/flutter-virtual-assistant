import 'package:flutter/material.dart';

class Grafik extends StatelessWidget {
  const Grafik({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Grafik',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff113499),
        ),
          body: const Column(
            children: [
              
            ],
          ));
  }
}
