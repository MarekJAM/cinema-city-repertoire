import '../../utils/date_helper.dart';
import '../../data/models/models.dart';
import './repositories.dart';

class RepertoireRepository {
  final RepertoireApiClient repertoireApiClient;
  final FilmApiClient filmApiClient;
  final FilmScoresApiClient filmScoresApiClient;

  RepertoireRepository({
    required this.repertoireApiClient,
    required this.filmApiClient,
    required this.filmScoresApiClient,
  });

  Future<Repertoire> getRepertoire({required DateTime date, required List<Cinema>? allCinemas, required List<String> pickedCinemaIds}) async {
    return await repertoireApiClient.getRepertoire(
      date: DateHelper.convertDateToYYYYMMDD(
        date,
      ),
      allCinemas: allCinemas,
      cinemaIds: pickedCinemaIds,
    );
  }

  Future<List<DateTime>> getDates(DateTime date, List<String> cinemaIds) async {
    var stringDates = await repertoireApiClient.getDates(
      DateHelper.convertDateToYYYYMMDD(
        date,
      ),
      cinemaIds,
    );
    return stringDates.map((date) => DateTime.parse(date)).toList();
  }

  Future<Film> getFilmDetails(Film film) async {
    return await filmApiClient.getFilmDetails(film);
  }

  Repertoire? filterRepertoire(List<RepertoireFilter> filters, Repertoire? repertoire) {
    var filteredRepertoire = repertoire;

    if (filters.isNotEmpty) {
      for (var el in filters) {
        filteredRepertoire = el.filter(filteredRepertoire);
      }
    }

    return filteredRepertoire;
  }
}
