import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

part 'cinemas_state.dart';

class CinemasCubit extends Cubit<CinemasState> {
  final CinemasRepository cinemasRepository;

  CinemasCubit({required this.cinemasRepository}) : super(const CinemasState());

  Future<void> getCinemas() async {
    emit(state.copyWith(status: CinemasStatus.loading));
    try {
      final List<Cinema> cinemas = await cinemasRepository.getAllCinemas();
      final List<String> favoriteCinemaIds = cinemasRepository.getFavoriteCinemas();

      emit(
        state.copyWith(
          status: CinemasStatus.success,
          cinemas: cinemas,
          favoriteCinemaIds: favoriteCinemaIds,
          pickedCinemaIds: favoriteCinemaIds,
        ),
      );
    } catch (e) {
      log('$e');
      emit(
        state.copyWith(
          status: CinemasStatus.failure,
          errorMessage: 'Nie udało się pobrać listy kin.',
        ),
      );
    }
  }

  void pickCinemas(List<String> cinemaIds) {
    emit(state.copyWith(pickedCinemaIds: cinemaIds));
  }

  Future<void> saveFavoriteCinemas(List<String> cinemaIds) async {
    await cinemasRepository.setFavoriteCinemas(cinemaIds);
    emit(state.copyWith(favoriteCinemaIds: cinemaIds));
  }
}
