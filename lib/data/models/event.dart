const List<String> eventTypes = [
  '2d',
  '3d',
  'dolby-atmos',
  'screening',
  'screenx',
  '4dx',
  'imax',
  'vip'
];

class Event {
  final String? id;
  final String? filmId;
  final String? cinemaId;
  final DateTime dateTime;
  final String? type;
  final String? language;
  final String? bookingLink;

  Event({
    required this.id,
    required this.filmId,
    required this.cinemaId,
    required this.dateTime,
    required this.language,
    required this.type,
    required this.bookingLink,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> attributes = {};
    if (json['attributeIds'] != null) {
      String? language;
      json['attributeIds'].forEach((attr) {
        for (var type in eventTypes) {
          if (attr == type) {
            attributes.update(
              'type',
              (value) => value + ' ' + type.toString(),
              ifAbsent: () => type.toString(),
            );
          }
        }
        if (attr.contains('dubbed')) {
          language = 'DUBBING';
        } else if ((attr.contains('original') && (!attr.contains('pl')) ||
                attr == 'first-subbed-lang-pl') &&
            language == null) {
          language = 'NAPISY';
        }
      });
      language ??= 'PL';

      attributes.putIfAbsent('language', () => language);
    }

    return Event(
      id: json['id'],
      filmId: json['filmId'],
      cinemaId: json['cinemaId'],
      dateTime: DateTime.parse(json['eventDateTime']),
      language: attributes['language'],
      type: attributes['type'].toUpperCase(),
      bookingLink: json['bookingLink'],
    );
  }
}

