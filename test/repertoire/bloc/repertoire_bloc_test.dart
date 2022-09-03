// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cinema_city/bloc/filters/filters_cubit.dart';
import 'package:cinema_city/bloc/repertoire/repertoire_bloc.dart';
import 'package:cinema_city/bloc/repertoire/repertoire_state.dart';
import 'package:cinema_city/data/models/film.dart';
import 'package:cinema_city/data/models/filters/filters.dart';
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
  });
}