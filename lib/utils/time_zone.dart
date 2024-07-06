import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as t;

class TimeZone {
  factory TimeZone() => _this ?? TimeZone._();

  TimeZone._() {
    initializeTimeZones();
  }
  static TimeZone? _this;

  Future<String> getTimeZoneName() async => FlutterTimezone.getLocalTimezone();

  Future<t.Location> getLocation([String? timeZoneName]) async {
    if(timeZoneName == null || timeZoneName.isEmpty){
      timeZoneName = await getTimeZoneName();
    }
    return t.getLocation(timeZoneName);
  }

  Duration diffWithCurrentPolishTime(DateTime dateTime) {
    return t.TZDateTime.now(t.getLocation('Europe/Warsaw')).difference(dateTime);
  }
}