import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';
import '../blocs.dart';

class RepertoireBloc extends Bloc<RepertoireEvent, RepertoireState> {
  final RepertoireRepository repertoireRepository;
  final FiltersCubit filtersCubit;
  final FiltersRepository filtersRepository;
  final FilmScoresRepository filmScoresRepository;

  late StreamSubscription filmScoresSubscription;
  late StreamSubscription filtersSubscription;

  List<RepertoireFilter>? filters;
  late Repertoire _loadedRepertoire;
  late List<Cinema> _allCinemas;
  late List<String> _pickedCinemaIds;
  late DateTime _pickedDate;

  RepertoireBloc({
    required this.repertoireRepository,
    required this.filtersCubit,
    required this.filtersRepository,
    required this.filmScoresRepository,
  }) : super(RepertoireInitial()) {
    on<GetRepertoire>(_onGetRepertoire);
    on<FiltersChanged>((event, emit) => _onFiltersChanged(event.filters, emit));

    filtersSubscription = filtersCubit.stream.listen((state) {
      if (state is FiltersLoaded) {
        add(FiltersChanged(state.filters));
      }
    });

    filmScoresSubscription = filmScoresRepository.watchScores.listen((data) {
      add(FiltersChanged(filters!));
    });
  }

  @override
  Future<void> close() {
    filtersSubscription.cancel();
    filmScoresSubscription.cancel();
    return super.close();
  }

  void _onGetRepertoire(GetRepertoire event, Emitter<RepertoireState> emit) async {
    emit(RepertoireLoading());
    try {
      if (event.date != null) _pickedDate = event.date!;
      if (event.allCinemas != null) _allCinemas = [...event.allCinemas!];
      if (event.pickedCinemaIds != null) _pickedCinemaIds = [...event.pickedCinemaIds!];

      _loadedRepertoire = await repertoireRepository.getRepertoire(
        date: _pickedDate,
        allCinemas: _allCinemas,
        pickedCinemaIds: _pickedCinemaIds,
      );

      filters ??= filtersRepository.loadFilters();
      var filteredRepertoire = repertoireRepository.filterRepertoire(filters!, _loadedRepertoire)!;

      var hasFilteringLimitedResults =
          _loadedRepertoire.filmItems.isNotEmpty && filteredRepertoire.filmItems.isEmpty;

      if (!kDebugMode) {
        for (var filmItem in filteredRepertoire.filmItems) {
          if (filmItem.film.filmWebScore == null) {
            filmScoresRepository.getFilmWebScore(filmItem.film);
          }
        }
      }

      emit(
        RepertoireLoaded(
          data: filteredRepertoire,
          hasFilteringLimitedResults: hasFilteringLimitedResults,
        ),
      );
    } on ClientException catch (e) {
      log(e.message!);
      emit(const RepertoireError(message: 'Błąd połączenia.'));
    } on ServerException catch (e) {
      log(e.message!);
      emit(const RepertoireError(message: 'Błąd wewnętrzny serwera.'));
    } catch (e) {
      log('$e');
      emit(const RepertoireError(message: 'Wystąpił nieznany błąd.'));
    }
  }

  void _onFiltersChanged(
    List<RepertoireFilter> changedFilters,
    Emitter<RepertoireState> emit,
  ) {
    filters = changedFilters;

    if (state is RepertoireLoaded) {
      var filteredRepertoire = repertoireRepository.filterRepertoire(filters!, _loadedRepertoire)!;
      var hasFilteringLimitedResults =
          _loadedRepertoire.filmItems.isNotEmpty && filteredRepertoire.filmItems.isEmpty;

      emit(
        RepertoireLoaded(
          data: filteredRepertoire,
          hasFilteringLimitedResults: hasFilteringLimitedResults,
        ),
      );
    }
  }
}
