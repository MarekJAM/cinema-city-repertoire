import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CinemasLocalStorageApi {
  final SharedPreferences _plugin;

  CinemasLocalStorageApi({required SharedPreferences plugin}) : _plugin = plugin;

  static const String _favoriteCinemasKey = 'favoriteCinemas';

  @visibleForTesting
  List<String>? getList(String key) => _plugin.getStringList(key);

  @visibleForTesting
  Future<void> setList(String key, List<String> value) => _plugin.setStringList(key, value);

  List<String> getFavoriteCinemas() => getList(_favoriteCinemasKey) ?? [];

  Future<void> setFavoriteCinemas(List<String> cinemaIds) => setList(_favoriteCinemasKey, cinemaIds);
}
