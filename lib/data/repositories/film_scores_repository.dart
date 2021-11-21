import 'package:flutter/foundation.dart';

import 'repositories.dart';
import '../../data/models/models.dart';

class FilmScoresRepository {
  final FilmScoresApiClient filmScoresApiClient;

  FilmScoresRepository({@required this.filmScoresApiClient});

  static Future<Film> getFilmWebScores(Film film) async {
    return await FilmScoresApiClient.getFilmWebScore(film);
  }
}
