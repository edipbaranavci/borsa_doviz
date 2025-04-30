import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../services/storage_service/hive_manager.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial()) {
    _init();
  }

  final _hiveManager = HiveManager();

  // final String _playStoreUrl =
  //     'https://play.google.com/store/apps/details?id=com.ekabav.safak_sayar';
  final String _privacyPoliticyUrl =
      'https://www.ekabav.dev/p/gizlilik-politikasi.html';
  final String _emailAddress = 'ekabavapps@gmail.com';
  final String _websiteUrl = 'https://www.ekabav.dev/';

  Future<void> _init() async {
    await _getAppVersion();
  }

  Future<void> changeThemeMode(ThemeMode? themeMode) async {
    if (themeMode != null) {
      await _hiveManager.saveAppThemeMode(themeMode);
    }
  }

  Future<void> openEmailAddress() async {
    final url = Uri.parse('mailto:$_emailAddress');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Logger().e(Exception('Could not launch $url'));
    }
  }

  Future<void> openPrivayPoliticy() async {
    final url = Uri.parse(_privacyPoliticyUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Logger().e(Exception('Could not launch $url'));
    }
  }

  Future<void> openGooglePlayStore() async {
    // final url = Uri.parse(_playStoreUrl);
    // if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    //   Logger().e(Exception('Could not launch $url'));
    // }
  }

  Future<void> openDeveloperWebsite() async {
    final Uri url = Uri.parse(_websiteUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Logger().e(Exception('Could not launch $url'));
    }
  }

  Future<void> _getAppVersion() async {
    final res = await PackageInfo.fromPlatform();
    emit(state.copyWith(appVersion: res.version));
  }
}
