import 'package:flutter/material.dart';

import '../../data/models/film.dart';

class FilmDetailsScreen extends StatelessWidget {
  final Film film;

  const FilmDetailsScreen({@required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(film.name),
        ),
      ),
    );
  }
}
