import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/repositories.dart';
import '../../data/models/filters/filters.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  final FiltersRepository filtersRepository;

  FiltersCubit(this.filtersRepository) : super(FiltersInitial());

  void loadFiltersOnAppStarted() {
    final filters = filtersRepository.loadFilters();
    emit(FiltersLoaded(filters));
  }

  void updateFilters(List<RepertoireFilter> filters) {
    emit(FiltersUpdated(filters));
  }

  void saveFilters(List<RepertoireFilter> filters) {
    filtersRepository.saveFilters(filters);
    emit(FiltersUpdated(filters));
  }
}
