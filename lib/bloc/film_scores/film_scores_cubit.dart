import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/repositories/repositories.dart';
import '../../data/models/models.dart';

part 'film_scores_state.dart';

class FilmScoresCubit extends Cubit<FilmScoresState> {
  final FilmScoresRepository filmScoresRepository;

  FilmScoresCubit({
    required this.filmScoresRepository,
  }) : super(FilmScoresInitial());

  void getFilmScores(Film film) async {
    film.filmWebScore = await compute(FilmScoresRepository.getFilmWebScores, film).then((value) {
      emit(FilmScoresChanged());
      return value!.filmWebScore;
    });
  }
}
