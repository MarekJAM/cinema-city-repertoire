import 'dart:convert';

import 'package:http/http.dart' as http;

import './api_client.dart';
import '../../data/models/models.dart';
import '../../utils/web_scraping_helper.dart';

class FilmScoresApiClient extends ApiClient {
  final http.Client httpClient;

  FilmScoresApiClient({required this.httpClient});

  static const String _filmWebBaseUrl = 'https://www.filmweb.pl/films/search?q=';

  Future<String> getFilmId(Film film) async {
    var response = await http.get(
      Uri.parse(
        _filmWebBaseUrl + film.name,
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Could not get film id.');
    }

    return WebScrapingHelper.scrapFilmId(film, response.body);
  }

  Future<Film> getFilmScore(Film film, String filmId) async {
    var response = await http.get(
          Uri.parse('https://www.filmweb.pl/api/v1/film/$filmId/rating'),
        );

    if (response.statusCode != 200) {
      throw Exception('Could not get film score.');
    }

    var body = json.decode(response.body);

    film.filmWebScore = body['rate'].toString().substring(0, 3);

    return film;
  }
}
