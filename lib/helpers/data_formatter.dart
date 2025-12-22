import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final ampm = dt.hour >= 12 ? "PM" : "AM";
    final min = dt.minute.toString().padLeft(2, '0');
    return "$hour:$min $ampm";
  }

  static String formatDate(DateTime dt) {
    return DateFormat('EEE dd MMM yyyy').format(dt);
  }
}
