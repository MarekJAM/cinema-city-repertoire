part of 'filters_cubit.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object> get props => [];
}

class FiltersInitial extends FiltersState {}

class FiltersLoaded extends FiltersState {
  final List<RepertoireFilter> filters;

  const FiltersLoaded(this.filters);
}

class FiltersUpdated extends FiltersState {
  final List<RepertoireFilter> filters;

  const FiltersUpdated(this.filters);
}