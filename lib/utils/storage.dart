import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String _cinemas = 'cinemas';

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<String> getCinemas() async =>
    (await prefs).getStringList(_cinemas) ?? '';

  static Future setCinemas(List<String> cinemaIds) async =>
    (await prefs).setStringList(_cinemas, cinemaIds);

  static Future removeCinemas() async =>
    (await prefs).remove(_cinemas);
}