import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> foodList = [
    'Nasi Goreng',
    'Ayam Bakar',
    'Sate',
    'Salad',
    'Soto',
    'Rendang',
    'Gado-Gado',
    'Bakso',
    'Mie Goreng',
    'Tempe Goreng',
  ];
  List<String> filteredFood = [];

  @override
  void initState() {
    super.initState();
    filteredFood = foodList;
  }

  void _filterFoods(String query) {
    setState(() {
      filteredFood = foodList
          .where((food) => food.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
              onChanged: _filterFoods,
              decoration: const InputDecoration(
                hintText: 'Masukkan nama makanan',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFood.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredFood[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
