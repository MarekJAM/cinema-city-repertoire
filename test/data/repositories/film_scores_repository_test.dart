import 'package:cinema_city/data/models/film.dart';
import 'package:cinema_city/data/models/film_rating.dart';
import 'package:cinema_city/data/repositories/film_scores_api_client.dart';
import 'package:cinema_city/data/repositories/film_scores_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFilmScoresApiClient extends Mock implements FilmScoresApiClient {}

Film _film({String id = 'film-id'}) {
  return Film(
    id: id,
    name: 'Film',
    length: 120,
    posterLink: 'posterLink',
    genres: const ['genre'],
    releaseYear: '2026',
    link: 'link',
  );
}

void main() {
  group('FilmScoresRepository', () {
    late MockFilmScoresApiClient apiClient;
    late FilmScoresRepository repository;

    setUp(() {
      apiClient = MockFilmScoresApiClient();
      repository = FilmScoresRepository(filmScoresApiClient: apiClient);
    });

    test(
      'reuses cached rating for later film instances with the same id',
      () async {
        when(() => apiClient.getFilmId('Film')).thenAnswer((_) async => 1);
        when(() => apiClient.getFilmRating(1)).thenAnswer((_) async => '7.5');

        final firstFilm = _film();
        final secondFilm = _film();

        repository.getFilmWebRating(firstFilm);
        await expectLater(
          repository.watchScores,
          emits(predicate<Film>((film) => film.rating is FilmRatingLoaded)),
        );

        repository.getFilmWebRating(secondFilm);

        expect(secondFilm.rating, isA<FilmRatingLoaded>());
        verify(() => apiClient.getFilmId('Film')).called(1);
        verify(() => apiClient.getFilmRating(1)).called(1);
      },
    );
  });
}
