import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cinema_city/Models/cinema.dart';

class Cinemas with ChangeNotifier {
  static final Cinemas _singleton = Cinemas._internal();

  factory Cinemas(){
    return _singleton;
  }

  Cinemas._internal();

  List<Cinema> _items = [];

  List<Cinema> get items {
    return [..._items];
  }

  Future<List<Cinema>> fetchAndSetCinemas(String date) async {
    final String url =
        'https://www.cinema-city.pl/pl/data-api-service/v1/quickbook/10103/cinemas/with-event/until/$date?attr=&lang=pl_PL';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Cinema> loadedCinemas = [];

      if (extractedData == null) {
        return null;
      }

      extractedData['body']['cinemas'].forEach((cinema) {
        loadedCinemas.add(
          Cinema.fromJson(
              cinema
        ));
      });

      _items = loadedCinemas;
      
      notifyListeners();
    } catch (error) {
      throw error;
    }
    return _items;
  }

  List<Cinema> getCinemasById(List<String> idList){
    return items.where((cinema) => idList.contains(cinema.id)).toList();
  }

  String getCinemaNameById(String id){
    return items.firstWhere((cinema) => id == cinema.id).displayName;
  }
}
