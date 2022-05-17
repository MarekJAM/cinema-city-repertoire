import '../../data/models/models.dart';

abstract class RepertoireState {
  const RepertoireState();
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

  const RepertoireLoaded({required this.data});

  @override
  String toString() => 'RepertoireLoaded $data';
}

class RepertoireError extends RepertoireState {
  final String message;

  const RepertoireError({required this.message});

  @override
  String toString() => 'RepertoireError';
}