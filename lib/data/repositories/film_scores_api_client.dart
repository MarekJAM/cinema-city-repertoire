import 'package:dio/dio.dart';

import './api_client.dart';
import '../../data/models/models.dart';

class FilmScoresApiClient extends ApiClient {
  final Dio dio;

  FilmScoresApiClient({required this.dio});

  static const String filmWebBaseUrl = 'https://www.filmweb.pl/api/v1';

  Future<int> _getFilmId(Film film) async {
    var response = await dio.get(
      "$filmWebBaseUrl/live/search?query=${Uri.encodeComponent(film.name.toLowerCase())}",
    );

    return response.data['searchHits'][0]['id'];
  }

  Future<String> _getFilmScore(int filmId) async {
    var response = await dio.get(
      '$filmWebBaseUrl/film/$filmId/rating',
    );

    return response.data['rate'].toString().substring(0, 3);
  }

  Future<String> getFilmWebScore(Film film) async {
    var filmId = await _getFilmId(film);
    return _getFilmScore(filmId);
  }
}
