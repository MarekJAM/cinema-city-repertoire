import 'package:http/http.dart' as http;
import 'dart:convert';

import './api_client.dart';
import '../../data/models/models.dart';

class RepertoireApiClient extends ApiClient {
  final _repertoireEndpoint = '/pl/data-api-service/v1/quickbook/10103/film-events/in-cinema/';

  final http.Client httpClient;

  var _films = new Films();
  var _events = new Events();
  var _cinemas = new Cinemas();

  RepertoireApiClient({this.httpClient}) : assert(httpClient != null);

  Future<Repertoire> fetchRepertoire(
    String date, [
    List<String> cinemaIds,
  ]) async {
    List<http.Response> responseList = await Future.wait(
      cinemaIds.map(
        (cinemaId) => httpClient.get(
          Uri.parse('${ApiClient.baseUrl}$_repertoireEndpoint$cinemaId/at-date/$date?attr=&lang=pl_PL'),
        ),
      ),
    );

    responseList.forEach(
      (response) {
        if (response.statusCode != 200) {
          throwException(response.statusCode, 'Error getting repertoire');
        }
      },
    );

    List<dynamic> extFilms = [];
    List<dynamic> extEvents = [];

    for (var response in responseList) {
      var extResponse = json.decode(response.body);
      extFilms.addAll(extResponse['body']['films']);
      extEvents.addAll(extResponse['body']['events']);
    }

    _films.setFilms(extFilms);
    _events.setEvents(extEvents);

    var _repertoire = new Repertoire();
    _repertoire.setItems(_films, _events, _cinemas);

    return _repertoire;
  }
}
