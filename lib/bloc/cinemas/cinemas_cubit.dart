import 'dart:developer';

import 'package:cinema_city/i18n/strings.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

part 'cinemas_state.dart';

@injectable
class CinemasCubit extends Cubit<CinemasState> {
  final CinemasRepository cinemasRepository;

  CinemasCubit({required this.cinemasRepository}) : super(const CinemasState());

  Future<void> getCinemas() async {
    emit(state.copyWith(status: CinemasStatus.inProgress));
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
          errorMessage: t.cinemas.failedToLoad,
        ),
      );
    }
  }

  void pickCinemas(List<String> cinemaIds) {
    emit(state.copyWith(pickedCinemaIds: cinemaIds));
  }

  Future<void> saveFavoriteCinemas(List<String> cinemaIds) async {
    emit(
      state.copyWith(saveFavoritesStatus: CinemasStatus.inProgress),
    );
    await cinemasRepository.setFavoriteCinemas(cinemaIds);
    emit(state.copyWith(
      saveFavoritesStatus: CinemasStatus.success,
      favoriteCinemaIds: cinemaIds,
    ));
  }
}
