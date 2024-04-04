// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cinema_city/bloc/blocs.dart';
import 'package:cinema_city/data/models/film.dart';
import 'package:cinema_city/data/repositories/film_scores_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

final testDate = DateTime.now();
const cinemaIds = ['id1', 'id2'];

class MockFilmScoresRepository extends Mock implements FilmScoresRepository {}

final Film film = Film(
  id: 'id',
  name: 'name',
  length: 120,
  posterLink: 'posterLink',
  genres: ['genre'],
  ageRestriction: 18,
  releaseYear: 'releaseYear',
  link: 'link',
);

void main() {
  group("FilmScoresCubit", () {
    late FilmScoresRepository filmScoresRepository;

    setUp(() {
      filmScoresRepository = MockFilmScoresRepository();
      when(() => filmScoresRepository.watchScores).thenAnswer((_) => Stream.value(film));
    });

    test('initial state is correct', () {
      final filmScoresCubit = FilmScoresCubit(filmScoresRepository: filmScoresRepository);
    
      expect(filmScoresCubit.state, isA<FilmScoresInitial>());
    });

    group("watchScores stream data", () {
      final repository = MockFilmScoresRepository();

      blocTest<FilmScoresCubit, FilmScoresState>(
        "emits FilmScoresChanged on watchScores stream data",
        setUp: () {
          when(() => repository.watchScores).thenAnswer((_) => Stream.value(film));
        },
        build: () => FilmScoresCubit(filmScoresRepository: repository),
        expect: () => <dynamic>[
          isA<FilmScoresChanged>()
        ],
      );
    });
  });
}