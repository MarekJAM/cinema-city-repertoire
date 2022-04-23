import 'package:flutter/material.dart';

import 'models.dart';

class RepertoireFilmItem {
  final Film film;
  final List<RepertoireFilmCinemaItem> repertoireFilmCinemaItems;

  RepertoireFilmItem({@required this.film, @required this.repertoireFilmCinemaItems});
}