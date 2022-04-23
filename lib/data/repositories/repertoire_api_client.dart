import 'package:http/http.dart' as http;
import 'dart:convert';

import './api_client.dart';
import '../../data/models/models.dart';

class RepertoireApiClient extends ApiClient {
  final _repertoireEndpoint = '/film-events/in-cinema/';
  final _datesEndpoint = '/dates/in-cinema/';

  final http.Client httpClient;

  var _films = new Films();
  var _events = new Events();
  var _cinemas = new Cinemas();

  RepertoireApiClient({this.httpClient}) : assert(httpClient != null);

  Future<Repertoire> getRepertoire(
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

    var _repertoire = Repertoire(films: _films, events: _events, cinemas: _cinemas);

    return _repertoire;
  }

  Future<List<String>> getDates(String date, List<String> cinemaIds) async {
    List<http.Response> responseList = await Future.wait(
      cinemaIds.map(
        (cinemaId) => httpClient.get(
          Uri.parse('${ApiClient.baseUrl}$_datesEndpoint$cinemaId/until/$date?attr=&lang=pl_PL'),
        ),
      ),
    );

    responseList.forEach(
      (response) {
        if (response.statusCode != 200) {
          throwException(response.statusCode, 'Error getting dates');
        }
      },
    );

    List<String> dates = [];

    for (var response in responseList) {
      var extResponse = json.decode(response.body);
      extResponse['body']['dates'].forEach((el) {
        if (!dates.contains(el)) {
          dates.add(el);
        }
      });
    }

    return dates;
  }
}
