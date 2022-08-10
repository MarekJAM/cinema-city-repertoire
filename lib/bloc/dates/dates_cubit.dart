import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repertoire_repository.dart';

part 'dates_state.dart';

class DatesCubit extends Cubit<DatesState> {
  final RepertoireRepository repertoireRepository;

  DatesCubit(this.repertoireRepository)
      : super(
          DatesState(
            status: DatesStatus.initial,
            selectedDate: DateTime.now(),
          ),
        );

  void getDates(DateTime date, List<String> cinemaIds) async {
    emit(state.copyWith(status: DatesStatus.loading));
    try {
      final dates = await repertoireRepository.getDates(date, cinemaIds);
      emit(state.copyWith(
        status: DatesStatus.success,
        dates: dates,
      ));
    } catch (e) {
      log('$e');
      emit(state.copyWith(status: DatesStatus.failure));
    }
  }

  void selectedDateChanged(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }
}
