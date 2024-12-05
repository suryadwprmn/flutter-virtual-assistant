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

class CatatanHbA1c {
  final String createdAt;
  final double hba1c;

  CatatanHbA1c({
    required this.createdAt,
    required this.hba1c,
  });

  factory CatatanHbA1c.fromJson(Map<dynamic, dynamic> json) {
    return CatatanHbA1c(
      createdAt: json['createdAt'].toString(),
      hba1c: (json['hba1c'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'hba1c': hba1c,
    };
  }
}
