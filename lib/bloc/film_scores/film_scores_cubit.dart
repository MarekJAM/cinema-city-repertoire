import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/repositories.dart';

part 'film_scores_state.dart';

@injectable
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
