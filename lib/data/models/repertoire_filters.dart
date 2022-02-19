import 'models.dart';

abstract class RepertoireFilter {
  Repertoire filter(Repertoire repertoire);
}

class GenreFilter implements RepertoireFilter {
  final List<String> genres;

  GenreFilter(this.genres);

  @override
  Repertoire filter(Repertoire repertoire) {
    var items = repertoire.items
        .map((el) =>
            (el['film'] as Film).genres.any((gen) => genres.contains(gen))
                ? el
                : null)
        .toList();
    return Repertoire()..items = items;
  }
}
