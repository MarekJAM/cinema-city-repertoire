part of 'seatplan_cubit.dart';

sealed class SeatplanState extends Equatable {
  const SeatplanState();

  @override
  List<Object?> get props => [];
}

final class SeatplanLoading extends SeatplanState {}

final class SeatplanLoaded extends SeatplanState {
  final int? seatsFree;
  final int? seatsTotal;
  final bool isTicketingFinished;

  const SeatplanLoaded({this.seatsFree, this.seatsTotal, this.isTicketingFinished = false});

  @override
  List<Object?> get props => [seatsFree, seatsTotal];
}

final class SeatplanError extends SeatplanState {}