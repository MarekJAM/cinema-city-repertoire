import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/date_handler.dart';
import '../../data/models/models.dart';
import './repositories.dart';

class RepertoireRepository {
  final RepertoireApiClient repertoireApiClient;
  final FilmApiClient filmApiClient;
  final FilmScoresApiClient filmScoresApiClient;

  RepertoireRepository({
    @required this.repertoireApiClient,
    @required this.filmApiClient,
    @required this.filmScoresApiClient,
  }) : assert(repertoireApiClient != null, filmApiClient != null);

  Future<Repertoire> getRepertoire({@required DateTime date, @required List<Cinema> allCinemas, List<String> pickedCinemaIds}) async {
    return await repertoireApiClient.getRepertoire(
      date: DateHandler.convertDateToYYYYMMDD(
        date,
      ),
      allCinemas: allCinemas,
      cinemaIds: pickedCinemaIds,
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

  Repertoire filterRepertoire(List<RepertoireFilter> filters, Repertoire repertoire) {
    var filteredRepertoire = repertoire;

    if (filters.isNotEmpty) {
      for (var el in filters) {
        filteredRepertoire = el.filter(filteredRepertoire);
      }
    }

    return filteredRepertoire;
  }
}
