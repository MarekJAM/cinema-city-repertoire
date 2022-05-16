// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_filter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenreFilterAdapter extends TypeAdapter<GenreFilter> {
  @override
  final int typeId = 1;

  @override
  GenreFilter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenreFilter(
      (fields[0] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GenreFilter obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
