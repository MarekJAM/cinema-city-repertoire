final class EventTicketingStatus {
  final String? venueId;
  final String? presentationId;
  final EventTicketingStatusError? error;

  EventTicketingStatus({required this.venueId, this.presentationId, this.error});

  factory EventTicketingStatus.fromJson(Map<String, dynamic> json) {
    final hasError = json['error'] != null;
    return EventTicketingStatus(
      venueId: hasError ? null : json['presentation']['venueId'].toString(),
      presentationId: hasError ? null : json['presentation']['id'].toString(),
      error: hasError
          ? EventTicketingStatusError.values.firstWhere((element) => element.propertyName == json['error']['error'])
          : null,
    );
  }
}

enum EventTicketingStatusError {
  ticketingEnded('TICKETING_ENDED');

  final String propertyName;
  const EventTicketingStatusError(this.propertyName);
}
