import '../../data/models/models.dart';
import './api_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CinemasApiClient extends ApiClient {
  final _cinemaseEndpoint =
      'pl/data-api-service/v1/quickbook/10103/cinemas/with-event/until/';

  final http.Client httpClient;

  CinemasApiClient({this.httpClient}) : assert(httpClient != null);

  Future<Cinemas> fetchData(String date) async {
    final String url =
        'https://www.cinema-city.pl/$_cinemaseEndpoint$date?attr=&lang=pl_PL';
      
    final Cinemas cinemas = new Cinemas();

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      if (extractedData == null) {
        return null;
      }

      extractedData['body']['cinemas'].forEach((cinema) {
        cinemas.items.add(Cinema.fromJson(cinema));
      });

    } catch (error) {
      throw error;
    }
    return cinemas;
  }
}
