import 'package:flutter/foundation.dart';

class FilmDetails {
  final String? description;
  final String? premiereDate;
  final String cast;
  final String director;
  final String production;

  FilmDetails({
    required this.description,
    required this.premiereDate,
    required this.cast,
    required this.director,
    required this.production,
  });
}
