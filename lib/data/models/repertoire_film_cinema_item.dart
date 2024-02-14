import 'package:cinema_city/utils/random_number_generator.dart';

import 'models.dart';

class RepertoireFilmCinemaItem {
  final Cinema cinema;
  List<Event> events;

  RepertoireFilmCinemaItem({required this.cinema, required this.events});

  RepertoireFilmCinemaItem copyWith({List<Event>? events}) {
    return RepertoireFilmCinemaItem(cinema: cinema, events: events ?? this.events);
  }

  static RepertoireFilmCinemaItem get mock => RepertoireFilmCinemaItem(
    cinema: Cinema.mock,
    events: List.generate(RandomNumberGenerator.randomInRange(min: 1, max: 8), (index) => Event.mock),
  );
}