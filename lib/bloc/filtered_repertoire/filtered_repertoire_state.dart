part of 'filtered_repertoire_cubit.dart';

abstract class FilteredRepertoireState extends Equatable {
  const FilteredRepertoireState();

  @override
  List<Object> get props => [];
}

class FilteredRepertoireInitial extends FilteredRepertoireState {}

class FilteredRepertoireSuccessfully extends FilteredRepertoireState {
  final Repertoire repertoire;

  FilteredRepertoireSuccessfully(this.repertoire);
}
