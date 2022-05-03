import 'package:hive/hive.dart';

import '../models.dart';

part 'genre_filter.g.dart';

@HiveType(typeId: 1)
class GenreFilter implements RepertoireFilter {
  @HiveField(0)
  final List<String> genres;

  GenreFilter(this.genres);

  @override
  Repertoire filter(Repertoire repertoire) {
    var items = [...repertoire.filmItems];
    var toRemove = [];

    for (var el in items) {
      if (el.film.genres.firstWhere((el) => genres.contains(el), orElse: () => null) == null) {
        toRemove.add(el);
      }
    }

    items.removeWhere((el) => toRemove.contains(el));

    return Repertoire.fromFilmItems(items);
  }
}
