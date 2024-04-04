sealed class FilmRating {
  const FilmRating();
}

class FilmRatingInitial extends FilmRating {
  const FilmRatingInitial();
}

class FilmRatingLoading extends FilmRating {
  const FilmRatingLoading();
}

class FilmRatingLoaded extends FilmRating {
  final double rating;

  const FilmRatingLoaded({required this.rating});
}

class FilmRatingError extends FilmRating {
  const FilmRatingError();
}