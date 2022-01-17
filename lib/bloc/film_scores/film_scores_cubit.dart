import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../blocs.dart';
import '../../data/repositories/repositories.dart';
import '../../data/models/models.dart';

part 'film_scores_state.dart';

class FilmScoresCubit extends Cubit<FilmScoresState> {
  final FilmScoresRepository filmScoresRepository;
  final RepertoireBloc repertoireBloc;
  StreamSubscription repertoireSubscription;

  FilmScoresCubit({
    @required this.repertoireBloc,
    @required this.filmScoresRepository,
  }) : super(FilmScoresInitial()) {
    repertoireSubscription = repertoireBloc.stream.listen(
      (state) {
        if (state is RepertoireLoaded) {
          for (var film in state.data.items) {
            if ((film.values.first as Film).filmWebScore == null) {
              getFilmScores(film.values.first);
            }
          }
        }
      },
    );
  }

  void getFilmScores(Film film) async {
    film.filmWebScore = await compute(FilmScoresRepository.getFilmWebScores, film).then((value) {
      emit(FilmScoresChanged());
      return value.filmWebScore;
    });
  }

  @override
  Future<void> close() {
    repertoireSubscription.cancel();
    return super.close();
  }
}
