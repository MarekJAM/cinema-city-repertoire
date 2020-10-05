import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc.dart';
import '../../data/models/models.dart';
import '../../data/repositories/exceptions.dart';
import '../../data/repositories/repositories.dart';

class RepertoireBloc extends Bloc<RepertoireEvent, RepertoireState> {
  final RepertoireRepository _repertoireRepository;

  RepertoireBloc({@required RepertoireRepository repertoireRepository})
      : assert(RepertoireRepository != null),
        _repertoireRepository = repertoireRepository,
        super(RepertoireInitial());

  @override
  Stream<RepertoireState> mapEventToState(RepertoireEvent event) async* {
    if (event is FetchRepertoire) {
      yield* _mapFetchRepertoireToState(event);
    }
  }

  Stream<RepertoireState> _mapFetchRepertoireToState(event) async* {
    yield RepertoireLoading();
    try {
      final Repertoire data = await _repertoireRepository.getRepertoire(event.date, event.cinemaIds);
      yield RepertoireLoaded(data: data);
    } on ClientException catch (e) {
      print(e);
      yield RepertoireError(message: 'Błąd połączenia.');
    } on ServerException catch (e) {
      print(e);
      yield RepertoireError(message: 'Błąd wewnętrzny serwera.');
    } catch (e) {
      print(e);
      yield RepertoireError(message: 'Wystąpił nieznany błąd.');
    }
  }
}
