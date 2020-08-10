import 'package:flutter/material.dart';
import '../../data/models/models.dart';
import './repositories.dart';

class CinemasRepository {
  final CinemasApiClient cinemasApiClient;

  CinemasRepository({@required this.cinemasApiClient})
      : assert(CinemasApiClient != null);

  // Future<Cinemas> getData() async {
  //   return await CinemasApiClient.fetchData();
  // }
}
