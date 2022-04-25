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
    var items = [...repertoire.filmItems];
    var toRemove = [];

    repertoire.filmItems.forEach((filmItem) {
      filmItem.repertoireFilmCinemaItems.forEach((cinemaItem) { 
        cinemaItem.events.forEach((event) {
          if (eventTypes.firstWhere((et) => event.type.contains(et.toUpperCase()),
                  orElse: () => null) ==
              null) {
            toRemove.add(event);
          }
        });

        cinemaItem.events.removeWhere((el) => toRemove.contains(el));
      });
    });

    return Repertoire.fromFilmItems(items);
  }
}
