import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../../core/components/dialog/custom_dialog.dart';
import '../../../../../../core/constants/views/settings_view_strings.dart';
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
      appBar: AppBar(
        title: Text(SettingsViewStrings.instance.pageTitle),
        centerTitle: true,
      ),
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
          buildCardTitle(context, SettingsViewStrings.instance.appTitle),
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return ListTile(
                onTap: () => openThemeModeDialog(context, cubit),
                leading: buildIcon(context, Icons.color_lens),
                title: Text(SettingsViewStrings.instance.themeTitle),
                subtitle: Text(
                  (state.themeMode) == ThemeMode.dark
                      ? SettingsViewStrings.instance.themeDarkSubTitle
                      : (state.themeMode) == ThemeMode.light
                      ? SettingsViewStrings.instance.themeLightSubTitle
                      : SettingsViewStrings.instance.themeSystemSubTitle,
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
          buildCardTitle(context, SettingsViewStrings.instance.contactUsTitle),
          ListTile(
            onTap: () => cubit.openEmailAddress(),
            leading: buildIcon(context, Icons.email),
            title: Text(SettingsViewStrings.instance.contactUsTitle),
            subtitle: Text(SettingsViewStrings.instance.contactUsSubTitle),
          ),
          ListTile(
            onTap: () => cubit.openPrivayPoliticy(),
            leading: buildIcon(context, Icons.privacy_tip),
            title: Text(SettingsViewStrings.instance.privacyPoliticyTitle),
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
          buildCardTitle(context, SettingsViewStrings.instance.aboutTitle),
          ListTile(
            onTap: () => cubit.openGooglePlayStore(),
            leading: buildIcon(context, Icons.store),
            title: Text(SettingsViewStrings.instance.googlePlayStoreTitle),
            subtitle: Text(
              SettingsViewStrings.instance.googlePlayStoreSubTitle,
            ),
          ),
          ListTile(
            leading: buildIcon(context, Icons.verified_sharp),
            title: Text(SettingsViewStrings.instance.appVersionTitle),
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
          buildCardTitle(context, SettingsViewStrings.instance.developerTitle),
          ListTile(
            onTap: () => cubit.openDeveloperWebsite(),
            leading: buildIcon(context, Icons.language),
            title: Text(SettingsViewStrings.instance.websiteTitle),
            subtitle: Text(SettingsViewStrings.instance.websiteSubTitle),
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
