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

  List<Event> findEventsByCinemaId(List<Event> events, String id) {
    List<Event> eventsToReturn = [];
    events.forEach((item) {
      if (item.cinemaId == id) {
        eventsToReturn.add(item);
      }
    });

    return eventsToReturn;
  }

  Map<String, dynamic> setAttributes(List<dynamic> attrList) {
    Map<String, dynamic> returnedMap = {};
    String language;
    attrList.forEach((attr) {
      eventTypes.forEach((type) {
        if (attr == type) {
          returnedMap.update(
            'type',
            (value) => value + ' ' + type.toString(),
            ifAbsent: () => type.toString(),
          );
        }
      });
      if (attr.contains('dubbed')) {
        language = 'DUBBING';
      } else if ((attr.contains('original') && (!attr.contains('pl')) ||
              attr == 'first-subbed-lang-pl') &&
          language == null) {
        language = 'NAPISY';
      }
    });
    if (language == null) language = 'PL';

    returnedMap.putIfAbsent('language', () => language);

    return returnedMap;
  }

  void setEvents(List<dynamic> events) {
    List<Event> loadedEvents = [];
    events.forEach((event) {
      var attributes = setAttributes(event['attributeIds']);
      loadedEvents.add(
        Event(
          id: event['id'],
          filmId: event['filmId'],
          cinemaId: event['cinemaId'],
          dateTime: DateTime.parse(event['eventDateTime']),
          language: attributes['language'],
          type: attributes['type'].toUpperCase(),
          bookingLink: event['bookingLink']
        ),
      );
    });
    _items = loadedEvents;
  }
}
