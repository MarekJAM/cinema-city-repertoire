import 'package:cinema_city/utils/cinema_helper.dart';
import 'package:cinema_city/utils/event_helper.dart';
import 'package:flutter/material.dart';

import './models.dart';

class Repertoire {
  // List<Map<String, dynamic>> _items = [];
  List<RepertoireFilmItem> filmItems = [];

  Repertoire({
    @required List<Film> films,
    @required List<Event> events,
    @required List<Cinema> cinemas,
  }) {
    films.forEach((film) {
      var filmEvents = EventHelper.filterEventsByFilmId(events, film.id);

      var filmItem = filmItems.firstWhere((filmItem) => filmItem.film.name == film.name,
          orElse: () => RepertoireFilmItem(film: film, repertoireFilmCinemaItems: []));

      filmEvents.forEach((event) {
        var cinema = CinemaHelper.getCinemaById(cinemas, event.cinemaId);
        if (filmItem.repertoireFilmCinemaItems
                .firstWhere((item) => item.cinema.id == cinema.id, orElse: () => null) ==
            null) {
          filmItem.repertoireFilmCinemaItems.add(RepertoireFilmCinemaItem(
            cinema: cinema,
            events: EventHelper.filterEventsByCinemaId(events, event.cinemaId),
          ));
        }
      });

      if (filmEvents.length > 0) {
        filmItems.add(filmItem);
      }
    });
  }

  // List<Map<String, dynamic>> get items {
  //   return [..._items];
  // }

  // set items(List<Map<String, dynamic>> items) {
  //   this._items = items;
  // }

  // void setRepertoire(Films films, Events events, Cinemas cinemas) {
  //   films.items.forEach((film) {
  //     Map<String, dynamic> filmTile = {};
  //     filmTile.putIfAbsent('film', () => film);

  //     if (filmItems.firstWhere((filmItem) => filmItem.film.name == film.name, orElse: () => null) ==
  //         null) {
  //       //  filmItems.add(RepertoireFilmItem(film: film, repertoireFilmCinemaItems: ))
  //     }

  //     var filmEvents = events.findEventsByFilmId(film.id);
  //     filmEvents.forEach((event) {
  //       filmTile.putIfAbsent(
  //         cinemas.getCinemaNameById(event.cinemaId),
  //         () => events.filterEventsByCinemaId(filmEvents, event.cinemaId),
  //       );
  //     });

  //     if (filmEvents.length > 0) {
  //       _items.add(filmTile);
  //     }
  //   });
  // }
}
