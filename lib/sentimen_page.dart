import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/ulasan_service.dart';
import '../model/review_model.dart';

class SentimenPage extends StatefulWidget {
  const SentimenPage({super.key});

  @override
  _SentimenPageState createState() => _SentimenPageState();
}

class _SentimenPageState extends State<SentimenPage> {
  final TextEditingController _reviewController = TextEditingController();
  final ApiService _apiService = ApiService();
  String? _sentimentResult;
  bool _isLoading = false;
  int _selectedRating =
      0; // Rating hanya untuk tampilan, tidak disimpan ke database

  void _sendReview() async {
    final reviewText = _reviewController.text.trim();

    if (reviewText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan ulasan terlebih dahulu'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Buat objek Review untuk dikirim
      final newReview = Review(
        komentar: reviewText,
        hasil: '', // Placeholder, akan diisi dari respons
      );

      // Kirim ulasan ke API
      final response = await _apiService.addReview(newReview);

      if (response != null) {
        setState(() {
          _sentimentResult = response.hasil;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengirim ulasan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    // Kosongkan text field setelah submit
    _reviewController.clear();
    setState(() {
      _selectedRating = 0; // Reset rating setelah pengiriman
    });
  }

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _selectedRating = index + 1;
            });
          },
          icon: Icon(
            Icons.star,
            color: index < _selectedRating ? Colors.amber : Colors.grey,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ulasan', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff113499),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bagaimana pendapat Anda tentang aplikasi ini?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildRatingStars(),
            const SizedBox(height: 10),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Ulasan',
                hintText: 'Masukkan ulasan',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendReview,
              child: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Kirim'),
            ),
            if (_sentimentResult != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Terima kasih atas ulasan Anda!',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
