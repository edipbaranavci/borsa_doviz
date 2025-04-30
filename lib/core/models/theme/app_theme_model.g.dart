import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 4; // Bu ID benzersiz olmalı (0, 1, 2, 3 zaten kullanılıyorsa 4 kullanın)

  @override
  ThemeMode read(BinaryReader reader) {
    final value = reader.readInt();
    switch (value) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    switch (obj) {
      case ThemeMode.system:
        writer.writeInt(0);
        break;
      case ThemeMode.light:
        writer.writeInt(1);
        break;
      case ThemeMode.dark:
        writer.writeInt(2);
        break;
    }
  }
}
