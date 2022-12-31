import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import './api_client.dart';
import '../../data/models/models.dart';
import '../../utils/web_scraping_helper.dart';

@lazySingleton
class FilmApiClient extends ApiClient {
  final Dio client;

  FilmApiClient({required this.client});

  Future<FilmDetails> getFilmDetails(String url) async {
    var response = await client.get(url);

    return WebScrapingHelper.scrapFilmDetails(response.data);
  }
}
