import '../../utils/date_helper.dart';
import '../../data/models/models.dart';
import './repositories.dart';
import 'cinemas_local_storage_api.dart';

class CinemasRepository {
  final CinemasApiClient cinemasApiClient;
  final CinemasLocalStorageApi cinemasLocalStorageApi;

  CinemasRepository({required this.cinemasApiClient, required this.cinemasLocalStorageApi});

  Future<List<Cinema>> getAllCinemas() async {
    var dateInAYear = DateTime.now().add(const Duration(days: 365));

    return await cinemasApiClient.getCinemas(
      DateHelper.convertDateToYYYYMMDD(
        dateInAYear,
      ),
    );
  }

  List<String> getFavoriteCinemas() => cinemasLocalStorageApi.getFavoriteCinemas();

  Future<void> setFavoriteCinemas(List<String> cinemaIds) async => await cinemasLocalStorageApi.setFavoriteCinemas(cinemaIds);
}