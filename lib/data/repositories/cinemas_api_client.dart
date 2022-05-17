import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/models.dart';
import './api_client.dart';

class CinemasApiClient extends ApiClient {
  final _cinemasEndpoint = '/cinemas/with-event/until/';

  final http.Client httpClient;

  CinemasApiClient({required this.httpClient});

  Future<List<Cinema>> getCinemas(String date) async {
    final List<Cinema> cinemas = [];

    try {
      final response = await http.get(Uri.parse('${ApiClient.baseUrl}$_cinemasEndpoint$date?attr=&lang=pl_PL'));
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;

      if (response.statusCode != 200) {
        throwException(response.statusCode, 'Error getting cinemas');
      }

      if (extractedData == null) {
        throw Exception("Extracting data issue");
      }

      cinemas.addAll((extractedData['body']['cinemas'] as List).map((e) => Cinema.fromJson(e)));
    } catch (error) {
      rethrow;
    }
    return cinemas;
  }
}
