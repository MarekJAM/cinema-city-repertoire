import 'models.dart';

abstract class RepertoireFilter {
  Repertoire filter(Repertoire repertoire);
}

class GenreFilter implements RepertoireFilter {
  final List<String> genres;

  GenreFilter(this.genres);

  @override
  Repertoire filter(Repertoire repertoire) {
    var items = repertoire.items;
    var toRemove = [];

    items.forEach((el) {
      if ((el['film'] as Film)
              .genres
              .firstWhere((el) => genres.contains(el), orElse: () => null) ==
          null) {
        toRemove.add(el);
      }
    });

    items.removeWhere((el) => toRemove.contains(el));

    return Repertoire()..items = items;
  }
}

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
