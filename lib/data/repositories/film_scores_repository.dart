import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'repositories.dart';
import '../../data/models/models.dart';

@lazySingleton
class FilmScoresRepository {
  final FilmScoresApiClient filmScoresApiClient;

  FilmScoresRepository({required this.filmScoresApiClient});

  final _scoresSubject = BehaviorSubject<Film>();
  Stream<Film> get watchScores => _scoresSubject.stream;

  void getFilmWebRating(Film film) async {
    film.rating = const FilmRatingLoading();
    try {
      final id = await filmScoresApiClient.getFilmId(film.name);
      final ratingString = await filmScoresApiClient.getFilmRating(id);
      final rating = double.parse(ratingString);
      if (rating < 0.1) {
        throw Exception("Failed to get filmweb score for movie: ${film.name}. Decoded value < 0.1");
      }
      film.rating = FilmRatingLoaded(rating: rating);
    } catch (e) {
      log("$e");
      film.rating = const FilmRatingError();
    }
    _scoresSubject.add(film);
  }
}
