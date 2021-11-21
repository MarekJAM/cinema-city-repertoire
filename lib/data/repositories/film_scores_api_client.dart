import 'package:http/http.dart' as http;

import './api_client.dart';
import '../../data/models/models.dart';
import '../../utils/web_scraping_helper.dart';

class FilmScoresApiClient extends ApiClient {
  final http.Client httpClient;

  FilmScoresApiClient({this.httpClient}) : assert(httpClient != null);

  static const String _filmWebBaseUrl = 'https://www.filmweb.pl/films/search?q=';

  static Future<Film> getFilmWebScore(Film film) async {
    var response = await http.get(
      Uri.parse(
        _filmWebBaseUrl + film.name,
      ),
    );

    if (response.statusCode != 200) {
      return null;
    }

    film.filmWebScore = await WebScrapingHelper.scrapFilmWebScore(film, response.body) ?? '-';

    return film;
  }
}
