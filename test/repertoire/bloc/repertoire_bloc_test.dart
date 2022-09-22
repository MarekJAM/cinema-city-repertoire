// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:cinema_city/bloc/repertoire/repertoire_bloc.dart';
import 'package:cinema_city/bloc/repertoire/repertoire_event.dart';
import 'package:cinema_city/bloc/repertoire/repertoire_state.dart';
import 'package:cinema_city/data/models/film.dart';
import 'package:cinema_city/data/models/filters/filters.dart';
import 'package:cinema_city/data/models/repertoire.dart';
import 'package:cinema_city/data/repositories/film_scores_repository.dart';
import 'package:cinema_city/data/repositories/filters_repository.dart';
import 'package:cinema_city/data/repositories/repertoire_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final scoreFilter = ScoreFilter(0.3, true);
final genreFilter = GenreFilter(['genre1', 'genre2']);

class MockRepertoireRepository extends Mock implements RepertoireRepository {}

class MockFilmScoresRepository extends Mock implements FilmScoresRepository {}

class MockFiltersRepository extends Mock implements FiltersRepository {}

final Film film = Film(
  id: 'id',
  name: 'name',
  length: 120,
  posterLink: 'posterLink',
  genres: ['genre'],
  ageRestriction: 'ageRestriction',
  releaseYear: 'releaseYear',
  link: 'link',
);

void main() {
  group("RepertoireBloc", () {
    late RepertoireBloc repertoireBloc;
    late RepertoireRepository repertoireRepository;
    late FilmScoresRepository filmScoresRepository;
    late FiltersRepository filtersRepository;
    late StreamSubscription filmScoresSubscription;

    setUp(() {
      repertoireRepository = MockRepertoireRepository();
      filmScoresRepository = MockFilmScoresRepository();
      filtersRepository = MockFiltersRepository();

      when(() => filmScoresRepository.watchScores).thenAnswer((_) => Stream.value(film));

      repertoireBloc = RepertoireBloc(
        repertoireRepository: repertoireRepository,
        filtersRepository: filtersRepository,
        filmScoresRepository: filmScoresRepository,
      );
    });

    test('initial state is correct', () {
      final repertoireBloc = RepertoireBloc(
        repertoireRepository: repertoireRepository,
        filtersRepository: filtersRepository,
        filmScoresRepository: filmScoresRepository,
      );
      expect(repertoireBloc.state, isA<RepertoireInitial>());
    });

    group("GetRepertoire", () {
      final Repertoire repertoire = Repertoire()..filmItems = [];

      blocTest<RepertoireBloc, RepertoireState>(
        "emits [RepertoireLoading, RepertoireLoaded] when loadFilters returns empty list",
        build: () => repertoireBloc,
        setUp: () {
          when(() => filtersRepository.loadFilters()).thenReturn([]);
          when(() => repertoireRepository.getRepertoire(
                date: any(named: "date"),
                allCinemas: any(named: "allCinemas"),
                pickedCinemaIds: any(named: "pickedCinemaIds"),
              )).thenAnswer((_) async => repertoire);
          when(() => repertoireRepository.filterRepertoire(any(), any())).thenReturn(repertoire);
        },
        act: (bloc) => bloc.add(
            GetRepertoire(date: DateTime.now(), pickedCinemaIds: const [], allCinemas: const [])),
        expect: () => <dynamic>[
          isA<RepertoireLoading>(),
          isA<RepertoireLoaded>().having((state) => state.data.filmItems, 'filmItems', []),
        ],
      );

      blocTest<RepertoireBloc, RepertoireState>(
        "emits [RepertoireLoading, RepertoireError] when getRepertoire throws",
        build: () => repertoireBloc,
        setUp: () {
          when(() => filtersRepository.loadFilters()).thenReturn([]);
          when(() => repertoireRepository.getRepertoire(
                date: any(named: "date"),
                allCinemas: any(named: "allCinemas"),
                pickedCinemaIds: any(named: "pickedCinemaIds"),
              )).thenThrow(Exception());
          when(() => repertoireRepository.filterRepertoire(any(), any())).thenReturn(repertoire);
        },
        act: (bloc) => bloc.add(
          GetRepertoire(date: DateTime.now(), pickedCinemaIds: const [], allCinemas: const []),
        ),
        expect: () => <dynamic>[
          isA<RepertoireLoading>(),
          isA<RepertoireError>(),
        ],
      );
    });

    group("FiltersChanged", () {
      final Repertoire repertoire = Repertoire()..filmItems = [];
      final List<RepertoireFilter> filters = [];

      blocTest<RepertoireBloc, RepertoireState>(
        "emits [RepertoireLoaded] when state is RepertoireLoaded",
        build: () => repertoireBloc..loadedRepertoire = Repertoire(),
        setUp: () {
          when(() => filtersRepository.loadFilters()).thenReturn([]);
          when(() => repertoireRepository.filterRepertoire(any(), any())).thenReturn(repertoire);
        },
        seed: () => RepertoireLoaded(data: repertoire, hasFilteringLimitedResults: false),
        act: (bloc) => bloc.add(FiltersChanged(filters)),
        expect: () => <dynamic>[
          isA<RepertoireLoaded>().having((state) => state.data.filmItems, 'filmItems', []),
        ],
      );
    });
  });
}