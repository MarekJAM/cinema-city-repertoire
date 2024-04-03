import 'package:cinema_city/utils/random_number_generator.dart';

import 'film_details.dart';
import 'genres.dart';

final class Film {
  final String id;
  final String name;
  final int? length;
  final String? posterLink;
  final List<String> genres;
  final String ageRestriction;
  final String? releaseYear;
  final String link;
  final String? videoLink;
  FilmDetails? details;
  FilmRating rating;

  Film({
    required this.id,
    required this.name,
    required this.length,
    required this.posterLink,
    required this.genres,
    required this.ageRestriction,
    required this.releaseYear,
    required this.link,
    this.videoLink,
    this.details,
    this.rating = const FilmRatingInitial(),
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    var tempAgeRestriction = 'NA';
    List<String> loadedGenres = [];

    json['attributeIds'].forEach((attr) {
      genreMap.forEach((key, val) {
        if (key == attr) {
          loadedGenres.add(val);
        }
      });
      if (attr.toString().contains('plus')) {
        final extractedValue = attr.toString().substring(0, attr.toString().indexOf('-'));
        if (extractedValue.length <= 2) {
          tempAgeRestriction = extractedValue;
        }
      }
    });

    return Film(
      id: json['id'],
      name: json['name'],
      ageRestriction: tempAgeRestriction,
      genres: loadedGenres,
      length: json['length'],
      posterLink: json['posterLink']?.replaceFirst("md.jpg", "lg.jpg"),
      releaseYear: json['releaseYear'],
      link: json['link'],
      videoLink: json['videoLink']
    );
  }

  static Film get mock => Film(
    id: '1',
    name: 'F' * RandomNumberGenerator.randomInRange(min: 6, max: 20),
    ageRestriction: '18',
    genres: List.generate(RandomNumberGenerator.randomInRange(min: 1, max: 4), (index) => 'Genre'),
    length: 120,
    posterLink: 'posterLink',
    releaseYear: '1999',
    link: 'link',
    rating: const FilmRatingLoading(),
    videoLink: 'videolink',
    details: FilmDetails.mock,
  );
}

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