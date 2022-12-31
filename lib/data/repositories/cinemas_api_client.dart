import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/models.dart';
import './api_client.dart';

@lazySingleton
class CinemasApiClient extends ApiClient {
  final _cinemasEndpoint = '/cinemas/with-event/until/';

  final Dio client;

  CinemasApiClient({required this.client});

  Future<List<Cinema>> getCinemas(String date) async {
    final List<Cinema> cinemas = [];

    final response = await client.get('${ApiClient.baseUrl}$_cinemasEndpoint$date?attr=&lang=pl_PL');

    cinemas.addAll((response.data['body']['cinemas'] as List).map((e) => Cinema.fromJson(e)));
    return cinemas;
  }
}