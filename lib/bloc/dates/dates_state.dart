part of 'dates_cubit.dart';

abstract class DatesState {
  const DatesState();
}

class DatesInitial extends DatesState {}

class DatesLoading extends DatesState {}

class DatesLoaded extends DatesState {
  final List<DateTime> dates;

  const DatesLoaded(this.dates);
}

class DatesError extends DatesState {
  final String message;

  const DatesError(this.message);
}