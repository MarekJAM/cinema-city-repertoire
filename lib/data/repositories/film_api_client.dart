import 'package:http/http.dart' as http;

import './api_client.dart';
import '../../data/models/models.dart';

class FilmApiClient extends ApiClient {
  final http.Client httpClient;

  FilmApiClient({this.httpClient}) : assert(httpClient != null);

  Future<Film> getFilmDetails(Film film) async {
    var response = await http.get(Uri.parse(film.link));

    if (response.statusCode != 200) {
      throwException(response.statusCode, 'Error getting film details.');
    }

    print(response.body);

    return film;
  }
}
