import 'dart:convert';
import 'dart:developer';

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
      log('Could not get film id - : ${film.name}');
    }

    return WebScrapingHelper.scrapFilmId(film, response.body);
  }

  Future<Film> getFilmScore(Film film, String filmId) async {
    var response = await http.get(
          Uri.parse('https://www.filmweb.pl/api/v1/film/$filmId/rating'),
        );

    if (response.statusCode != 200) {
      log('Error getting filmWeb score: ${response.body}');
      film.filmWebScore = '-';
      return film;
    }

    var body = json.decode(response.body);

    film.filmWebScore = body['rate'].toString().substring(0, 3);

    return film;
  }
}
