import 'film_details.dart';
import 'genres.dart';

class Film {
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
  String? filmWebScore;

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
    this.filmWebScore,
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
        tempAgeRestriction = attr.toString().substring(0, attr.toString().indexOf('-'));
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
}
