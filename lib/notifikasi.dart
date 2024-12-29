import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicineReminder(),
    );
  }
}

class MedicineReminder extends StatefulWidget {
  const MedicineReminder({super.key});

  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  final List<Map<String, dynamic>> _medicines = [];
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadMedicineData();
  }

  // Initialize the notifications
  Future<void> _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: android);
    await _notifications.initialize(initSettings);
    tz.initializeTimeZones();
  }

  // Load saved medicine data from shared preferences
  Future<void> _loadMedicineData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedMedicines = prefs.getStringList('medicines');
    if (savedMedicines != null) {
      setState(() {
        _medicines.addAll(savedMedicines.map((medicine) {
          final parts = medicine.split(',');
          return {
            'name': parts[0],
            'time': parts[1],
            'dosage': parts[2],
            'scheduledTime': parts[3],
            'reminderOn': parts[4] == 'true',
          };
        }).toList());
      });
    }
  }

  // Save medicine data to shared preferences
  Future<void> _saveMedicineData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedMedicines = _medicines.map((medicine) {
      return '${medicine['name']},${medicine['time']},${medicine['dosage']},${medicine['scheduledTime']},${medicine['reminderOn']}';
    }).toList();
    await prefs.setStringList('medicines', savedMedicines);
  }

  // Toggle the reminder on/off for a specific medicine
  void _toggleReminder(int index, bool value) async {
    setState(() {
      _medicines[index]['reminderOn'] = value;
    });
    _saveMedicineData(); // Save updated reminder state

    if (value) {
      // If turned on, schedule notification
      final medicine = _medicines[index];
      final scheduledTime =
          DateFormat('HH:mm').parse(medicine['scheduledTime']);
      final now = DateTime.now();
      final notificationTime = DateTime(
        now.year,
        now.month,
        now.day,
        scheduledTime.hour,
        scheduledTime.minute,
      );

      await _scheduleNotification(
        'Pengingat Obat',
        '${medicine['name']} - ${medicine['time']}, Dosis: ${medicine['dosage']}',
        notificationTime,
        index, // Use index as notification ID
      );
    } else {
      // If turned off, cancel notification
      await _notifications.cancel(index);
    }
  }

  // Delete the medicine from the list and shared preferences
  void _deleteMedicine(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus obat ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _medicines.removeAt(index);
                });
                _saveMedicineData();
                _notifications.cancel(index); // Cancel notification
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _scheduleNotification(
      String title, String body, DateTime scheduledTime, int id) async {
    const androidDetails = AndroidNotificationDetails(
      'medicine_channel',
      'Medicine Reminder',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    final tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await _notifications.zonedSchedule(
      id, // Unique ID for notification
      title,
      body,
      tzTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  void _addMedicine() {
    String? medicineName;
    String? consumptionTime;
    String? dosage;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Obat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nama Obat'),
                onChanged: (value) {
                  medicineName = value;
                },
              ),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(
                      value: 'Sebelum Makan', child: Text('Sebelum Makan')),
                  DropdownMenuItem(
                      value: 'Setelah Makan', child: Text('Setelah Makan')),
                ],
                decoration: const InputDecoration(labelText: 'Waktu Konsumsi'),
                onChanged: (value) {
                  consumptionTime = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Dosis'),
                onChanged: (value) {
                  dosage = value;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    selectedTime = time;
                  }
                },
                child: const Text('Pilih Jam Pengingat'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (medicineName != null &&
                    consumptionTime != null &&
                    dosage != null &&
                    selectedTime != null) {
                  final now = DateTime.now();
                  final scheduledTime = DateTime(now.year, now.month, now.day,
                      selectedTime!.hour, selectedTime!.minute);

                  setState(() {
                    _medicines.add({
                      'name': medicineName,
                      'time': consumptionTime,
                      'dosage': dosage,
                      'scheduledTime':
                          DateFormat('HH:mm').format(scheduledTime),
                      'reminderOn': true,
                    });
                  });
                  _scheduleNotification(
                    'Pengingat Obat',
                    '$medicineName - $consumptionTime, Dosis: $dosage',
                    scheduledTime,
                    _medicines.length - 1,
                  );
                  _saveMedicineData();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengingat Obat',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xff113499),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _medicines.length,
              itemBuilder: (context, index) {
                final medicine = _medicines[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(medicine['name']),
                      ),
                      Row(
                        children: [
                          Switch(
                            value: medicine['reminderOn'],
                            onChanged: (value) {
                              _toggleReminder(index, value);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteMedicine(index);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Text(
                      '${medicine['time']}, Jam: ${medicine['scheduledTime']}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMedicine,
        backgroundColor: Colors.green[400],
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
