part of 'dates_cubit.dart';

enum DatesStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == DatesStatus.loading;
  bool get isSuccess => this == DatesStatus.success;
  bool get isFailure => this == DatesStatus.failure;
}

class DatesState extends Equatable {
  final DatesStatus status;
  final DateTime selectedDate;
  final List<DateTime> dates;

  const DatesState({
    this.status = DatesStatus.initial,
    required this.selectedDate,
    this.dates = const [],
  });

  DatesState copyWith({DatesStatus? status, DateTime? selectedDate, List<DateTime>? dates}) {
    return DatesState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      dates: dates ?? this.dates,
    );
  }

  @override
  List<Object?> get props => [status, selectedDate, dates];
}
