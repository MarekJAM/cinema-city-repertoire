// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_filter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreFilterAdapter extends TypeAdapter<ScoreFilter> {
  @override
  final typeId = 2;

  @override
  ScoreFilter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScoreFilter(
      (fields[0] as num?)?.toDouble(),
      fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ScoreFilter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.showFilmsWithNoScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
