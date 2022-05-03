import './event.dart';

class Events {
  List<Event> _items = [];

  List<Event> get items {
    return [..._items];
  }

  List<Event> findEventsByFilmId(String id) {
    List<Event> retEvents = [];
    for (var item in items) {
      if (item.filmId == id) {
        retEvents.add(item);
      }
    }

    return retEvents;
  }

  List<Event> filterEventsByCinemaId(List<Event> events, String cinemaId) {
    return events.where((element) => element.cinemaId == cinemaId).toList();
  }

  void setEvents(List<dynamic> events) {
    List<Event> loadedEvents = [];
    for (var event in events) {
      loadedEvents.add(Event.fromJson(event));
    }
    _items = loadedEvents;
  }
}