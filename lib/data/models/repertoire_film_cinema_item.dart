import 'package:flutter/material.dart';

import 'models.dart';

class RepertoireFilmCinemaItem {
  final Cinema cinema;
  final List<Event> events;

  RepertoireFilmCinemaItem({@required this.cinema, @required this.events});
}