import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTitleText extends StatelessWidget {
  const CustomTitleText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: context.general.textTheme.titleLarge?.copyWith(
          color:
              context.general.appTheme.brightness == Brightness.dark
                  ? context.general.colorScheme.primary
                  : context.general.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
