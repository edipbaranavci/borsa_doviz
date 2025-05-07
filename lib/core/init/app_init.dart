import 'package:borsa_doviz/core/models/tab_index/tab_index_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiMode, SystemChrome;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/strings/hive_strings.dart';
import '../models/favorite/favorite_model.dart';
import '../models/theme/app_theme_model.g.dart';

class AppInit {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await MobileAds.instance.initialize();
    final appPath = await getApplicationDocumentsDirectory();
    final path = '${appPath.path}/ekabav/';
    await Hive.initFlutter(path);
    Hive
      ..registerAdapter<ThemeMode>(ThemeModeAdapter())
      ..registerAdapter<TabIndexModel>(TabIndexModelAdapter())
      ..registerAdapter<FavoriteModel>(FavoriteModelAdapter());
    await Hive.openBox<ThemeMode>(
      HiveStrings.instance.hiveThemeModeBoxKey,
      path: path,
    );
    await Hive.openBox<FavoriteModel>(
      HiveStrings.instance.borsaDovizBox,
      path: path,
    );
    await Hive.openBox<TabIndexModel>(
      HiveStrings.instance.hiveTabIndexKey,
      path: path,
    );
  }
}
