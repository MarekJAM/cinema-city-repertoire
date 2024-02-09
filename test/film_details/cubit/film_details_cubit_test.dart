// ignore_for_file: prefer_const_constructors
import 'package:cinema_city/bloc/blocs.dart';
import 'package:cinema_city/data/models/film.dart';
import 'package:cinema_city/data/models/film_details.dart';
import 'package:cinema_city/data/repositories/repertoire_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

final testDate = DateTime.now();
const cinemaIds = ['id1', 'id2'];

class MockRepertoireRepository extends Mock implements RepertoireRepository {}

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
  group("FilmDetailsCubit", () {
    late RepertoireRepository repertoireRepository;
    late FilmDetailsCubit filmDetailsCubit;

    setUp(() {
      repertoireRepository = MockRepertoireRepository();
      filmDetailsCubit = FilmDetailsCubit(repertoireRepository: repertoireRepository);
    });

    test('initial state is correct', () {
      final filmDetailsCubit = FilmDetailsCubit(repertoireRepository: repertoireRepository);

      expect(filmDetailsCubit.state, isA<FilmDetailsLoading>());
    });

    group("getFilmDetails", () {
      final FilmDetails filmDetails = FilmDetails(
        description: 'desc',
        premiereDate: 'date',
        cast: 'cast',
        director: 'dir',
        production: 'prod',
      );

      blocTest<FilmDetailsCubit, FilmDetailsState>(
        "emits [loading, error] when getFilmDetails throws",
        setUp: () {
          when(() => repertoireRepository.getFilmDetails(any())).thenThrow(Exception());
        },
        build: () => filmDetailsCubit,
        act: (cubit) => cubit.getFilmDetails(film),
        expect: () => <dynamic>[
          isA<FilmDetailsLoading>(),
          isA<FilmDetailsError>(),
        ],
      );

      blocTest<FilmDetailsCubit, FilmDetailsState>(
        "emits [loading, loaded] when getFilmDetails returns film details",
        setUp: () {
          when(() => repertoireRepository.getFilmDetails(any())).thenAnswer((_) async => filmDetails);
        },
        build: () => filmDetailsCubit,
        act: (cubit) => cubit.getFilmDetails(film),
        expect: () => <dynamic>[
          isA<FilmDetailsLoading>(),
          isA<FilmDetailsLoaded>().having((state) => state.film.details, 'filmDetails', filmDetails),
        ],
      );
    });
  });
}