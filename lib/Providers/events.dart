import 'package:cinema_city/Models/event.dart';

class Events {
  List<Event> _items = [];

  List<Event> get items {
    return [..._items];
  }

  List<String> eventTypes = [
    '2d',
    '3d',
    'dolby-atmos',
    'screening',
    'screenx',
    '4dx',
    'imax',
    'vip'
  ];

  List<Event> findEventsByFilmId(List<Event> events, String id) {
    List<Event> eventsToReturn = [];
    events.forEach((item) {
      if (item.filmId == id) {
        eventsToReturn.add(item);
      }
    });

    return eventsToReturn;
  }

  String getEventType(List<dynamic> attrList) {
    String returnedString;
    attrList.forEach((attr){
      eventTypes.forEach((type){
        if (attr == type){
          if (returnedString == null) {
            returnedString = type;
          } else {
            returnedString = returnedString + ' ' + type;
          }
        }
      });
    });
    return returnedString;
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
          type: getEventType(event['attributeIds']).toUpperCase(),
        ),
      );
    });
    _items = loadedEvents;
  }
}
