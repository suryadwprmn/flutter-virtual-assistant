import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/grafik_service.dart';
import '../model/blood_sugar_model.dart';
import '../utils/custom_exception.dart';
import 'package:intl/intl.dart';

class Grafik extends StatefulWidget {
  const Grafik({super.key});

  @override
  State<Grafik> createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  final BloodSugarService _bloodSugarService = BloodSugarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Grafik',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color(0xff113499),
      ),
      body: FutureBuilder<List<BloodSugarRecord>>(
        future: _bloodSugarService.getGrafik(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error;
            final errorMessage = error is CustomException
                ? error.message
                : 'Terjadi kesalahan. Coba lagi nanti.';
            return Center(child: Text(errorMessage));
          }

          if (snapshot.hasData) {
            final List<BloodSugarRecord> records = snapshot.data!;

            // Urutkan data berdasarkan tanggal
            records.sort((a, b) =>
                DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 30, left: 30, right: 10),
                      height: 300,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: LineChart(_buildLineChart(records)),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Tidak ada data untuk ditampilkan.'));
        },
      ),
    );
  }

  LineChartData _buildLineChart(List<BloodSugarRecord> records) {
    final DateTime minDate = DateTime.parse(records.first.date);
    final DateTime maxDate = DateTime.parse(records.last.date);

    final List<DateTime> allDates = [];
    for (DateTime date = minDate;
        date.isBefore(maxDate) || date.isAtSameMomentAs(maxDate);
        date = date.add(const Duration(days: 1))) {
      allDates.add(date);
    }

    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < records.length) {
                final dateTime = DateTime.parse(records[index].date);
                final formattedDate = DateFormat('d/MM').format(dateTime);
                return Text(formattedDate);
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value == 200) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '200',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                );
              } else if (value == 150) {
                return Column(
                  children: [
                    Text(
                      'mg/dl',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('150',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ],
                );
              } else if (value == 130) {
                return const Text('130',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ));
              } else if (value == 100) {
                return const Text(
                  '100',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                );
              } else if (value == 80) {
                return const Text(
                  '80',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else if (value == 50) {
                return const Text('50',
                    style: TextStyle(
                      color: Colors.grey,
                    ));
              } else if (value == 0) {
                return const Text('0');
              }
              return const Text('');
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: records.length.toDouble(),
      minY: 10,
      maxY: 150,
      lineBarsData: [
        LineChartBarData(
          spots: records
              .asMap()
              .entries
              .map((entry) =>
                  FlSpot(entry.key.toDouble(), entry.value.averageBloodSugar))
              .toList(),
          isCurved: true,
          color: Colors.green,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}
