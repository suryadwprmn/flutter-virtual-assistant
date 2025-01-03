class Review {
  final String komentar;
  final String hasil;

  Review({required this.komentar, required this.hasil});

  // Fungsi untuk mengkonversi JSON ke objek Review
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      komentar: json['komentar'],
      hasil: json['hasil'],
    );
  }

  // Fungsi untuk mengkonversi objek Review ke format JSON
  Map<String, dynamic> toJson() {
    return {
      'text': komentar,
    };
  }
}
