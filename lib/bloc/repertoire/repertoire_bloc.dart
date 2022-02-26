import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc.dart';
import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

class RepertoireBloc extends Bloc<RepertoireEvent, RepertoireState> {
  final RepertoireRepository repertoireRepository;
  Repertoire loadedRepertoire;

  RepertoireBloc({@required this.repertoireRepository}) : super(RepertoireInitial()) {
    on<GetRepertoire>(_onGetRepertoire);
    on<FiltersChanged>((event, emit) => _onFiltersChanged(event.filters, emit));
  }

  void _onGetRepertoire(GetRepertoire event, Emitter<RepertoireState> emit) async {
    emit(RepertoireLoading());
    try {
      loadedRepertoire = await repertoireRepository.getRepertoire(event.date, event.cinemaIds);
      emit(RepertoireLoaded(data: loadedRepertoire));
    } on ClientException catch (e) {
      print(e);
      emit(RepertoireError(message: 'Błąd połączenia.'));
    } on ServerException catch (e) {
      print(e);
      emit(RepertoireError(message: 'Błąd wewnętrzny serwera.'));
    } catch (e) {
      print(e);
      emit(RepertoireError(message: 'Wystąpił nieznany błąd.'));
    }
  }

  void _onFiltersChanged(List<RepertoireFilter> filters, Emitter<RepertoireState> emit) {
    if (state is RepertoireLoaded) {
      var filteredRepertoire = repertoireRepository.filterRepertoire(filters, loadedRepertoire);
      emit(RepertoireLoaded(data: filteredRepertoire));
    }
  }
}
