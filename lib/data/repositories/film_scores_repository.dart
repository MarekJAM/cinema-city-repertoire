import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'repositories.dart';
import '../../data/models/models.dart';

class FilmScoresRepository {
  final FilmScoresApiClient filmScoresApiClient;

  FilmScoresRepository({required this.filmScoresApiClient});

  final _scoresSubject = BehaviorSubject<Film>();
  Stream<Film> get watchScores => _scoresSubject.stream;

  void getFilmWebScore(Film film) async {
    String score = '-';
    try {
      score = await compute(filmScoresApiClient.getFilmWebScore, film).then((score) {
        return score;
      });
    } catch (e) {
      log("$e");
    }
    film.filmWebScore = score;
    _scoresSubject.add(film);
  }
}
