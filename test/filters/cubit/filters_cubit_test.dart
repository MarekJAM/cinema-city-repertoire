// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:cinema_city/bloc/filters/filters_cubit.dart';
import 'package:cinema_city/data/models/filters/filters.dart';
import 'package:cinema_city/data/repositories/filters_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final scoreFilter = ScoreFilter(0.3, true);
final genreFilter = GenreFilter(['genre1', 'genre2']);

class MockFiltersRepository extends Mock implements FiltersRepository {}

void main() {
  group("FiltersCubit", () {
    late FiltersRepository filtersRepository;
    late FiltersCubit filtersCubit;

    setUp(() {
      filtersRepository = MockFiltersRepository();

      when(() => filtersRepository.loadFilters()).thenReturn([scoreFilter, genreFilter]);

      filtersCubit = FiltersCubit(filtersRepository);
    });

    test('initial state is correct', () {
      final filtersCubit = FiltersCubit(filtersRepository);
      expect(filtersCubit.state, FiltersInitial());
    });

    group("loadFilters", () {
      final filters = [scoreFilter, genreFilter];

      blocTest<FiltersCubit, FiltersState>(
        "emits FiltersLoaded when loadFilters returns list of filters",
        setUp: () {
          when(() => filtersRepository.loadFilters()).thenReturn(filters);
        },
        build: () => filtersCubit,
        act: (cubit) => cubit.loadFiltersOnAppStarted(),
        expect: () => <dynamic>[
          FiltersLoaded(filters),
        ],
      );
    });

    group("updateFilters", () {
      final filters = [scoreFilter, genreFilter];
      final List<RepertoireFilter> updatedFilters = [];

      blocTest<FiltersCubit, FiltersState>(
        "emits FiltersLoaded with updated filters",
        build: () => filtersCubit,
        seed: () => FiltersLoaded(filters),
        act: (cubit) => cubit.updateFilters(updatedFilters),
        expect: () => <dynamic>[
          FiltersLoaded(updatedFilters),
        ],
      );
    });

     group("saveFilters", () {
      final filters = [scoreFilter, genreFilter];
      final List<RepertoireFilter> savedFilters = [scoreFilter];

      blocTest<FiltersCubit, FiltersState>(
        "emits FiltersLoaded when saveFilters returns",
        build: () => filtersCubit,
        seed: () => FiltersLoaded(filters),
        setUp: () {
          when(() => filtersRepository.saveFilters(savedFilters)).thenAnswer((_) async {});
        },
        act: (cubit) => cubit.saveFilters(savedFilters),
        expect: () => <dynamic>[
          FiltersLoaded(savedFilters),
        ],
      );
    });
  });
}