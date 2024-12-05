class BloodSugarRecord {
  final String date;
  final double averageBloodSugar;

  BloodSugarRecord({
    required this.date,
    required this.averageBloodSugar,
  });

  factory BloodSugarRecord.fromJson(Map<String, dynamic> json) {
    return BloodSugarRecord(
      date: json['tanggal'],
      averageBloodSugar: json['rata_rata_gula_darah'].toDouble(),
    );
  }
}
