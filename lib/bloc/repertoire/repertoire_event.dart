import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class RepertoireEvent extends Equatable {
  const RepertoireEvent();

  @override
  List<Object> get props => [];
}

class GetRepertoire extends RepertoireEvent {
  final DateTime? date;
  final List<String>? pickedCinemaIds;
  final List<Cinema>? allCinemas;

  const GetRepertoire({this.date, this.pickedCinemaIds, this.allCinemas});

  @override
  String toString() => 'GetRepertoireDetails { date: $date, cinemaIds: $pickedCinemaIds }';
}

class FiltersChanged extends RepertoireEvent {
  final List<RepertoireFilter> filters;

  const FiltersChanged(this.filters);

  @override
  String toString() => 'FiltersChanged { filters: $filters';
}