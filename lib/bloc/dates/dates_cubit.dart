import 'package:bloc/bloc.dart';

import '../../data/repositories/repertoire_repository.dart';

part 'dates_state.dart';

class DatesCubit extends Cubit<DatesState> {
  final RepertoireRepository repertoireRepository;

  DatesCubit(this.repertoireRepository) : super(DatesInitial());

  void fetchDates(DateTime date, List<String> cinemaIds) async {
    emit(DatesLoading());
    try {
      var dates = await repertoireRepository.getDates(date, cinemaIds);
      emit(DatesLoaded(dates));
    } catch (e) {
      print(e);
      emit(DatesError("Failed to get dates."));
    }
  }
}
