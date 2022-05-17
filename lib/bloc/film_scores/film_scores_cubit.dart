import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../blocs.dart';
import '../../data/repositories/repositories.dart';
import '../../data/models/models.dart';

part 'film_scores_state.dart';

class FilmScoresCubit extends Cubit<FilmScoresState> {
  final FilmScoresRepository filmScoresRepository;
  final RepertoireBloc repertoireBloc;
  late StreamSubscription repertoireSubscription;

  FilmScoresCubit({
    required this.repertoireBloc,
    required this.filmScoresRepository,
  }) : super(FilmScoresInitial()) {
    repertoireSubscription = repertoireBloc.stream.listen(
      (state) {
        if (!kDebugMode) {
          if (state is RepertoireLoaded) {
            for (var filmItem in state.data.filmItems) {
              if (filmItem.film.filmWebScore == null) {
                getFilmScores(filmItem.film);
              }
            }
          }
        }
      },
    );
  }

  void getFilmScores(Film film) async {
    film.filmWebScore = await compute(FilmScoresRepository.getFilmWebScores, film).then((value) {
      emit(FilmScoresChanged());
      return value!.filmWebScore;
    });
  }

  @override
  Future<void> close() {
    repertoireSubscription.cancel();
    return super.close();
  }
}
