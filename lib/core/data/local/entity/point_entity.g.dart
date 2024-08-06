// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointEntityAdapter extends TypeAdapter<PointEntity> {
  @override
  final int typeId = 1;

  @override
  PointEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointEntity(
      name: fields[0] as String,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PointEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
