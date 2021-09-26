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

  FilmDetailsLoaded({@required this.film});
}
