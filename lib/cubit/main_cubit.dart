import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/services/storage_service/hive_manager.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial()) {
    getAppThemeMode();
  }

  final _hiveManager = HiveManager();

  Future<void> getAppThemeMode() async {
    final res = await _hiveManager.getAppThemeModel();
    res.fold((left) => null, (right) {
      emit(state.copyWith(themeMode: right));
    });
  }

  Future<void> changeThemeMode(ThemeMode? themeMode) async {
    if (themeMode != null) {
      await _hiveManager.saveAppThemeMode(themeMode);
      emit(state.copyWith(themeMode: themeMode));
    }
  }
}
