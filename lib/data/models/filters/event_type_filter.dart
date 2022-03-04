import '../models.dart';

class EventTypeFilter implements RepertoireFilter {
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
