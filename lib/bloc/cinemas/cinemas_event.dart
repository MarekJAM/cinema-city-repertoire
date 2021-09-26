import 'package:equatable/equatable.dart';

abstract class CinemasEvent extends Equatable {
  const CinemasEvent();

  @override
  List<Object> get props => [];
}

class GetCinemas extends CinemasEvent {
  @override
  String toString() => 'GetCinemas';
}
