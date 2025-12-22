import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String location; // pass from LocationScreen
  const HomeScreen({super.key, required this.location});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> alarms = [];

  Future<void> _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      final now = DateTime.now();
      final alarmDateTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);

      setState(() {
        alarms.add({
          "time": alarmDateTime,
          "enabled": true,
        });
      });
    }
  }

  String _formatDateTime(DateTime dt) {
    return "${dt.day}-${dt.month}-${dt.year}";
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final ampm = dt.hour >= 12 ? "PM" : "AM";
    final min = dt.minute.toString().padLeft(2, '0');
    return "$hour:$min $ampm";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: _pickTime,
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C3F), Color(0xFF1B1F6B), Color(0xFF2E2B8F)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Selected Location",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white70),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.location, // dynamic city
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text("Alarms", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: alarms.length,
                    itemBuilder: (context, index) {
                      final alarm = alarms[index];
                      return _alarmTile(
                        _formatTime(alarm['time']),
                        _formatDateTime(alarm['time']),
                        alarm['enabled'],
                        index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _alarmTile(
      String time, String date, bool enabled, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time,
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              Text(date, style: const TextStyle(color: Colors.white60)),
            ],
          ),
          Switch(
            value: enabled,
            onChanged: (val) {
              setState(() {
                alarms[index]['enabled'] = val;
              });
            },
            activeColor: Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}
