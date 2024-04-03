import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilmScoresApiClient {
  final Dio client;

  FilmScoresApiClient({@Named('dioFilmweb') required this.client});

  Future<int> getFilmId(String filmName) async {
    var response = await client.get(
      "/live/search?query=${Uri.encodeComponent(filmName.toLowerCase())}",
    );

    final firstResult = response.data['searchHits'][0];

    if (filmName.toLowerCase() != firstResult['matchedTitle'].toString().toLowerCase()) {
      throw Exception("Failed to get filmweb score for movie: $filmName - mismatched movie title");
    }

    return response.data['searchHits'][0]['id'];
  }

  Future<String> getFilmRating(int filmId) async {
    var response = await client.get(
      '/film/$filmId/rating',
    );

    return response.data['rate'].toString().substring(0, 3);
  }
}
