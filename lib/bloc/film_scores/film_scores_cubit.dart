import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';

part 'film_scores_state.dart';

class FilmScoresCubit extends Cubit<FilmScoresState> {
  final FilmScoresRepository filmScoresRepository;

  FilmScoresCubit({
    required this.filmScoresRepository,
  }) : super(FilmScoresInitial()) {
    _filmScoresSubscription = filmScoresRepository.watchScores.listen((data) {
      emit(FilmScoresChanged());
    });
  }

  late StreamSubscription _filmScoresSubscription;

  @override
  Future<void> close() {
    _filmScoresSubscription.cancel();
    return super.close();
  }
}
