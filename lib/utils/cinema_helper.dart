import '../data/models/cinema.dart';

class CinemaHelper {
  static List<Cinema> getCinemasById(List<Cinema> cinemas, List<String> idList) {
    return cinemas.where((cinema) => idList.contains(cinema.id)).toList();
  }

  static Cinema getCinemaById(List<Cinema> cinemas, String? id) {
    return cinemas.firstWhere((cinema) => id == cinema.id);
  }
}