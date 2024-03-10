import 'dart:developer';

import 'package:cinema_city/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/repositories.dart';
import '../../data/models/models.dart';

part 'film_details_state.dart';

@injectable
class FilmDetailsCubit extends Cubit<FilmDetailsState> {
  final RepertoireRepository repertoireRepository;

  FilmDetailsCubit({required this.repertoireRepository}) : super(FilmDetailsLoading());

  void getFilmDetails(Film film) async {
    emit(FilmDetailsLoading());
    try {
      film.details = await repertoireRepository.getFilmDetails(film.link);
      emit(FilmDetailsLoaded(film: film));
    } catch (e) {
      log('$e');
      emit(FilmDetailsError(message: t.filmDetails.failedToLoad));
    }
  }
}