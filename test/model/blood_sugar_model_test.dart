import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_assistant/model/blood_sugar_model.dart';

void main() {
  group('BloodSugarRecord Tests', () {
    test('fromJson should correctly create a BloodSugarRecord instance', () {
      // Contoh data JSON
      final json = {
        'tanggal': '2024-12-16',
        'rata_rata_gula_darah': 120.5,
      };

      // Membuat objek BloodSugarRecord dari JSON
      final record = BloodSugarRecord.fromJson(json);

      // Verifikasi apakah data dari JSON di-convert dengan benar ke dalam objek
      expect(record.date, '2024-12-16');
      expect(record.averageBloodSugar, 120.5);
    });

    test('toJson should correctly convert BloodSugarRecord to JSON', () {
      // Membuat objek BloodSugarRecord
      final record = BloodSugarRecord(
        date: '2024-12-16',
        averageBloodSugar: 120.5,
      );
    });
  });
}
