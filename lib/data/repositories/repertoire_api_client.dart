import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './api_client.dart';
import '../../data/models/models.dart';

class RepertoireApiClient extends ApiClient {
  final _repertoireEndpoint = '/film-events/in-cinema/';
  final _datesEndpoint = '/dates/in-cinema/';

  final http.Client httpClient;

  RepertoireApiClient({this.httpClient}) : assert(httpClient != null);

  final _repertoire = Repertoire();

  Future<Repertoire> getRepertoire(
    {
    @required String date, 
    @required List<Cinema> allCinemas,
    @required List<String> cinemaIds,
  }) async {
    List<http.Response> responseList = await Future.wait(
      cinemaIds.map(
        (cinemaId) => httpClient.get(
          Uri.parse('${ApiClient.baseUrl}$_repertoireEndpoint$cinemaId/at-date/$date?attr=&lang=pl_PL'),
        ),
      ),
    );

    for (var response in responseList) {
        if (response.statusCode != 200) {
          throwException(response.statusCode, 'Error getting repertoire');
        }
      }

    List<dynamic> extFilms = [];
    List<dynamic> extEvents = [];

    for (var response in responseList) {
      var extResponse = json.decode(response.body);
      extFilms.addAll(extResponse['body']['films']);
      extEvents.addAll(extResponse['body']['events']);
    }

    final List<Film> films = [];
    final List<Event> events = [];

    for (var film in extFilms) {
      if ((films.firstWhere((el) => el.id == film['id'], orElse: () => null)) == null) {
        films.add(
          Film.fromJson(film)
        );
      }
    }

    for (var event in extEvents) {
      events.add(Event.fromJson(event));
    }

    _repertoire.setItems(films: films, events: events, cinemas: allCinemas);

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

    for (var response in responseList) {
        if (response.statusCode != 200) {
          throwException(response.statusCode, 'Error getting dates');
        }
      }

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
