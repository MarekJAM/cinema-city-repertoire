import 'package:flutter/material.dart';

import 'models.dart';

class RepertoireFilmCinemaItem {
  final Cinema cinema;
  List<Event> events;

  RepertoireFilmCinemaItem({@required this.cinema, @required this.events});

  RepertoireFilmCinemaItem copyWith({List<Event> events}) {
    return RepertoireFilmCinemaItem(cinema: cinema, events: events ?? this.events);
  }
}