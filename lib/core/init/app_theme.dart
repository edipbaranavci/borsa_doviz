import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

class AppTheme {
  static AppTheme? _instance;
  AppTheme._();
  static AppTheme get instance => _instance ??= AppTheme._();

  final Color _dixie = const Color(0xffE9A319);
  final Color _brightGray = const Color.fromARGB(255, 66, 70, 77);
  final Color _ebonyClay = const Color(0xff222831);

  ThemeData getDarkTheme(BuildContext context) {
    return FlexThemeData.dark(
      platform: TargetPlatform.android,
      // colors: FlexSchemeColor(primary: _dixie, secondary: _ebonyClay),
      colors: FlexSchemeColor.from(primary: _dixie),
      useMaterial3: true,
    ).copyWith(
      brightness: Brightness.dark,
      cardTheme: Theme.of(context).cardTheme.copyWith(
        color: _ebonyClay,
        shape: RoundedRectangleBorder(
          borderRadius: context.border.lowBorderRadius,
          side: BorderSide(color: _brightGray),
        ),
      ),
      listTileTheme: Theme.of(context).listTileTheme.copyWith(
        // contentPadding: context.padding.low,
        shape: RoundedRectangleBorder(
          borderRadius: context.border.lowBorderRadius,
        ),
      ),
      textTheme: GoogleFonts.robotoTextTheme(),
    );
  }

  ThemeData getLightTheme(BuildContext context) {
    return FlexThemeData.light(
      platform: TargetPlatform.android,
      colors: FlexSchemeColor.from(primary: _dixie),
      useMaterial3: true,
    ).copyWith(
      brightness: Brightness.light,
      cardTheme: Theme.of(context).cardTheme.copyWith(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: context.border.lowBorderRadius,
          side: BorderSide(color: context.general.colorScheme.secondary),
        ),
      ),
      listTileTheme: Theme.of(context).listTileTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: context.border.lowBorderRadius,
        ),
      ),
      textTheme: GoogleFonts.robotoTextTheme(),
    );
  }
}
