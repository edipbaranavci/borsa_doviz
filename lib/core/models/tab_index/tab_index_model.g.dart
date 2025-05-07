// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_index_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TabIndexModelAdapter extends TypeAdapter<TabIndexModel> {
  @override
  final int typeId = 5;

  @override
  TabIndexModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TabIndexModel(
      index: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TabIndexModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabIndexModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
