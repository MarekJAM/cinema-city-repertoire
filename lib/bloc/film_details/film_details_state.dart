part of 'film_details_cubit.dart';

sealed class FilmDetailsState extends Equatable {
  const FilmDetailsState();

  @override
  List<Object> get props => [];
}

final class FilmDetailsLoading extends FilmDetailsState {}

final class FilmDetailsLoaded extends FilmDetailsState {
  final Film film;

  const FilmDetailsLoaded({required this.film});
}

final class FilmDetailsError extends FilmDetailsState {
  final String message;

  const FilmDetailsError({required this.message});
}
