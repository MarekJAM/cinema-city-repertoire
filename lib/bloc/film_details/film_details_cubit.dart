import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../data/repositories/repositories.dart';
import '../../data/models/models.dart';

part 'film_details_state.dart';

class FilmDetailsCubit extends Cubit<FilmDetailsState> {
  final RepertoireRepository repertoireRepository;

  FilmDetailsCubit({@required this.repertoireRepository}) : super(FilmDetailsInitial());

  void getFilmDetails(Film film) async {
    emit(FilmDetailsLoading());

    try {
      await repertoireRepository.getFilmDetails(film);

      emit(FilmDetailsLoaded(film: film));
    } on ClientException catch (e) {
      print(e);
      emit(const FilmDetailsError(message: 'Błąd połączenia.'));
    } on ServerException catch (e) {
      print(e);
      emit(const FilmDetailsError(message: 'Błąd wewnętrzny serwera.'));
    } catch (e) {
      print(e);
      emit(const FilmDetailsError(message: 'Wystąpił nieznany błąd.'));
    }
  }
}
