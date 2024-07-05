import 'package:injectable/injectable.dart';

import '../models/models.dart';
import 'seatplan_api_client.dart';

@lazySingleton
class SeatplanRepository {
  final SeatplanApiClient apiClient;

  SeatplanRepository({
    required this.apiClient,
  });

  Future<String> getSessionUuid(String eventId) async {
    return apiClient.getSessionUuid(eventId);
  }

  Future<EventTicketingStatus> getEventTicketingStatus(String eventId) async {
    return apiClient.getEventTicketingStatus(eventId);
  }

  Future<Seatplan> getSeatplan(String venueId) async {
    return apiClient.getSeatplan(venueId);
  }

  Future<int> getFreeSeats(String sessionUuid, String presentationId) async {
    return apiClient.getFreeSeats(sessionUuid, presentationId);
  }
}