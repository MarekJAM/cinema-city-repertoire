import 'package:cinema_city/data/models/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Event', () {
    test('fromJson parses known event type and language', () {
      final event = Event.fromJson({
        'id': '1',
        'filmId': 'film-1',
        'cinemaId': 'cinema-1',
        'eventDateTime': '2026-06-27T18:30:00',
        'attributeIds': ['2d', 'first-subbed-lang-pl'],
        'bookingLink': 'https://example.com',
      });

      expect(event.type, '2D');
      expect(event.language, LanguageType.subtitles);
    });

    test('fromJson defaults language and allows missing type', () {
      final event = Event.fromJson({
        'id': '1',
        'filmId': 'film-1',
        'cinemaId': 'cinema-1',
        'eventDateTime': '2026-06-27T18:30:00',
        'attributeIds': <String>[],
        'bookingLink': null,
      });

      expect(event.type, isNull);
      expect(event.language, LanguageType.original);
    });
  });
}
