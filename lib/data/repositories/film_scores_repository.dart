import 'repositories.dart';
import '../../data/models/models.dart';

class FilmScoresRepository {
  final FilmScoresApiClient filmScoresApiClient;

  FilmScoresRepository({required this.filmScoresApiClient});

  Future<Film?> getFilmWebScores(Film film) async {
    var filmId = await filmScoresApiClient.getFilmId(film);
    return filmScoresApiClient.getFilmScore(film, filmId);
  }
}
