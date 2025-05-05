import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy, HH:mm').format(dateTime.toLocal());
  }
}
