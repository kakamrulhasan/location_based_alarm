import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_17/common_widgets/gradient_container.dart';
import 'package:flutter_application_17/constants/app_colors.dart';
import 'package:flutter_application_17/helpers/data_formatter.dart';
import 'package:flutter_application_17/networks/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alarm_tile.dart';

class HomeScreen extends StatefulWidget {
  final String location;
  const HomeScreen({super.key, required this.location});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> alarms = [];

  @override
  void initState() {
    super.initState();
    _loadAlarms();
  }

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsJson = prefs.getString('alarms');
    if (alarmsJson != null) {
      setState(
        () => alarms = List<Map<String, dynamic>>.from(jsonDecode(alarmsJson)),
      );
    }
  }

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('alarms', jsonEncode(alarms));
  }

  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final now = DateTime.now();
    final alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    setState(() {
      alarms.add({
        "id": id,
        "time": alarmTime.toIso8601String(),
        "enabled": true,
      });
    });

    await NotificationService().schedule(alarmTime, id: id);
    await _saveAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _pickTime,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: GradientContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _locationCard(),
                const SizedBox(height: 24),
                const Text(
                  "Alarms",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 12),
                _alarmListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _locationCard() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white12,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        const Icon(Icons.location_pin, color: AppColors.whiteLight),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.location,
            style: const TextStyle(color: AppColors.whiteLight),
          ),
        ),
      ],
    ),
  );

  Widget _alarmListView() => Expanded(
    child: ListView.builder(
      itemCount: alarms.length,
      itemBuilder: (context, index) {
        final alarm = alarms[index];
        final alarmTime = DateTime.parse(alarm['time']);
        return AlarmTile(
          time: DateFormatter.formatTime(alarmTime),
          date: DateFormatter.formatDate(alarmTime),
          enabled: alarm['enabled'],
          onToggle: (val) async {
            setState(() => alarms[index]['enabled'] = val);

            if (val) {
              await NotificationService().schedule(alarmTime, id: alarm['id']);
            } else {
              await NotificationService().cancel(alarm['id']);
            }

            await _saveAlarms();
          },
        );
      },
    ),
  );
}
