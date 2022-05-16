import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc.dart';
import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';
import '../../utils/storage.dart';

class CinemasBloc extends Bloc<CinemasEvent, CinemasState> {
  final CinemasRepository cinemasRepository;

  CinemasBloc({required this.cinemasRepository}) : super(CinemasInitial()) {
    on<GetCinemas>(_onGetCinemas);
  }

  void _onGetCinemas(GetCinemas event, Emitter<CinemasState> emit) async {
    emit(CinemasLoading());
    try {
      final List<Cinema> cinemas = await cinemasRepository.getAllCinemas();
      final List<String> favoriteCinemaIds = await Storage.getFavoriteCinemas();

      emit(CinemasLoaded(cinemas: cinemas, favoriteCinemaIds: favoriteCinemaIds));
    } on ClientException catch (e) {
      log(e.message!);
      emit(const CinemasError(message: 'Błąd połączenia.'));
    } on ServerException catch (e) {
      log(e.message!);
      emit(const CinemasError(message: 'Błąd wewnętrzny serwera.'));
    } catch (e) {
      log('$e');
      emit(const CinemasError(message: 'Wystąpił nieznany błąd.'));
    }
  }
}
