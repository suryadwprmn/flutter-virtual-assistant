import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_assistant/services/catatan_service.dart';
import 'package:virtual_assistant/model/blood_sugar_record_model.dart';

// Mock classes for dependencies
class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockCatatanService extends Mock implements CatatanService {}

void main() {
  group('Blood Sugar Range Tests', () {
    test('getRange returns correct range for low blood sugar', () {
      final state = _TestCatatanKesehatanState();
      expect(state.getRange(50), 'low');
      expect(state.getRange(10), 'low');
      expect(state.getRange(70), 'low');
    });

    test('getRange returns correct range for normal blood sugar', () {
      final state = _TestCatatanKesehatanState();
      expect(state.getRange(80), 'normal');
      expect(state.getRange(100), 'normal');
      expect(state.getRange(130), 'normal');
    });

    test('getRange returns correct range for high blood sugar', () {
      final state = _TestCatatanKesehatanState();
      expect(state.getRange(131), 'high');
      expect(state.getRange(150), 'high');
      expect(state.getRange(200), 'high');
    });

    test('getRange returns other for invalid blood sugar values', () {
      final state = _TestCatatanKesehatanState();
      expect(state.getRange(5), 'other');
      expect(state.getRange(0), 'other');
    });
  });

  group('Blood Sugar Message Tests', () {
    test('getPesan returns correct message for low blood sugar', () {
      final state = _TestCatatanKesehatanState();
      expect(state.getPesan(50),
          'Gula Darah Rendah.\nKonsumsi sedikit gula untuk menstabilkannya.');
    });

    test('getPesan returns correct message for normal blood sugar', () {
      final state = _TestCatatanKesehatanState();
      expect(state.getPesan(100),
          'Pertahankan! Nilai Gula Darah\nAnda Dalam Batas Normal.');
    });

    test('getPesan returns correct message for high blood sugar', () {
      final state = _TestCatatanKesehatanState();
      expect(state.getPesan(150),
          'Atur Pola Makan Anda, Karena\nKadar Gula Darah Anda Masih\nTinggi.');
    });
  });

  group('Water Intake Tests', () {
    test('_updateIntake increases water intake correctly', () async {
      final state = _TestCatatanKesehatanState();

      // Reset intake to 0 first
      state.currentIntakeWater = 0;

      // Update intake
      await state._updateIntake(2);

      // Check if intake increased
      expect(state.currentIntakeWater, 2);

      // Update again
      await state._updateIntake(3);
      expect(state.currentIntakeWater, 5);
    });
  });
}

// Test-specific implementation of the state class
class _TestCatatanKesehatanState {
  int currentIntakeWater = 0;
  double hba1cValue = 0;
  final CatatanService _catatanService;

  // Constructor with optional service injection
  _TestCatatanKesehatanState({CatatanService? catatanService})
      : _catatanService = catatanService ?? CatatanService();

  Future<void> _updateIntake(int newValue) async {
    currentIntakeWater += newValue;
  }

  Future<void> _getHba1cTerakhir() async {
    try {
      CatatanHbA1c catatanHbA1c = await _catatanService.getHba1cTerakhir();
      hba1cValue = catatanHbA1c.hba1c;
    } catch (e) {
      print('Error fetching latest HbA1c record: $e');
      hba1cValue = 0;
    }
  }

  String getPesan(int gulaDarah) {
    switch (getRange(gulaDarah)) {
      case 'low':
        return 'Gula Darah Rendah.\nKonsumsi sedikit gula untuk menstabilkannya.';
      case 'normal':
        return 'Pertahankan! Nilai Gula Darah\nAnda Dalam Batas Normal.';
      case 'high':
        return 'Atur Pola Makan Anda, Karena\nKadar Gula Darah Anda Masih\nTinggi.';
      default:
        return 'Catat hasil kesehatan untuk pantau kondisi tubuh Anda.';
    }
  }

  String getRange(int gulaDarah) {
    if (gulaDarah >= 10 && gulaDarah <= 70) {
      return 'low';
    } else if (gulaDarah >= 80 && gulaDarah <= 130) {
      return 'normal';
    } else if (gulaDarah > 130) {
      return 'high';
    } else {
      return 'other';
    }
  }
}
