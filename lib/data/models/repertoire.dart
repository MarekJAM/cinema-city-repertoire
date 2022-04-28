import 'package:cinema_city/utils/cinema_helper.dart';
import 'package:cinema_city/utils/event_helper.dart';
import 'package:flutter/material.dart';

import './models.dart';

class Repertoire {
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
            events: EventHelper.filterEventsByCinemaId(filmEvents, event.cinemaId),
          ));
        }
      });

      if (filmEvents.length > 0) {
        filmItems.add(filmItem);
      }
    });
  }

  Repertoire.fromFilmItems(List<RepertoireFilmItem> filmItems) {
    this.filmItems = [...filmItems];
  }
}
