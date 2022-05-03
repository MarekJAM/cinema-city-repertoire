import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class DateHandler {
  static String convertDateToYYYYMMDD(DateTime date) {
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String convertDateToDDMM(DateTime date) {
    var formatter = DateFormat('dd-MM');
    return formatter.format(date);
  }

  static String convertDateToHHMM(DateTime date) {
    var formatter = DateFormat('HH:mm');
    return formatter.format(date);
  }
}
