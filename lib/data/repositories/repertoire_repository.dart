import 'package:flutter/material.dart';

import '../../utils/date_handler.dart';
import '../../data/models/models.dart';
import '../../utils/storage.dart';
import './repositories.dart';

class RepertoireRepository {
  final RepertoireApiClient repertoireApiClient;

  RepertoireRepository({@required this.repertoireApiClient})
      : assert(RepertoireApiClient != null);

  Future<Repertoire> getRepertoire(DateTime date,
      [List<String> cinemaIds]) async {
    return await repertoireApiClient.fetchRepertoire(
      DateHandler.convertDateToYYYY_MM_DD(
        date,
      ),
      cinemaIds,
    );
  }

  Future<Repertoire> getRepertoireForFavoriteCinemas(DateTime date) async {
    return await repertoireApiClient.fetchRepertoire(
      DateHandler.convertDateToYYYY_MM_DD(
        date,
      ),
      await Storage.getFavoriteCinemas(),
    );
  }
}
