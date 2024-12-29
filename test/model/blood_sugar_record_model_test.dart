import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_assistant/model/blood_sugar_record_model.dart'; 
void main() {
  group('CatatanGulaDarah Tests', () {
    test('fromJson should correctly create a CatatanGulaDarah instance', () {
      // Contoh data JSON
      final json = {
        'tanggal': '2024-12-16',
        'waktu': '08:00',
        'gula_darah': 120.5,
      };

      // Membuat objek CatatanGulaDarah dari JSON
      final catatan = CatatanGulaDarah.fromJson(json);

      // Verifikasi apakah data dari JSON di-convert dengan benar ke dalam objek
      expect(catatan.tanggal, '2024-12-16');
      expect(catatan.waktu, '08:00');
      expect(catatan.gulaDarah, 120.5);
    });

    test('toJson should correctly convert CatatanGulaDarah to JSON', () {
      // Membuat objek CatatanGulaDarah
      final catatan = CatatanGulaDarah(
        tanggal: '2024-12-16',
        waktu: '08:00',
        gulaDarah: 120.5,
      );

      // Mengonversi objek CatatanGulaDarah ke JSON
      final json = catatan.toJson();

      // Verifikasi bahwa JSON berisi data yang benar
      expect(json['tanggal'], '2024-12-16');
      expect(json['waktu'], '08:00');
      expect(json['gula_darah'], 120.5);
    });
  });

  group('CatatanHbA1c Tests', () {
    test('fromJson should correctly create a CatatanHbA1c instance', () {
      // Contoh data JSON
      final json = {
        'createdAt': '2024-12-16',
        'hba1c': 5.8,
      };

      // Membuat objek CatatanHbA1c dari JSON
      final catatan = CatatanHbA1c.fromJson(json);

      // Verifikasi apakah data dari JSON di-convert dengan benar ke dalam objek
      expect(catatan.createdAt, '2024-12-16');
      expect(catatan.hba1c, 5.8);
    });

    test('toJson should correctly convert CatatanHbA1c to JSON', () {
      // Membuat objek CatatanHbA1c
      final catatan = CatatanHbA1c(
        createdAt: '2024-12-16',
        hba1c: 5.8,
      );

      // Mengonversi objek CatatanHbA1c ke JSON
      final json = catatan.toJson();

      // Verifikasi bahwa JSON berisi data yang benar
      expect(json['createdAt'], '2024-12-16');
      expect(json['hba1c'], 5.8);
    });
  });
}
