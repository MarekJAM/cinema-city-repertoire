import 'package:collection/collection.dart' show IterableExtension;
import 'package:hive/hive.dart';

import '../models.dart';

part 'genre_filter.g.dart';

@HiveType(typeId: 1)
class GenreFilter implements RepertoireFilter {
  @HiveField(0)
  final List<String>? genres;

  GenreFilter(this.genres);

  @override
  Repertoire filter(Repertoire? repertoire) {
    var items = [...repertoire!.filmItems];
    var toRemove = [];

    for (var el in items) {
      if (el.film.genres.isEmpty && genres!.contains(noGenresData)) {
        continue;
      }
      if (el.film.genres.firstWhereOrNull((el) => genres!.contains(el)) == null) {
        toRemove.add(el);
      }
    }

    items.removeWhere((el) => toRemove.contains(el));

    return Repertoire.fromFilmItems(items);
  }
}
