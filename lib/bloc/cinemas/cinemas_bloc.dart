import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc.dart';
import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';
import '../../utils/storage.dart';

class CinemasBloc extends Bloc<CinemasEvent, CinemasState> {
  final CinemasRepository cinemasRepository;

  CinemasBloc({@required this.cinemasRepository}) : super(CinemasInitial()) {
    on<FetchCinemas>(_onFetchCinemas);
  }

  void _onFetchCinemas(FetchCinemas event, Emitter<CinemasState> emit) async {
    emit(CinemasLoading());
    try {
      final Cinemas data = await cinemasRepository.getAllCinemas();
      final List<String> favoriteCinemaIds = await Storage.getFavoriteCinemas();

      emit(CinemasLoaded(data: data.items, favoriteCinemaIds: favoriteCinemaIds));
    } on ClientException catch (e) {
      print(e);
      emit(CinemasError(message: 'Błąd połączenia.'));
    } on ServerException catch (e) {
      print(e);
      emit(CinemasError(message: 'Błąd wewnętrzny serwera.'));
    } catch (e) {
      print(e);
      emit(CinemasError(message: 'Wystąpił nieznany błąd.'));
    }
  }
}
