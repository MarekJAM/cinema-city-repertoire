import 'package:cinema_city/Models/film.dart';

class Films {
  List<Film> _items;

  List<Film> get items {
    return [..._items];
  }

  Map<String, String> genres = {
    'action': 'Akcja',
    'adventure': 'Przygodowy',
    'animation': 'Animowany',
    'bollywood': 'Bollywood',
    'comedy': 'Komedia',
    'crime': 'Kryminalny',
    'documentary': 'Dokument',
    'drama': 'Dramat',
    'family': 'Familijny',
    'fantasy': 'Fantasy',
    'history': 'Historczny',
    'horror': 'Horror',
    'kids-club': 'Dla dzieci',
    'live': 'Na żywo',
    'musical': 'Musical',
    'romance': 'Romantyczny',
    'sci-fi': 'Sci-Fi',
    'sport': 'Sport',
    'thriller': 'Thriller',
    'war': 'Wojenny',
    'western': 'Western'
  };

  void setFilms(List<dynamic> films) {
    List<Film> loadedFilms = [];

    films.forEach((film) {
      var tempAgeRestriction = 'NA';
      List<String> loadedGenres = [];
      
      film['attributeIds'].forEach((attr) {
        genres.forEach((key, val) {
          if (key == attr) {
            loadedGenres.add(val);
          }
        });
        if (attr.toString().contains('plus')) {
          tempAgeRestriction = attr.toString().substring(0, attr.toString().indexOf('-'));
        }
      });

      loadedFilms.add(
        Film(
          id: film['id'],
          name: film['name'],
          ageRestriction: tempAgeRestriction,
          genres: loadedGenres,
          length: film['length'],
          posterLink: film['posterLink'],
        ),
      );
    });
    _items = loadedFilms;
  }
}
