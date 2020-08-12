import '../../data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RepertoireState extends Equatable {
  const RepertoireState();

  @override
  List<Object> get props => [];
}

class RepertoireInitial extends RepertoireState {
  @override
  String toString() => 'RepertoireInitial';
}

class RepertoireLoading extends RepertoireState {
  @override
  String toString() => 'RepertoireLoading';
}

class RepertoireLoaded extends RepertoireState {
  final Repertoire data;

  const RepertoireLoaded({@required this.data}) : assert(data != null);

  @override
  String toString() => 'RepertoireLoaded $data';
}

class RepertoireError extends RepertoireState {
  final String message;

  const RepertoireError({@required this.message}) : assert(message != null);

  @override
  String toString() => 'RepertoireError';
}