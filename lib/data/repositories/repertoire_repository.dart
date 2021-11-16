import 'package:cinema_city/data/repositories/film_api_client.dart';
import 'package:flutter/material.dart';

import '../../utils/date_handler.dart';
import '../../data/models/models.dart';
import '../../utils/storage.dart';
import './repositories.dart';

class RepertoireRepository {
  final RepertoireApiClient repertoireApiClient;
  final FilmApiClient filmApiClient;
  final FilmScoresApiClient filmScoresApiClient;

  RepertoireRepository(
      {@required this.repertoireApiClient,
      @required this.filmApiClient,
      @required this.filmScoresApiClient})
      : assert(repertoireApiClient != null, filmApiClient != null);

  Future<Repertoire> getRepertoire(DateTime date, [List<String> cinemaIds]) async {
    return await repertoireApiClient.getRepertoire(
      DateHandler.convertDateToYYYYMMDD(
        date,
      ),
      cinemaIds,
    );
  }

  Future<Repertoire> getRepertoireForFavoriteCinemas(DateTime date) async {
    return await repertoireApiClient.getRepertoire(
      DateHandler.convertDateToYYYYMMDD(
        date,
      ),
      await Storage.getFavoriteCinemas(),
    );
  }

  Future<List<DateTime>> getDates(DateTime date, List<String> cinemaIds) async {
    var stringDates = await repertoireApiClient.getDates(
      DateHandler.convertDateToYYYYMMDD(
        date,
      ),
      cinemaIds,
    );
    return stringDates.map((date) => DateTime.parse(date)).toList();
  }

  Future<Film> getFilmDetails(Film film) async {
    return await filmApiClient.getFilmDetails(film);
  }

  Future<void> getFilmWebScores(Repertoire repertoire) async {
    for (var film in repertoire.items) {
      print(repertoire.items.first);
      await filmScoresApiClient.getFilmWebScore(film.values.first as Film);
    }
  }
}
