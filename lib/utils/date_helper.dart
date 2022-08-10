import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class DateHelper {
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

  static DateTime get getDateTimeInAYear => DateTime.now().add(const Duration(days: 365));

  static bool decideWhichDayToEnable(DateTime day, List<DateTime> selectableDates) {
    return selectableDates.isEmpty || selectableDates.any((el) => el.isSameDate(day));
  }
}
