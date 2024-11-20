class CatatanGulaDarah {
  final String tanggal;
  final String waktu;
  final double gulaDarah;

  CatatanGulaDarah({
    required this.tanggal,
    required this.waktu,
    required this.gulaDarah,
  });

  factory CatatanGulaDarah.fromJson(Map<String, dynamic> json) {
    return CatatanGulaDarah(
      tanggal: json['tanggal'],
      waktu: json['waktu'],
      gulaDarah: json['gula_darah'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'waktu': waktu,
      'gula_darah': gulaDarah,
    };
  }
}
