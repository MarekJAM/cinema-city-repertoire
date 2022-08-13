part of 'cinemas_cubit.dart';

enum CinemasStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == CinemasStatus.loading;
  bool get isSuccess => this == CinemasStatus.success;
  bool get isFailure => this == CinemasStatus.failure;
}

class CinemasState extends Equatable {
  final CinemasStatus status;
  final List<Cinema> cinemas;
  final List<String> favoriteCinemaIds;
  final List<String> pickedCinemaIds;
  final String errorMessage;

  const CinemasState({
    this.status = CinemasStatus.initial,
    this.cinemas = const [],
    this.favoriteCinemaIds = const [],
    this.pickedCinemaIds = const [],
    this.errorMessage = '',
  });

  CinemasState copyWith({
    CinemasStatus? status,
    List<Cinema>? cinemas,
    List<String>? favoriteCinemaIds,
    List<String>? pickedCinemaIds,
    String? errorMessage,
  }) {
    return CinemasState(
      status: status ?? this.status,
      cinemas: cinemas ?? this.cinemas,
      favoriteCinemaIds: favoriteCinemaIds ?? this.favoriteCinemaIds,
      pickedCinemaIds: pickedCinemaIds ?? this.pickedCinemaIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, cinemas, favoriteCinemaIds, pickedCinemaIds, errorMessage];
}