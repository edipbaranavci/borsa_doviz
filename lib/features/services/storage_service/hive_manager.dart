import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../core/constants/strings/hive_strings.dart';
import '../../../core/models/error_model.dart';
import '../../../core/models/favorite/favorite_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  final _box = Hive.box<FavoriteModel>(HiveStrings.instance.borsaDovizBox);
  final _themeModeBox = Hive.box<ThemeMode>(
    HiveStrings.instance.hiveThemeModeBoxKey,
  );
  final String _themeModeModelKey = '_themeModeModelKey';

  Future<void> saveAppThemeMode(ThemeMode themeMode) async {
    try {
      await _themeModeBox.put(_themeModeModelKey, themeMode).whenComplete(() {
        print('Tema modu kaydedildi!');
      });
    } catch (e) {
      ErrorModel(e.toString()).printError();
    }
  }

  Future<Either<ErrorModel, ThemeMode>> getAppThemeModel() async {
    try {
      final themeMode = _themeModeBox.get(_themeModeModelKey);
      if (themeMode != null) {
        return Right(themeMode);
      } else {
        Logger().e('Tema modu kaydı bulunamadı!');
        return Left(ErrorModel('Tema modu kaydı bulunamadı!'));
      }
    } catch (e) {
      Logger().e(e.toString());
      return Left(ErrorModel('HiveManager:getAppThemeModel() ${e.toString()}'));
    }
  }

  List<FavoriteModel> getFavorites() {
    try {
      final list = _box.values.toList();
      if (list.isEmpty) {
        Logger().e('Liste Boş!');
        return [];
      } else {
        return _box.values.toList();
      }
    } catch (e) {
      Logger().e(e.toString());
      return [];
    }
  }

  Future<void> addFavoriteModel(FavoriteModel favoriteModel) async {
    await _box.put(favoriteModel.code ?? '', favoriteModel);
  }

  Future<void> deleteFavorite(String favoriteCode) async {
    await _box.delete(favoriteCode);
  }
}
