import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/repositories.dart';
import '../../data/models/filters/filters.dart';

part 'filters_state.dart';

@injectable
class FiltersCubit extends Cubit<FiltersState> {
  final FiltersRepository filtersRepository;

  FiltersCubit(this.filtersRepository) : super(FiltersInitial());

  void loadFiltersOnAppStarted() {
    final filters = filtersRepository.loadFilters();
    emit(FiltersLoaded(filters));
  }

  void updateFilters(List<RepertoireFilter> filters) {
    emit(FiltersLoaded(filters));
  }

  void saveFilters(List<RepertoireFilter> filters) {
    filtersRepository.saveFilters(filters);
    emit(FiltersLoaded(filters));
  }
}
