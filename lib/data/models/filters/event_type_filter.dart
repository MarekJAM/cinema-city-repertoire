import 'package:hive/hive.dart';

import '../models.dart';

part 'event_type_filter.g.dart';

@HiveType(typeId: 0)
class EventTypeFilter implements RepertoireFilter {
  @HiveField(0)
  final List<String> eventTypes;

  EventTypeFilter(this.eventTypes);

  @override
  Repertoire filter(Repertoire repertoire) {
    var items = <RepertoireFilmItem>[];

    repertoire.filmItems.forEach((filmItem) {
      var item = filmItem.copyWith(
        repertoireFilmCinemaItems: filmItem.repertoireFilmCinemaItems
            .map(
              (cinemaItem) => cinemaItem.copyWith(
                events: cinemaItem.events
                    .where((event) => (eventTypes.firstWhere(
                            (et) => event.type.contains(et.toUpperCase()),
                            orElse: () => null) !=
                        null))
                    .toList(),
              ),
            )
            .toList(),
      );

      if (item.repertoireFilmCinemaItems.any((item) => item.events.length > 0)) {
              items.add(item);
      }
    });

    return Repertoire.fromFilmItems(items);
  }
}
