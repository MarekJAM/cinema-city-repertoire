import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './api_client.dart';
import '../../data/models/models.dart';
import '../../utils/web_scraping_helper.dart';

class FilmApiClient extends ApiClient {
  final http.Client httpClient;

  FilmApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Film> getFilmDetails(Film film) async {
    var response = await http.get(
      Uri.parse(
        film.link,
      ),
    );

    if (response.statusCode != 200) {
      throwException(response.statusCode, 'Error getting film details.');
    }

    film.details = WebScrapingHelper.scrapFilmDetails(response.body);

    return film;
  }
}
