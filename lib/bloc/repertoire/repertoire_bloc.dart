import 'dart:async';
import 'dart:developer';

import 'package:cinema_city/i18n/strings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';
import '../blocs.dart';

@injectable
class RepertoireBloc extends Bloc<RepertoireEvent, RepertoireState> {
  final RepertoireRepository repertoireRepository;
  final FiltersRepository filtersRepository;
  final FilmScoresRepository filmScoresRepository;

  late StreamSubscription filmScoresSubscription;

  @visibleForTesting
  List<RepertoireFilter>? filters;

  @visibleForTesting
  late Repertoire loadedRepertoire;
  late List<Cinema> _allCinemas;
  late List<String> _pickedCinemaIds;
  late DateTime _pickedDate;

  RepertoireBloc({
    required this.repertoireRepository,
    required this.filtersRepository,
    required this.filmScoresRepository,
  }) : super(RepertoireLoading()) {
    on<GetRepertoire>(_onGetRepertoire);
    on<FiltersChanged>((event, emit) => _onFiltersChanged(event.filters, emit));

    filmScoresSubscription = filmScoresRepository.watchScores.listen((data) {
      add(FiltersChanged(filters ?? []));
    });
  }

  @override
  Future<void> close() {
    filmScoresSubscription.cancel();
    return super.close();
  }

  void _onGetRepertoire(GetRepertoire event, Emitter<RepertoireState> emit) async {
    emit(RepertoireLoading());
    try {
      if (event.date != null) _pickedDate = event.date!;
      if (event.allCinemas != null) _allCinemas = [...event.allCinemas!];
      if (event.pickedCinemaIds != null) _pickedCinemaIds = [...event.pickedCinemaIds!];

      loadedRepertoire = await repertoireRepository.getRepertoire(
        date: _pickedDate,
        allCinemas: _allCinemas,
        pickedCinemaIds: _pickedCinemaIds,
      );

      filters ??= filtersRepository.loadFilters();
      final filteredRepertoire = repertoireRepository.filterRepertoire(filters!, loadedRepertoire)!;

      final hasFilteringLimitedResults =
          loadedRepertoire.filmItems.isNotEmpty && filteredRepertoire.filmItems.isEmpty;

      for (var filmItem in filteredRepertoire.filmItems) {
        if (filmItem.film.rating is FilmRatingInitial) {
          filmScoresRepository.getFilmWebRating(filmItem.film);
        }
      }

      emit(
        RepertoireLoaded(
          data: filteredRepertoire,
          hasFilteringLimitedResults: hasFilteringLimitedResults,
        ),
      );
    } catch (e) {
      log('$e');
      emit(RepertoireError(message: t.repertoire.failedToLoad));
    }
  }

  void _onFiltersChanged(
    List<RepertoireFilter> changedFilters,
    Emitter<RepertoireState> emit,
  ) {
    filters = changedFilters;

    if (state is RepertoireLoaded) {
      final filteredRepertoire = repertoireRepository.filterRepertoire(filters!, loadedRepertoire)!;
      final hasFilteringLimitedResults =
          loadedRepertoire.filmItems.isNotEmpty && filteredRepertoire.filmItems.isEmpty;

      emit(
        RepertoireLoaded(
          data: filteredRepertoire,
          hasFilteringLimitedResults: hasFilteringLimitedResults,
        ),
      );
    }
  }
}
