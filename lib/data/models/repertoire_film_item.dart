import 'package:cinema_city/utils/random_number_generator.dart';

import 'models.dart';

class RepertoireFilmItem {
  final Film film;
  List<RepertoireFilmCinemaItem> repertoireFilmCinemaItems;

  RepertoireFilmItem({required this.film, required this.repertoireFilmCinemaItems});

  RepertoireFilmItem copyWith({List<RepertoireFilmCinemaItem>? repertoireFilmCinemaItems}) {
    return RepertoireFilmItem(film: film, repertoireFilmCinemaItems: repertoireFilmCinemaItems ?? this.repertoireFilmCinemaItems);
  }

  static RepertoireFilmItem get mock => RepertoireFilmItem(
    film: Film.mock,
    repertoireFilmCinemaItems: List.generate(RandomNumberGenerator.randomInRange(min: 1, max: 3), (index) => RepertoireFilmCinemaItem.mock),
  );
}