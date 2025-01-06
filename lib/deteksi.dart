import 'dart:async';
import 'package:flutter/material.dart';
import 'package:virtual_assistant/search_page.dart';
import 'package:virtual_assistant/kamera_deteksi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/konsumsi_service.dart';
import '../model/blood_sugar_model.dart';
import '../services/auth_service.dart';

class Deteksi extends StatefulWidget {
  const Deteksi({super.key});

  @override
  State<Deteksi> createState() => _DeteksiState();
}

class _DeteksiState extends State<Deteksi> {
  double targetGulaDarah = 25.0; // Default value
  double currentConsumption = 0.0;
  final String targetKey = 'target_gula_darah';
  final KonsumsiService _consumptionService = KonsumsiService();
  Timer? _refreshTimer;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTarget();
    _loadDailyConsumption();
    _setupMidnightRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  // Load saved target value
  Future<void> _loadTarget() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      targetGulaDarah = prefs.getDouble(targetKey) ?? 25.0;
    });
  }

  // Save target value
  Future<void> _saveTarget(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(targetKey, value);
    setState(() {
      targetGulaDarah = value;
    });
  }

  void _setupMidnightRefresh() {
    // Calculate time until next midnight
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final timeUntilMidnight = tomorrow.difference(now);

    // Set up timer to refresh at midnight
    _refreshTimer = Timer(timeUntilMidnight, () {
      _loadDailyConsumption();
      // Reset timer for next day
      _setupMidnightRefresh();
    });
  }

  Future<void> _loadDailyConsumption() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = AuthService();
      final token = await authService.getToken();

      if (token != null) {
        final consumption =
            await _consumptionService.getDailyConsumption(token);
        setState(() {
          currentConsumption = consumption.totalHarian;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Silakan login terlebih dahulu';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat data konsumsi: $e';
        _isLoading = false;
      });
    }
  }

  // Show dialog to set target
  void _showTargetDialog() {
    final TextEditingController controller = TextEditingController(
      text: targetGulaDarah.toString(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atur Target Gula Harian'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Target Gula (gram)',
                  border: OutlineInputBorder(),
                  suffixText: 'gram',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Rekomendasi WHO: maksimal 25 gram/hari untuk orang dewasa',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = double.tryParse(controller.text);
                if (newValue != null && newValue > 0) {
                  _saveTarget(newValue);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Masukkan nilai yang valid'),
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildConsumptionDisplay() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Text(
        _errorMessage!,
        style: const TextStyle(color: Colors.red),
      );
    }

    return Row(
      children: [
        Text(
          '${currentConsumption.toStringAsFixed(1)} gram / ${targetGulaDarah.toStringAsFixed(1)} gram',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: _showTargetDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            'Atur Target',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Penghitung Nutrisi',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color(0xff113499),
      ),
      body: RefreshIndicator(
        onRefresh: _loadDailyConsumption,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 8),
                      Text(
                        'Cari Makanan',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'atau',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraPage(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 140,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.black54,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Scan Makanan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Konsumsi Gula Harian Anda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _buildConsumptionDisplay(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
