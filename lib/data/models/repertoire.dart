import 'package:cinema_city/utils/cinema_helper.dart';
import 'package:cinema_city/utils/event_helper.dart';
import 'package:flutter/material.dart';

import './models.dart';

class Repertoire {
  List<RepertoireFilmItem> filmItems = [];

  void setItems({
    @required List<Film> films,
    @required List<Event> events,
    @required List<Cinema> cinemas,
  }) {
    var _tempItems = [...filmItems];

    filmItems.clear();

    for (var film in films) {
      var filmEvents = EventHelper.filterEventsByFilmId(events, film.id);

      var filmItem = _tempItems.firstWhere((filmItem) => filmItem.film.name == film.name,
          orElse: () => RepertoireFilmItem(film: film, repertoireFilmCinemaItems: []));

      for (var event in filmEvents) {
        var cinema = CinemaHelper.getCinemaById(cinemas, event.cinemaId);
        var item = filmItem.repertoireFilmCinemaItems
            .firstWhere((item) => item.cinema.id == cinema.id, orElse: () => null);
            
        item == null
            ? filmItem.repertoireFilmCinemaItems.add(
                RepertoireFilmCinemaItem(
                  cinema: cinema,
                  events: EventHelper.filterEventsByCinemaId(filmEvents, event.cinemaId),
                ),
              )
            : item.events = EventHelper.filterEventsByCinemaId(filmEvents, event.cinemaId);
      }

      if (filmEvents.isNotEmpty) {
        filmItems.add(filmItem);
      }
    }
  }

  Repertoire();

  Repertoire.fromFilmItems(List<RepertoireFilmItem> filmItems) {
    this.filmItems = [...filmItems];
  }
}
