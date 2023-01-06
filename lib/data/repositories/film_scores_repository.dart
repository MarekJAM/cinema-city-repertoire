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

  void getFilmWebScore(Film film) async {
    try {
      final id = await filmScoresApiClient.getFilmId(film.name);
      film.filmWebScore = await filmScoresApiClient.getFilmScore(id);
    } catch (e) {
      log("$e");
      film.filmWebScore = '-';
    }
    _scoresSubject.add(film);
  }
}
