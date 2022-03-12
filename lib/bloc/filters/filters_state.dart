part of 'filters_cubit.dart';

abstract class FiltersState {
  const FiltersState();
}

class FiltersInitial extends FiltersState {}

class FiltersLoaded extends FiltersState {
  final List<RepertoireFilter> filters;

  const FiltersLoaded(this.filters);
}