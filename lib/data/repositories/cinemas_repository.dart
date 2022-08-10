import '../../utils/date_helper.dart';
import '../../data/models/models.dart';
import './repositories.dart';

class CinemasRepository {
  final CinemasApiClient cinemasApiClient;

  CinemasRepository({required this.cinemasApiClient});

  Future<List<Cinema>> getAllCinemas() async {
    var dateInAYear = DateTime.now().add(const Duration(days: 365));

    return await cinemasApiClient.getCinemas(
      DateHelper.convertDateToYYYYMMDD(
        dateInAYear,
      ),
    );
  }
}