class KonsumsiModel {
  final int? id;
  final int penggunaId;
  final double jumlahKonsumsi;
  final String waktu;
  final DateTime? createdAt;

  KonsumsiModel({
    this.id,
    required this.penggunaId,
    required this.jumlahKonsumsi,
    required this.waktu,
    this.createdAt,
  });

  factory KonsumsiModel.fromJson(Map<String, dynamic> json) {
    return KonsumsiModel(
      id: json['id'],
      penggunaId: json['pengguna_id'],
      jumlahKonsumsi: json['jumlah_konsumsi'].toDouble(),
      waktu: json['waktu'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pengguna_id': penggunaId,
      'jumlah_konsumsi': jumlahKonsumsi,
      'waktu': waktu,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
