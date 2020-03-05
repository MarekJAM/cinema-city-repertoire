import 'dart:convert';
import 'package:cinema_city/Providers/events.dart';
import 'package:cinema_city/Providers/films.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'cinemas.dart';

class Repertoire with ChangeNotifier {
  List<dynamic> _items = [];

  List<dynamic> get items {
    return [..._items];
  }

  var events = new Events();
  var films = new Films();

  Future<void> fetchAndSetRepertoire(String date, [List<String> cinemaIds]) async {
    if(cinemaIds.isEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var cinemasShared = prefs.getStringList('cinemas');
      print(cinemasShared);
      if(cinemasShared.isNotEmpty){
        cinemaIds = cinemasShared;
      } else {
      cinemaIds = ['1063'];
      }
    }

    try {
      List<http.Response> responseList = await Future.wait(cinemaIds.map((cinemaId) => http.get('https://www.cinema-city.pl/pl/data-api-service/v1/quickbook/10103/film-events/in-cinema/$cinemaId/at-date/$date?attr=&lang=pl_PL')));

      List<dynamic> extFilms = [];
      List<dynamic> extEvents = [];

      if (responseList == null) {
        return;
      }

      for(var response in responseList){
        var extResponse = json.decode(response.body);
        extFilms.addAll(extResponse['body']['films']);
        extEvents.addAll(extResponse['body']['events']);
      }

      events.setEvents(extEvents);
      films.setFilms(extFilms);
      _items = [films.items, events.items, cinemaIds];
      print(extEvents.length);
      notifyListeners();
    } catch (error) {
      throw(error);
    }
  }
}
