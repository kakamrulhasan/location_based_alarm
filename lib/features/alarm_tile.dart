import 'package:flutter/material.dart';
import 'package:flutter_application_17/constants/app_colors.dart';

class AlarmTile extends StatelessWidget {
  final String time;
  final String date;
  final bool enabled;
  final ValueChanged<bool> onToggle;

  const AlarmTile({
    super.key,
    required this.time,
    required this.date,
    required this.enabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(date, style: const TextStyle(color: Colors.white60, fontSize: 14)),
              const SizedBox(width: 12),
              Switch(
                value: enabled,
                onChanged: onToggle,
                activeColor: Colors.white,
                activeTrackColor: AppColors.primary,
                inactiveThumbColor: Colors.black,
                inactiveTrackColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
