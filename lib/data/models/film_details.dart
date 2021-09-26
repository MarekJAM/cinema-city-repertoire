import 'package:flutter/foundation.dart';

class FilmDetails {
  final String description;
  final DateTime premiereDate;
  final String cast;
  final String director;

  FilmDetails({
    @required this.description,
    @required this.premiereDate,
    @required this.cast,
    @required this.director,
  });
}
