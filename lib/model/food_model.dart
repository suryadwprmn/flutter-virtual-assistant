class FoodModel {
  final int? id;
  final String namaMakanan;
  final double gula;

  FoodModel({
    this.id,
    required this.namaMakanan,
    required this.gula,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      namaMakanan: json['nama_makanan'],
      gula: double.parse(json['gula']),
    );
  }
}
