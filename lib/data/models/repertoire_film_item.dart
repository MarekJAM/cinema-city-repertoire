import 'models.dart';

class RepertoireFilmItem {
  final Film film;
  List<RepertoireFilmCinemaItem> repertoireFilmCinemaItems;

  RepertoireFilmItem({required this.film, required this.repertoireFilmCinemaItems});

  RepertoireFilmItem copyWith({List<RepertoireFilmCinemaItem>? repertoireFilmCinemaItems}) {
    return RepertoireFilmItem(film: film, repertoireFilmCinemaItems: repertoireFilmCinemaItems ?? this.repertoireFilmCinemaItems);
  }
}