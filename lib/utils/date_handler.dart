import 'package:intl/intl.dart';

class DateHandler {
  static String convertDateToYYYY_MM_DD(DateTime date){
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String convertDateToDD_MM(DateTime date){
    var formatter = new DateFormat('dd-MM');
    return formatter.format(date);
  }

  static String convertDateToHH_MM(DateTime date){
    var formatter = new DateFormat('HH:mm');
    return formatter.format(date);
  }
}