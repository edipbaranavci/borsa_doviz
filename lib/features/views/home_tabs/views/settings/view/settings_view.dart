import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import '../../../../../../core/components/dialog/custom_dialog.dart';
import '../../../../../../cubit/main_cubit.dart';
import '../cubit/settings_cubit.dart';

part '../view_models/theme_mode_dialog.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();
  final String pageTitle = 'Ayarlar';

  final String appTitle = 'Uygulama';

  final String themeTitle = 'Tema';
  final String themeDarkSubTitle = 'Koyu Mod';
  final String themeLightSubTitle = 'Açık Mod';
  final String themeSystemSubTitle = 'Sistem Teması';
  final String helpTitle = 'Yardım';
  final String contactUsTitle = 'İletişime Geç';
  final String contactUsSubTitle = 'Tavsiye / Öneri / Hata';
  final String privacyPoliticyTitle = 'Gizlilik Politikası';
  final String aboutTitle = 'Hakkında';
  final String googlePlayStoreTitle = 'Google Play Store';
  final String googlePlayStoreSubTitle =
      "Google Play Store' dan yorum yapabilirsin";
  final String appVersionTitle = 'Uygulama Versiyonu';
  final String developerTitle = 'Geliştirici';
  final String websiteTitle = 'Website';
  final String websiteSubTitle =
      'Geliştiricinin websitesini ziyaret edebilirsin';

  void openThemeModeDialog(BuildContext context, SettingsCubit cubit) {
    showDialog(
      context: context,
      builder:
          (context) =>
              BlocProvider.value(value: cubit, child: const _ThemeModeDialog()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle), centerTitle: true),
      body: SingleChildScrollView(
        padding: context.padding.low,
        child: Column(
          children: [
            buildAppCard(context),
            context.sized.emptySizedHeightBoxLow,
            buildHelpCard(context),
            context.sized.emptySizedHeightBoxLow,
            buildAboutCard(context),
            context.sized.emptySizedHeightBoxLow,
            buildDeveloperCard(context),
            context.sized.emptySizedHeightBoxLow3x,
          ],
        ),
      ),
    );
  }

  Card buildAppCard(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return Card(
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildCardTitle(context, appTitle),
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return ListTile(
                onTap: () => openThemeModeDialog(context, cubit),
                leading: buildIcon(context, Icons.color_lens),
                title: Text(themeTitle),
                subtitle: Text(
                  (state.themeMode) == ThemeMode.dark
                      ? themeDarkSubTitle
                      : (state.themeMode) == ThemeMode.light
                      ? themeLightSubTitle
                      : themeSystemSubTitle,
                ),
                trailing: Card(
                  color: context.general.colorScheme.onSurface,
                  child: Padding(
                    padding: context.padding.low,
                    child: Icon(
                      Icons.palette,
                      color:
                          context.general.colorScheme.brightness ==
                                  Brightness.dark
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          context.sized.emptySizedHeightBoxLow,
        ],
      ),
    );
  }

  Card buildHelpCard(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return Card(
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildCardTitle(context, contactUsTitle),
          ListTile(
            onTap: () => cubit.openEmailAddress(),
            leading: buildIcon(context, Icons.email),
            title: Text(contactUsTitle),
            subtitle: Text(contactUsSubTitle),
          ),
          ListTile(
            onTap: () => cubit.openPrivayPoliticy(),
            leading: buildIcon(context, Icons.privacy_tip),
            title: Text(privacyPoliticyTitle),
          ),
          context.sized.emptySizedHeightBoxLow,
        ],
      ),
    );
  }

  Card buildAboutCard(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return Card(
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildCardTitle(context, aboutTitle),
          ListTile(
            onTap: () => cubit.openGooglePlayStore(),
            leading: buildIcon(context, Icons.store),
            title: Text(googlePlayStoreTitle),
            subtitle: Text(googlePlayStoreSubTitle),
          ),
          ListTile(
            leading: buildIcon(context, Icons.verified_sharp),
            title: Text(appVersionTitle),
            subtitle: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return Text(state.appVersion ?? '');
              },
            ),
          ),
          context.sized.emptySizedHeightBoxLow,
        ],
      ),
    );
  }

  Card buildDeveloperCard(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return Card(
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildCardTitle(context, developerTitle),
          ListTile(
            onTap: () => cubit.openDeveloperWebsite(),
            leading: buildIcon(context, Icons.language),
            title: Text(websiteTitle),
            subtitle: Text(websiteSubTitle),
          ),
          context.sized.emptySizedHeightBoxLow,
        ],
      ),
    );
  }

  Widget buildCardTitle(BuildContext context, String title) {
    return Padding(
      padding: context.padding.normal,
      child: Text(
        title,
        style: context.general.textTheme.titleLarge?.copyWith(
          color:
              context.general.appTheme.brightness == Brightness.dark
                  ? context.general.colorScheme.primary
                  : context.general.colorScheme.secondary,
        ),
      ),
    );
  }

  Card buildIcon(BuildContext context, IconData iconData) {
    return Card(
      color: context.general.colorScheme.onSurface,
      child: Padding(
        padding: context.padding.low,
        child: Icon(
          iconData,
          color: context.general.colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
