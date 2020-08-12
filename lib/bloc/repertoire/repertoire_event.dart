import 'package:equatable/equatable.dart';

abstract class RepertoireEvent extends Equatable {
  const RepertoireEvent();

  @override
  List<Object> get props => [];
}

class FetchRepertoire extends RepertoireEvent {
  final DateTime date;
  final List<String> cinemaIds;

  const FetchRepertoire(this.date, this.cinemaIds);

  @override
  String toString() => 'FetchRepertoireDetails { date: $date, cinemaIds: $cinemaIds }';
}