import 'package:flutter/cupertino.dart';

import './models.dart';

class Repertoire {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [..._items];
  }

  void setItems(Films films, Events events, Cinemas cinemas) {
    films.items.forEach((film){
      Map<String, dynamic> filmTile = {};
      filmTile.putIfAbsent('film', () => film);
      
      _items.add(filmTile);
    });
  }
}
