import './film.dart';

class Films {
  List<Film> _items = [];

  List<Film> get items {
    return [..._items];
  }


  void setFilms(List<dynamic> films) {
    mainLoop: for(var film in films) {
      for(var loadedFilm in _items) {
        if(loadedFilm.id == film['id']){
          break mainLoop;
        }
      }

      _items.add(
        Film.fromJson(
          film
        ),
      );
    }
    
    _items.sort((a, b) => a.name.compareTo(b.name));
  }
}
