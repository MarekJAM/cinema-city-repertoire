import 'package:cinema_city/utils/cinema_helper.dart';
import 'package:cinema_city/utils/event_helper.dart';
import 'package:collection/collection.dart' show IterableExtension;

import './models.dart';

class Repertoire {
  List<RepertoireFilmItem> filmItems = [];

  void setItems({
    required List<Film> films,
    required List<Event> events,
    required List<Cinema>? cinemas,
  }) {
    for (var item in filmItems) {
      item.repertoireFilmCinemaItems.clear();
    }

    for (var film in films) {
      var filmEvents = EventHelper.filterEventsByFilmId(events, film.id);

      var filmItem = filmItems.firstWhere((filmItem) => filmItem.film.name == film.name,
          orElse: () => RepertoireFilmItem(film: film, repertoireFilmCinemaItems: []));

      for (var event in filmEvents) {
        var cinema = CinemaHelper.getCinemaById(cinemas!, event.cinemaId);
        var item = filmItem.repertoireFilmCinemaItems
            .firstWhereOrNull((item) => item.cinema.id == cinema.id);

        item == null
            ? filmItem.repertoireFilmCinemaItems.add(
                RepertoireFilmCinemaItem(
                  cinema: cinema,
                  events: EventHelper.filterEventsByCinemaId(filmEvents, event.cinemaId),
                ),
              )
            : item.events = EventHelper.filterEventsByCinemaId(filmEvents, event.cinemaId);
      }

      if (filmEvents.isNotEmpty && !filmItems.contains(filmItem)) {
        filmItems.add(filmItem);
      }
    }

    filmItems.sort((a, b) => a.film.name.compareTo(b.film.name));
  }

  Repertoire();

  Repertoire.fromFilmItems(List<RepertoireFilmItem> filmItems) {
    this.filmItems = [...filmItems];
  }

  static final Repertoire mock = Repertoire.fromFilmItems(
    List.generate(6, (index) => RepertoireFilmItem.mock),
  );
}
