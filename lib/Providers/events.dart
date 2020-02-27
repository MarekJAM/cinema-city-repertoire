import 'package:cinema_city/Models/event.dart';

class Events {
  List<Event> _items = [];

  List<Event> get items {
    return [..._items];
  }

  List<Event> findEventsByFilmId(List<Event> events, String id){
    List<Event> eventsToReturn = [];
    events.forEach((item) {
      if(item.filmId == id){
        eventsToReturn.add(item);
      }
    });

    return eventsToReturn;
  }

  void setEvents(List<dynamic> events) {
    List<Event> loadedEvents = [];
    events.forEach((event) {
      loadedEvents.add(
        Event(
          id: event['id'],
          filmId: event['filmId'],
          cinemaId: event['cinemaId'],
          dateTime: DateTime.parse(event['eventDateTime']),
          language: 'PL',
          type: '2D',
        ),
      );
    });
    _items = loadedEvents;
  }
}
