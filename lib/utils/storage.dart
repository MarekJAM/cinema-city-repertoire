import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String _favoriteCinemas = 'favoriteCinemas';

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<List<String>> getFavoriteCinemas() async =>
    (await prefs).getStringList(_favoriteCinemas) ?? [];
  
  static Future setFavoriteCinemas(List<String> cinemaIds) async =>
    (await prefs).setStringList(_favoriteCinemas, cinemaIds);
}