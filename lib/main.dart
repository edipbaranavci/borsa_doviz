import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/strings/project_strings.dart';
import 'core/init/app_init.dart';
import 'core/init/app_theme.dart';
import 'cubit/main_cubit.dart';
import 'features/views/home_tabs/views/home_tabs_view.dart';

Future<void> main() async {
  await AppInit().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit(),
      child: _MyAppWidget(),
    );
  }
}

class _MyAppWidget extends StatelessWidget {
  const _MyAppWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return MaterialApp(
          title: ProjectStrings.instance.appTitle,
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          theme: AppTheme.instance.getLightTheme(context),
          darkTheme: AppTheme.instance.getDarkTheme(context),
          themeAnimationCurve: Curves.bounceIn,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [Locale('tr', 'TR')],
          home: BlocProvider.value(
            value: context.read<MainCubit>(),
            child: SafeArea(child: HomeTabsView()),
          ),
        );
      },
    );
  }
}
