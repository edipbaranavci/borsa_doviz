import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: context.general.textTheme.bodyMedium?.copyWith(
        color:
            context.general.appTheme.brightness == Brightness.dark
                ? context.general.colorScheme.primary
                : context.general.colorScheme.secondary,
      ),
    );
  }
}
