import 'package:hive/hive.dart';

import '../models.dart';

part 'score_filter.g.dart';

@HiveType(typeId: 2)
class ScoreFilter implements RepertoireFilter {
  @HiveField(0)
  double score;
  @HiveField(1)
  bool showFilmsWithNoScore;

  ScoreFilter(this.score, this.showFilmsWithNoScore);

  @override
  Repertoire filter(Repertoire repertoire) {
    var items = [...repertoire.filmItems];
    var toRemove = [];

    items.forEach((el) {
      var itemScoreString = el.film.filmWebScore;
      var itemScoreDouble = itemScoreString != null ? double.tryParse(itemScoreString) : null;

      if ((itemScoreDouble != null && itemScoreDouble < this.score) ||
          (itemScoreDouble == null && itemScoreString != null && !showFilmsWithNoScore)) {
        toRemove.add(el);
      }
    });

    items.removeWhere((el) => toRemove.contains(el));

    return Repertoire.fromFilmItems(items);
  }
}
