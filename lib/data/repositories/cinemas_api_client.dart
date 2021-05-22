import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/models.dart';
import './api_client.dart';

class CinemasApiClient extends ApiClient {
  final _cinemasEndpoint = 'pl/data-api-service/v1/quickbook/10103/cinemas/with-event/until/';

  final http.Client httpClient;

  CinemasApiClient({this.httpClient}) : assert(httpClient != null);

  Future<Cinemas> fetchCinemas(String date) async {
    final String url = 'https://www.cinema-city.pl/$_cinemasEndpoint$date?attr=&lang=pl_PL';

    final Cinemas cinemas = new Cinemas();

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        throwException(response.statusCode, 'Error getting cinemas');
      }

      if (extractedData == null) {
        return null;
      }

      cinemas.setCinemas(extractedData['body']['cinemas']);
    } catch (error) {
      throw error;
    }
    return cinemas;
  }
}
