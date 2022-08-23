// ignore_for_file: prefer_const_constructors

import 'package:cinema_city/bloc/dates/dates_cubit.dart';
import 'package:cinema_city/data/repositories/repertoire_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

final testDate = DateTime.now();
const cinemaIds = ['id1', 'id2'];

class MockRepertoireRepository extends Mock implements RepertoireRepository {}

void main() {
  group("CinemasCubit", () {
    late RepertoireRepository repertoireRepository;
    late DatesCubit datesCubit;

    setUp(() {
      repertoireRepository = MockRepertoireRepository();

      when(() => repertoireRepository.getDates(any(), any())).thenAnswer((_) async => [testDate]);

      datesCubit = DatesCubit(repertoireRepository);
    });

    test('initial state is correct', () {
      final datesCubit = DatesCubit(repertoireRepository);
      expect(
          datesCubit.state,
          isA<DatesState>()
              .having((d) => d.status, 'status', DatesStatus.initial)
              .having((d) => d.selectedDate, 'selectedDate', isInstanceOf<DateTime>()));
    });

    group("getDates", () {
      blocTest<DatesCubit, DatesState>(
        "emits [loading, failure] when getDates throws",
        setUp: () {
          when(() => repertoireRepository.getDates(any(), any())).thenThrow(Exception());
        },
        build: () => datesCubit,
        act: (cubit) => cubit.getDates(testDate, cinemaIds),
        expect: () => <dynamic>[
          isA<DatesState>()
              .having((d) => d.status, 'status', DatesStatus.loading)
              .having((d) => d.selectedDate, 'selectedDate', isInstanceOf<DateTime>()),
          isA<DatesState>().having((d) => d.status, 'status', DatesStatus.failure)
        ],
      );

      blocTest<DatesCubit, DatesState>(
        "emits [loading, success] when getDates returns list of dates",
        setUp: () {
          when(() => repertoireRepository.getDates(any(), any()))
              .thenAnswer((_) async => [testDate]);
        },
        build: () => datesCubit,
        act: (cubit) => cubit.getDates(testDate, cinemaIds),
        expect: () => <dynamic>[
          isA<DatesState>()
              .having((d) => d.status, 'status', DatesStatus.loading)
              .having((d) => d.selectedDate, 'selectedDate', isInstanceOf<DateTime>()),
          isA<DatesState>()
              .having((d) => d.status, 'status', DatesStatus.success)
              .having((d) => d.dates, 'dates', [testDate])
        ],
      );
    });

    group("selectedDateChanged", () {
      final newSelectedDate = DateTime.now();

      blocTest<DatesCubit, DatesState>(
        "emits state with updated selected date",
        build: () => datesCubit,
        act: (cubit) => cubit.selectedDateChanged(newSelectedDate),
        expect: () => <dynamic>[
          isA<DatesState>().having((d) => d.selectedDate, 'selectedDate', newSelectedDate)
        ],
      );
    });
  });
}
