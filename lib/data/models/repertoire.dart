import './models.dart';

class Repertoire {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [..._items];
  }
  
  set items(List<Map<String, dynamic>> items) {
    this._items = items;
  }

  void setRepertoire(Films films, Events events, Cinemas cinemas) {
    films.items.forEach((film) {
      Map<String, dynamic> filmTile = {};
      filmTile.putIfAbsent('film', () => film);
      var filmEvents = events.findEventsByFilmId(film.id);
      filmEvents.forEach((event) {
        filmTile.putIfAbsent(
          cinemas.getCinemaNameById(event.cinemaId),
          () => events.filterEventsByCinemaId(filmEvents, event.cinemaId),
        );
      });
      
      if (filmEvents.length > 0) {
        _items.add(filmTile);
      }
    });
  }
}
