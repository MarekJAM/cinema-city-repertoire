part of 'film_details_cubit.dart';

abstract class FilmDetailsState extends Equatable {
  const FilmDetailsState();

  @override
  List<Object> get props => [];
}

class FilmDetailsInitial extends FilmDetailsState {}

class FilmDetailsLoading extends FilmDetailsState {}

class FilmDetailsLoaded extends FilmDetailsState {
  final Film film;

  const FilmDetailsLoaded({@required this.film});
}

class FilmDetailsError extends FilmDetailsState {
  final String message;

  const FilmDetailsError({@required this.message});
}
