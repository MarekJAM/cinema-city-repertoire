import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/models.dart';

@lazySingleton
class SeatplanApiClient {
  final Dio client;

  SeatplanApiClient({@Named('dioCinemaCityTickets') required this.client});

  Future<String> getSessionUuid(String eventId) async {
    final response = await client.get('order/$eventId?lang=pl');
    return response.headers['Set-Cookie'].toString().substring(6, 42);
  }

  Future<EventTicketingStatus> getEventTicketingStatus(String eventId) async {
    final response = await client.get('presentations/$eventId');
    return EventTicketingStatus.fromJson(response.data);
  }

  Future<Seatplan> getSeatplan(String venueId) async {
    final response = await client.get('seats/seatplanV2?venueId=$venueId&seatplanId=1');
    return Seatplan.fromJson(response.data);
  }

  Future<int> getFreeSeats(String sessionUuid, String presentationId) async {
    final response = await client.get('seats/seats-statusV2?presentationId=$presentationId&venueTypeId=1&isReserved=1', options: Options(headers: {'Uuid': sessionUuid}));
    return (response.data['seats'] as Map<String, dynamic>).length;
  }
}