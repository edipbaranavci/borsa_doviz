import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiMode, SystemChrome;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/strings/hive_strings.dart';
import '../models/favorite/favorite_model.dart';
import '../models/theme/app_theme_model.g.dart';

class AppInit {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final appPath = await getApplicationDocumentsDirectory();
    final path = '${appPath.path}/ekabav/';
    await Hive.initFlutter(path);
    Hive
      ..registerAdapter<ThemeMode>(ThemeModeAdapter())
      ..registerAdapter<FavoriteModel>(FavoriteModelAdapter());
    await Hive.openBox<ThemeMode>(
      HiveStrings.instance.hiveThemeModeBoxKey,
      path: path,
    );
    await Hive.openBox<FavoriteModel>(
      HiveStrings.instance.borsaDovizBox,
      path: path,
    );
  }
}
