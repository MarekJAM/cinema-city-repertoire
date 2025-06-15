import 'package:collection/collection.dart' show IterableExtension;
import 'package:hive_ce/hive.dart';

import '../models.dart';

part 'event_type_filter.g.dart';

@HiveType(typeId: 0)
class EventTypeFilter implements RepertoireFilter {
  @HiveField(0)
  final List<String>? eventTypes;

  EventTypeFilter(this.eventTypes);

  @override
  Repertoire filter(Repertoire? repertoire) {
    var items = <RepertoireFilmItem>[];

    for (var filmItem in repertoire!.filmItems) {
      var item = filmItem.copyWith(
        repertoireFilmCinemaItems: filmItem.repertoireFilmCinemaItems
            .map(
              (cinemaItem) => cinemaItem.copyWith(
                events: cinemaItem.events
                    .where((event) => (eventTypes!.firstWhereOrNull(
                            (et) => event.type!.contains(et.toUpperCase())) !=
                        null))
                    .toList(),
              ),
            )
            .toList(),
      );

      if (item.repertoireFilmCinemaItems.any((item) => item.events.isNotEmpty)) {
        items.add(item);
      }
    }

    return Repertoire.fromFilmItems(items);
  }
}
