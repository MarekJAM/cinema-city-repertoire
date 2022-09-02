import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/repositories.dart';
import '../../data/models/models.dart';

part 'film_details_state.dart';

class FilmDetailsCubit extends Cubit<FilmDetailsState> {
  final RepertoireRepository repertoireRepository;

  FilmDetailsCubit({required this.repertoireRepository}) : super(FilmDetailsInitial());

  void getFilmDetails(Film film) async {
    emit(FilmDetailsLoading());
    try {
      film.details = await repertoireRepository.getFilmDetails(film.link);
      emit(FilmDetailsLoaded(film: film));
    } catch (e) {
      log('$e');
      emit(const FilmDetailsError(message: 'Nie udało się pobrać informacji o filmie.'));
    }
  }
}