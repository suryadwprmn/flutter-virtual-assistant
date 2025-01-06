class DailyConsumption {
  final double totalHarian;
  final DateTime date;

  DailyConsumption({
    required this.totalHarian,
    required this.date,
  });

  factory DailyConsumption.fromJson(Map<String, dynamic> json) {
    return DailyConsumption(
      totalHarian: json['total_harian'].toDouble(),
      date: DateTime.now(), // We'll use this for display purposes
    );
  }
}
