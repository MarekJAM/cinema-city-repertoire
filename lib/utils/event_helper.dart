import '../data/models/event.dart';

class EventHelper {
  static List<Event> filterEventsByFilmId(List<Event> events, String? id) {
    return events.where((event) => event.filmId == id).toList();
  }

  static List<Event> filterEventsByCinemaId(List<Event> events, String? cinemaId) {
    return events.where((element) => element.cinemaId == cinemaId).toList();
  }
}