import 'package:flutter/material.dart';
import 'dart:async';
import '../services/food_service.dart';
import '../services/auth_service.dart';
import '../services/konsumsi_service.dart';
import '../model/food_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<FoodModel> filteredFood = [];
  bool isLoading = false;
  bool hasSearched = false;
  final FoodService _foodService = FoodService();
  final KonsumsiService _konsumsiService = KonsumsiService();
  final AuthService _authService = AuthService();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchFoods(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredFood = [];
        hasSearched = false;
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      hasSearched = true;
    });

    try {
      final foods = await _foodService.searchFood(query);
      if (mounted) {
        setState(() {
          filteredFood = foods;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchFoods(query);
    });
  }

  void _showFoodDetails(BuildContext context, FoodModel food) async {
    String selectedMealTime = 'pagi';
    final List<String> mealTimes = ['pagi', 'siang', 'malam'];
    final TextEditingController gramController = TextEditingController();
    String estimatedConsumption = "0.0";
    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(food.namaMakanan),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi kandungan gula (100 gr):',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text('${food.gula} gr'),
                    const Divider(height: 20, thickness: 1),
                    const Text(
                      'Waktu Makan: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedMealTime,
                      items: mealTimes.map((String time) {
                        return DropdownMenuItem<String>(
                          value: time,
                          child: Text(time.substring(0, 1).toUpperCase() +
                              time.substring(1)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMealTime = newValue!;
                        });
                      },
                    ),
                    const Divider(height: 20, thickness: 1),
                    const Text(
                      'Konsumsi: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: gramController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah konsumsi dalam gram',
                        border: OutlineInputBorder(),
                        suffixText: 'gr',
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          double? input = double.tryParse(value);
                          if (input != null) {
                            setState(() {
                              double calculatedGula = (food.gula / 100) * input;
                              estimatedConsumption =
                                  calculatedGula.toStringAsFixed(2);
                            });
                          } else {
                            setState(() {
                              estimatedConsumption = "0.0";
                            });
                          }
                        } else {
                          setState(() {
                            estimatedConsumption = "0.0";
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Perkiraan kandungan gula: $estimatedConsumption gram',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: isSubmitting
                      ? null
                      : () async {
                          if (gramController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Masukkan jumlah konsumsi'),
                              ),
                            );
                            return;
                          }

                          setState(() {
                            isSubmitting = true;
                          });

                          try {
                            final double calculatedGula =
                                double.parse(estimatedConsumption);

                            await _konsumsiService.createKonsumsi(
                              jumlahKonsumsi: calculatedGula,
                              waktu: selectedMealTime,
                            );

                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Data konsumsi berhasil disimpan'),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: $e'),
                                ),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() {
                                isSubmitting = false;
                              });
                            }
                          }
                        },
                  child: Text(isSubmitting ? 'Menyimpan...' : 'Simpan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cari Makanan',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color(0xff113499),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Masukkan nama makanan',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          Expanded(
            child: !hasSearched
                ? const Center(
                    child: Text('Silakan cari makanan'),
                  )
                : filteredFood.isEmpty && !isLoading
                    ? const Center(
                        child: Text('Makanan tidak ditemukan'),
                      )
                    : ListView.builder(
                        itemCount: filteredFood.length,
                        itemBuilder: (context, index) {
                          final food = filteredFood[index];
                          return ListTile(
                            title: Text(food.namaMakanan),
                            onTap: () {
                              _showFoodDetails(context, food);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
