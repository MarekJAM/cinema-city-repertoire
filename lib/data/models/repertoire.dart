import 'package:flutter/cupertino.dart';

import './models.dart';

class Repertoire {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [..._items];
  }

  // events.findEventsByFilmId(events.findEventsByCinemaId(data[1], cinema), data[0][index].id);

  void setItems(Films films, Events events, Cinemas cinemas) {
    films.items.forEach((film) {
      Map<String, dynamic> filmTile = {};
      filmTile.putIfAbsent('film', () => film);
      events.findEventsByFilmId(film.id).forEach((event) { 
        filmTile.putIfAbsent(cinemas.getCinemaNameById(event.cinemaId), () => event);
      });
      _items.add(filmTile);
    });
  }
}
