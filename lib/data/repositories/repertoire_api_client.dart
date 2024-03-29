import 'package:collection/collection.dart' show IterableExtension;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/models.dart';

@lazySingleton
class RepertoireApiClient {
  final _repertoireEndpoint = '/film-events/in-cinema/';
  final _datesEndpoint = '/dates/in-cinema/';

  final Dio client;

  RepertoireApiClient({@Named('dioCinemaCity') required this.client});

  final _repertoire = Repertoire();

  Future<Repertoire> getRepertoire({
    required String date,
    required List<Cinema>? allCinemas,
    required List<String> cinemaIds,
  }) async {
    List<Response> responseList = await Future.wait(
      cinemaIds.map(
        (cinemaId) => client.get(
          '$_repertoireEndpoint$cinemaId/at-date/$date',
        ),
      ),
    );

    List<dynamic> extFilms = [];
    List<dynamic> extEvents = [];

    for (var response in responseList) {
      extFilms.addAll(response.data['body']['films']);
      extEvents.addAll(response.data['body']['events']);
    }

    final List<Film> films = [];
    final List<Event> events = [];

    for (var film in extFilms) {
      if ((films.firstWhereOrNull((el) => el.id == film['id'])) == null) {
        films.add(Film.fromJson(film));
      }
    }

    for (var event in extEvents) {
      events.add(Event.fromJson(event));
    }

    _repertoire.setItems(films: films, events: events, cinemas: allCinemas);

    return _repertoire;
  }

  Future<List<String>> getDates(String date, List<String> cinemaIds) async {
    List<Response> responseList = await Future.wait(
      cinemaIds.map(
        (cinemaId) => client.get(
          '$_datesEndpoint$cinemaId/until/$date',
        ),
      ),
    );

    List<String> dates = [];

    for (var response in responseList) {
      response.data['body']['dates'].forEach((el) {
        if (!dates.contains(el)) {
          dates.add(el);
        }
      });
    }

    return dates;
  }
}
