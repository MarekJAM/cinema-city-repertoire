import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../blocs.dart';
import '../../data/models/models.dart';
import '../../data/repositories/repertoire_repository.dart';

part 'filtered_repertoire_state.dart';

class FilteredRepertoireCubit extends Cubit<FilteredRepertoireState> {
  final RepertoireBloc repertoireBloc;
  final RepertoireRepository repertoireRepository;

  RepertoireState repertoireBlocCurrentState;

  FilteredRepertoireCubit(
      {@required this.repertoireBloc, @required this.repertoireRepository})
      : super(FilteredRepertoireInitial()) {
    repertoireBloc.stream.listen(
      (state) {
        repertoireBlocCurrentState = state;
      },
    );
  }

  void filtersChanged(List<RepertoireFilter> filters) {
    if (repertoireBlocCurrentState is RepertoireLoaded) {
      var rep = repertoireRepository.filterRepertoire(filters, (repertoireBlocCurrentState as RepertoireLoaded).data);
      emit(FilteredRepertoireSuccessfully(rep));
    }
  }
}
