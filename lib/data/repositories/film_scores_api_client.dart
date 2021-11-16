import 'package:http/http.dart' as http;

import './api_client.dart';
import '../../data/models/models.dart';
import '../../utils/web_scraping_helper.dart';

class FilmScoresApiClient extends ApiClient {
  final http.Client httpClient;

  FilmScoresApiClient({this.httpClient}) : assert(httpClient != null);

  final String _filmWebBaseUrl = 'https://www.filmweb.pl/films/search?q=';

  Future<Film> getFilmWebScore(Film film) async {
    var response = await http.get(
      Uri.parse(
        _filmWebBaseUrl + film.name,
      ),
    );

    if (response.statusCode != 200) {
      return null;
    }

    film.filmWebScore = WebScrapingHelper.scrapFilmWebScore(film, response.body) ?? '-';

    return film;
  }
}
