import './event.dart';

class Events {
  List<Event> _items = [];

  List<Event> get items {
    return [..._items];
  }

  List<Event> findEventsByFilmId(List<Event> events, String id) {
    List<Event> retEvents = [];
    events.forEach((item) {
      if (item.filmId == id) {
        retEvents.add(item);
      }
    });

    return retEvents;
  }

  List<Event> findEventsByCinemaId(List<Event> events, String id) {
    List<Event> retEvents = [];
    events.forEach((item) {
      if (item.cinemaId == id) {
        retEvents.add(item);
      }
    });

    return retEvents;
  }

  void setEvents(List<dynamic> events) {
    List<Event> loadedEvents = [];
    events.forEach((event) {
      loadedEvents.add(Event.fromJson(event));
    });
    _items = loadedEvents;
  }
}