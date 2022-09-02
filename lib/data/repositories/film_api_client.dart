import 'package:http/http.dart' as http;

import './api_client.dart';
import '../../data/models/models.dart';
import '../../utils/web_scraping_helper.dart';

class FilmApiClient extends ApiClient {
  final http.Client httpClient;

  FilmApiClient({required this.httpClient});

  Future<FilmDetails> getFilmDetails(String url) async {
    var response = await http.get(
      Uri.parse(
        url,
      ),
    );

    if (response.statusCode != 200) {
      throwException(response.statusCode, 'Error getting film details.');
    }

    return WebScrapingHelper.scrapFilmDetails(response.body);
  }
}