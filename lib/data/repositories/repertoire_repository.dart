import 'package:flutter/material.dart';
import '../../data/models/models.dart';
import './repositories.dart';

class RepertoireRepository {
  final RepertoireApiClient repertoireApiClient;

  RepertoireRepository({@required this.repertoireApiClient})
      : assert(RepertoireApiClient != null);

  // Future<Repertoire> getData() async {
  //   return await repertoireApiClient.fetchData();
  // }
}
