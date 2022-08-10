import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';
import '../../utils/storage.dart';

part 'cinemas_state.dart';

class CinemasCubit extends Cubit<CinemasState> {
  final CinemasRepository cinemasRepository;

  CinemasCubit({required this.cinemasRepository}) : super(const CinemasState());

  void getCinemas() async {
    emit(state.copyWith(status: CinemasStatus.loading));
    try {
      final List<Cinema> cinemas = await cinemasRepository.getAllCinemas();
      final List<String> favoriteCinemaIds = await Storage.getFavoriteCinemas();

      emit(state.copyWith(status: CinemasStatus.success, cinemas: cinemas, favoriteCinemaIds: favoriteCinemaIds, pickedCinemaIds: favoriteCinemaIds));
    } catch (e) {
      log('$e');
      emit(state.copyWith(errorMessage: 'Nie udało się pobrać listy kin.'));
    }
  }

  void pickCinemas(List<String> cinemaIds) {
    emit(state.copyWith(pickedCinemaIds: cinemaIds));
  }
}