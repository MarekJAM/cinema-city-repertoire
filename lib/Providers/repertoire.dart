import 'dart:convert';
import 'package:cinema_city/Providers/events.dart';
import 'package:cinema_city/Providers/films.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Repertoire with ChangeNotifier {
  List<dynamic> _items = [];

  List<dynamic> get items {
    return [..._items];
  }

  var events = new Events();
  var films = new Films();

  Future<void> fetchAndSetRepertoire(String date) async {
    final String url =
        'https://www.cinema-city.pl/pl/data-api-service/v1/quickbook/10103/film-events/in-cinema/1063/at-date/$date?attr=&lang=pl_PL';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      events.setEvents(extractedData['body']['events']);
      films.setFilms(extractedData['body']['films']);
      _items = [films.items, events.items];

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
