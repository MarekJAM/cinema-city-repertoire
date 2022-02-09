import './film.dart';

class Films {
  List<Film> _items = [];

  List<Film> get items {
    return [..._items];
  }

  void setFilms(List<dynamic> films) {
    for (var film in films) {
      print(film);

      if ((_items.firstWhere((el) => el.id == film['id'], orElse: () => null)) == null) {
        _items.add(
          Film.fromJson(film)
        );
      }
    }

    _items.sort((a, b) => a.name.compareTo(b.name));
  }
}
