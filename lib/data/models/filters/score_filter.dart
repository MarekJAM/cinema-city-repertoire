import 'package:hive_ce/hive.dart';

import '../models.dart';

part 'score_filter.g.dart';

@HiveType(typeId: 2)
class ScoreFilter implements RepertoireFilter {
  @HiveField(0)
  double? score;
  @HiveField(1)
  bool? showFilmsWithNoScore;

  ScoreFilter(this.score, this.showFilmsWithNoScore);

  @override
  Repertoire filter(Repertoire? repertoire) {
    var items = [...repertoire!.filmItems];
    var toRemove = [];

    for (var el in items) {
      final filmRating = el.film.rating;

      if ((filmRating is FilmRatingLoaded && filmRating.rating < score!) ||
          (filmRating is FilmRatingError && !showFilmsWithNoScore!)) {
        toRemove.add(el);
      }
    }

    items.removeWhere((el) => toRemove.contains(el));

    return Repertoire.fromFilmItems(items);
  }
}
