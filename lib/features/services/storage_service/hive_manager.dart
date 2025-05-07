import 'package:borsa_doviz/core/models/tab_index/tab_index_model.dart';
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
  final _tabIndexBox = Hive.box<TabIndexModel>(
    HiveStrings.instance.hiveTabIndexKey,
  );
  final String _themeModeModelKey = '_themeModeModelKey';
  final String _tabIndexModelKey = '_tabIndexModelKey';

  Future<void> saveAppThemeMode(ThemeMode themeMode) async {
    try {
      await _themeModeBox.put(_themeModeModelKey, themeMode);
    } catch (e) {
      ErrorModel(e.toString()).printError();
    }
  }

  Future<void> saveTabIndexModel(int index) async {
    try {
      await _tabIndexBox.put(_tabIndexModelKey, TabIndexModel(index: index));
    } catch (e) {
      ErrorModel(e.toString()).printError();
    }
  }

  Future<Either<ErrorModel, int>> getTabIndex() async {
    try {
      final tabIndexModel = _tabIndexBox.get(_tabIndexModelKey);
      if (tabIndexModel != null) {
        return Right(tabIndexModel.index ?? 0);
      } else {
        return Left(ErrorModel('TabIndex Kaydı Bulunamadı!'));
      }
    } catch (e) {
      Logger().e(e.toString());
      return Left(ErrorModel('HiveManager:getTabIndex() ${e.toString()}'));
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
