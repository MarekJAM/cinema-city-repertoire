// ignore_for_file: prefer_const_constructors

import 'package:cinema_city/bloc/cinemas/cinemas_cubit.dart';
import 'package:cinema_city/data/models/cinema.dart';
import 'package:cinema_city/data/repositories/cinemas_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

const loadedCinema = Cinema(id: "id", address: "address", displayName: "name", link: "link");
const favoriteCinemaId = "favoriteCinemaId";

class MockCinemasRepository extends Mock implements CinemasRepository {}

void main() {
  group("CinemasCubit", () {
    late CinemasRepository cinemasRepository;
    late CinemasCubit cinemasCubit;

    setUp(() {
      cinemasRepository = MockCinemasRepository();

      when(() => cinemasRepository.getAllCinemas()).thenAnswer((_) async => [loadedCinema]);
      when(() => cinemasRepository.getFavoriteCinemas()).thenReturn([favoriteCinemaId]);
      when(() => cinemasRepository.setFavoriteCinemas(any())).thenAnswer((_) async {});

      cinemasCubit = CinemasCubit(cinemasRepository: cinemasRepository);
    });

    test('initial state is correct', () {
      final cinemasCubit = CinemasCubit(cinemasRepository: cinemasRepository);
      expect(cinemasCubit.state, CinemasState());
    });

    group("getCinemas", () {
      blocTest<CinemasCubit, CinemasState>(
        "emits [loading, failure] when getAllCinemas throws",
        setUp: () {
          when(() => cinemasRepository.getAllCinemas()).thenThrow(Exception());
        },
        build: () => cinemasCubit,
        act: (cubit) => cubit.getCinemas(),
        expect: () => <dynamic>[
          CinemasState(status: CinemasStatus.loading),
          isA<CinemasState>().having((c) => c.status, 'status', CinemasStatus.failure)
        ],
      );

      blocTest<CinemasCubit, CinemasState>(
        "emits [loading, success] when getAllCinemas returns list of cinemas",
        build: () => cinemasCubit,
        act: (cubit) => cubit.getCinemas(),
        expect: () => <dynamic>[
          CinemasState(status: CinemasStatus.loading),
          isA<CinemasState>()
              .having((c) => c.status, 'status', CinemasStatus.success)
              .having((c) => c.cinemas, 'cinemas', [loadedCinema]).having(
                  (c) => c.pickedCinemaIds, 'pickedCinemaIds', [
            favoriteCinemaId
          ]).having((c) => c.favoriteCinemaIds, 'favoriteCinemaIds', [favoriteCinemaId])
        ],
      );
    });

    group("pickCinemas", () {
      const pickedCinemaIds = ['id1', 'id2'];

      blocTest<CinemasCubit, CinemasState>(
        "emits state with list of picked cinema ids",
        build: () => cinemasCubit,
        act: (cubit) => cubit.pickCinemas(pickedCinemaIds),
        expect: () => <dynamic>[
          isA<CinemasState>().having((c) => c.pickedCinemaIds, 'pickedCinemaIds', pickedCinemaIds)
        ],
      );
    });

     group("saveFavoriteCinemas", () {
      const favoriteCinemaIds = ['id1', 'id2', 'id3'];

      blocTest<CinemasCubit, CinemasState>(
        "emits state with list of favorite cinema ids",
        build: () => cinemasCubit,
        act: (cubit) => cubit.saveFavoriteCinemas(favoriteCinemaIds),
        expect: () => <dynamic>[
          isA<CinemasState>().having((c) => c.favoriteCinemaIds, 'favoriteCinemaIds', favoriteCinemaIds)
        ],
      );
    });
  });
}