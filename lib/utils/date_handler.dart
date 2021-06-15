import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }
}

class DateHandler {
  static String convertDateToYYYYMMDD(DateTime date) {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String convertDateToDDMM(DateTime date) {
    var formatter = new DateFormat('dd-MM');
    return formatter.format(date);
  }

  static String convertDateToHHMM(DateTime date) {
    var formatter = new DateFormat('HH:mm');
    return formatter.format(date);
  }
}
