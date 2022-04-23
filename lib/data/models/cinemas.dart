// import 'cinema.dart';

// class Cinemas {
//   static final Cinemas _singleton = Cinemas._internal();

//   factory Cinemas() {
//     return _singleton;
//   }

//   Cinemas._internal();

//   List<Cinema> _items = [];

//   List<Cinema> get items {
//     return [..._items];
//   }

//   List<Cinema> getCinemasById(List<String> idList) {
//     return items.where((cinema) => idList.contains(cinema.id)).toList();
//   }

//   String getCinemaNameById(String id) {
//     return items.firstWhere((cinema) => id == cinema.id).displayName;
//   }

//   void setCinemas(List<dynamic> cinemas) {
//     List<Cinema> loadedCinemas = [];
//     cinemas.forEach((cinema) {
//       loadedCinemas.add(Cinema.fromJson(cinema));
//     });
//     _items = loadedCinemas;
//   }
// }
