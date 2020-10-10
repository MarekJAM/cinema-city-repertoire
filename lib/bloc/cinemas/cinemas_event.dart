import 'package:equatable/equatable.dart';

abstract class CinemasEvent extends Equatable {
  const CinemasEvent();

  @override
  List<Object> get props => [];
}

class FetchCinemas extends CinemasEvent {
  @override
  String toString() => 'FetchCinemas';
}
