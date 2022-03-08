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
    var items = repertoire.items;
    var toRemove = [];

    items.forEach((el) {
      el.keys.skip(1).forEach((cinema) {
        (el[cinema] as List<Event>).forEach((event) {
          if (eventTypes.firstWhere((et) => event.type.contains(et.toUpperCase()),
                  orElse: () => null) ==
              null) {
            toRemove.add(el);
          }
        });
      });
    });

    items.removeWhere((el) => toRemove.contains(el));

    return Repertoire()..items = items;
  }
}
