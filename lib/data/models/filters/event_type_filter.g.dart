// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_type_filter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventTypeFilterAdapter extends TypeAdapter<EventTypeFilter> {
  @override
  final typeId = 0;

  @override
  EventTypeFilter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventTypeFilter(
      (fields[0] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventTypeFilter obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.eventTypes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventTypeFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
