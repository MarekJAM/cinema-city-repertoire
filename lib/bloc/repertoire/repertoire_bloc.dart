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
  final CinemasBloc cinemasBloc;
  final FiltersRepository filtersRepository;
  final FilmScoresCubit filmScoresCubit;

  late StreamSubscription filmScoresSubscription;
  late StreamSubscription filtersSubscription;
  late StreamSubscription cinemasSubscription;

  late Repertoire loadedRepertoire;
  List<RepertoireFilter>? filters;
  List<Cinema>? cinemas;

  RepertoireBloc({
    required this.repertoireRepository,
    required this.filtersCubit,
    required this.cinemasBloc,
    required this.filtersRepository,
    required this.filmScoresCubit
  }) : super(RepertoireInitial()) {
    on<GetRepertoire>(_onGetRepertoire);
    on<FiltersChanged>((event, emit) => _onFiltersChanged(event.filters, emit));

    filtersSubscription = filtersCubit.stream.listen((state) {
      if (state is FiltersLoaded) {
        add(FiltersChanged(state.filters));
      }
    });

    cinemasSubscription = cinemasBloc.stream.listen((state) { 
      if (state is CinemasLoaded) {
        cinemas ??= state.cinemas;
      }
    });

    //TODO: implement more elegant solution
    filmScoresSubscription = filmScoresCubit.stream.listen((state) {
      if (state is FilmScoresChanged) {
        add(FiltersChanged(filters!));
      }
    });
  }

  @override
  Future<void> close() {
    filtersSubscription.cancel();
    cinemasSubscription.cancel();
    filmScoresSubscription.cancel();
    return super.close();
  }

  void _onGetRepertoire(GetRepertoire event, Emitter<RepertoireState> emit) async {
    emit(RepertoireLoading());
    try {
      loadedRepertoire = await repertoireRepository.getRepertoire(date: event.date!, allCinemas: cinemas, pickedCinemaIds: event.cinemaIds);

      filters ??= filtersRepository.loadFilters();
      var filteredRepertoire = repertoireRepository.filterRepertoire(filters!, loadedRepertoire)!;

      var hasFilteringLimitedResults = loadedRepertoire.filmItems.isNotEmpty && filteredRepertoire.filmItems.isEmpty; 

      if (!kDebugMode) {
        for (var filmItem in filteredRepertoire.filmItems) {
          if (filmItem.film.filmWebScore == null) {
            filmScoresCubit.getFilmScores(filmItem.film);
          }
        }
      }

      emit(RepertoireLoaded(data: filteredRepertoire, hasFilteringLimitedResults: hasFilteringLimitedResults));
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
      var filteredRepertoire = repertoireRepository.filterRepertoire(filters!, loadedRepertoire)!;
      var hasFilteringLimitedResults = loadedRepertoire.filmItems.isNotEmpty && filteredRepertoire.filmItems.isEmpty; 

      emit(RepertoireLoaded(data: filteredRepertoire, hasFilteringLimitedResults: hasFilteringLimitedResults));
    }
  }
}
