import '../../data/models/models.dart';

sealed class RepertoireState {
  const RepertoireState();
}

final class RepertoireLoading extends RepertoireState {
  @override
  String toString() => 'RepertoireLoading';
}

final class RepertoireLoaded extends RepertoireState {
  final Repertoire data;
  final bool hasFilteringLimitedResults;

  const RepertoireLoaded({required this.data, required this.hasFilteringLimitedResults});

  @override
  String toString() => 'RepertoireLoaded $data';
}

final class RepertoireError extends RepertoireState {
  final String message;

  const RepertoireError({required this.message});

  @override
  String toString() => 'RepertoireError';
}
