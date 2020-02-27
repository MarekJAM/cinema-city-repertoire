import 'package:flutter/material.dart';

class Film {
  final String id;
  final String name;
  final int length;
  final String posterLink;
  final List<String> genres;
  final String ageRestriction;

  Film({
    @required this.id,
    @required this.name,
    @required this.length,
    @required this.posterLink,
    @required this.genres,
    @required this.ageRestriction,
  });
}
