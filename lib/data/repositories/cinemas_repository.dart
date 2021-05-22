import 'package:flutter/material.dart';

import '../../utils/date_handler.dart';
import '../../data/models/models.dart';
import './repositories.dart';

class CinemasRepository {
  final CinemasApiClient cinemasApiClient;

  CinemasRepository({@required this.cinemasApiClient}) : assert(CinemasApiClient != null);

  Future<Cinemas> getAllCinemas() async {
    var dateInAYear = DateTime.now().add(new Duration(days: 365));

    return await cinemasApiClient.fetchCinemas(
      DateHandler.convertDateToYYYY_MM_DD(
        dateInAYear,
      ),
    );
  }
}
