import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/seatplan_repository.dart';

part 'seatplan_state.dart';

class SeatplanCubit extends Cubit<SeatplanState> {
  final SeatplanRepository seatplanRepository;

  SeatplanCubit({required this.seatplanRepository}) : super(SeatplanLoading());

  Future<void> getSeatsTaken({required String eventId}) async {
    try {
      final sessionUuid = await seatplanRepository.getSessionUuid(eventId);
      final ticketingStatus = await seatplanRepository.getEventTicketingStatus(eventId);
      if (ticketingStatus.error != null) {
        emit(const SeatplanLoaded(isTicketingFinished: true));
        return;
      }
      final seatplan = await seatplanRepository.getSeatplan(ticketingStatus.venueId!);
      final seatsFree = await seatplanRepository.getFreeSeats(sessionUuid, ticketingStatus.presentationId!);
      emit(SeatplanLoaded(seatsFree: seatsFree, seatsTotal: seatplan.totalSeats));
    } catch(e) {
      emit(SeatplanError());
    }
  }
}
