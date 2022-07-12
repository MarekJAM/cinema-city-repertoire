import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'repositories.dart';
import '../../data/models/models.dart';

class FilmScoresRepository {
  final FilmScoresApiClient filmScoresApiClient;

  FilmScoresRepository({required this.filmScoresApiClient});

  final _scoresSubject = BehaviorSubject<Film>();
  Stream<Film> get watchScores => _scoresSubject.stream;

  void computeFilmWebScore(Film film) async {
    film.filmWebScore = await compute(filmScoresApiClient.getFilmWebScore, film).then((film) {
      return film.filmWebScore;
    });
    _scoresSubject.add(film);
  }
}
