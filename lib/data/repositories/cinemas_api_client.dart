import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/models.dart';

@lazySingleton
class CinemasApiClient {
  final _cinemasEndpoint = '/cinemas/with-event/until/';

  final Dio client;

  CinemasApiClient({@Named('dioCinemaCity') required this.client});

  Future<List<Cinema>> getCinemas(String date) async {
    final List<Cinema> cinemas = [];

    final response = await client.get('$_cinemasEndpoint$date');

    cinemas.addAll((response.data['body']['cinemas'] as List).map((e) => Cinema.fromJson(e)));
    return cinemas;
  }
}