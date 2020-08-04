import './film.dart';

class Films {
  List<Film> _items;

  List<Film> get items {
    return [..._items];
  }


  void setFilms(List<dynamic> films) {
    List<Film> loadedFilms = [];

    mainLoop: for(var film in films) {
      for(var loadedFilm in loadedFilms) {
        if(loadedFilm.id == film['id']){
          break mainLoop;
        }
      }

      loadedFilms.add(
        Film.fromJson(
          film
        ),
      );
    }
    loadedFilms.sort((a, b) => a.name.compareTo(b.name));
    _items = loadedFilms;
  }
}
