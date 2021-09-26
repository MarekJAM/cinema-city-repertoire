import 'package:equatable/equatable.dart';

abstract class RepertoireEvent extends Equatable {
  const RepertoireEvent();

  @override
  List<Object> get props => [];
}

class GetRepertoire extends RepertoireEvent {
  final DateTime date;
  final List<String> cinemaIds;

  const GetRepertoire(this.date, this.cinemaIds);

  @override
  String toString() => 'GetRepertoireDetails { date: $date, cinemaIds: $cinemaIds }';
}