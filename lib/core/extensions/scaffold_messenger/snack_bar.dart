import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

extension SnackBarExtension on GlobalKey<ScaffoldState> {
  RoundedRectangleBorder get roundedRectangleBorder => RoundedRectangleBorder(
    borderRadius:
        currentState?.context.border.lowBorderRadius ?? BorderRadius.zero,
  );

  get context => currentContext;

  void showGreatSnackBar(String message, {Color? textColor, Color? backColor}) {
    return _showSnackBar(
      message,
      true,
      backColor: backColor,
      textColor: textColor,
    );
  }

  void showErrorSnackBar(String message, {Color? textColor, Color? backColor}) {
    return _showSnackBar(
      message,
      false,
      backColor: backColor,
      textColor: textColor,
    );
  }

  void closeSnackBar() => ScaffoldMessenger.of(context).clearSnackBars();

  void showLoadingBar() {
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          shape: roundedRectangleBorder,
          behavior: SnackBarBehavior.floating,
          backgroundColor: currentState?.context.general.colorScheme.primary,
          content: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }
  }

  void _showSnackBar(
    String message,
    bool isGreat, {
    Color? textColor,
    Color? backColor,
  }) {
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1500),
          // width: (currentState?.context.sized.width ?? 1000) * .95,
          shape: roundedRectangleBorder,
          backgroundColor: backColor ?? (isGreat ? Colors.green : Colors.red),
          content: ListTile(
            shape: roundedRectangleBorder,
            leading: buildIcon(
              isGreat ? Icons.done : Icons.error_outline,
              textColor,
            ),
            title: buildMessage(currentState?.context, message, textColor),
            tileColor: backColor ?? (isGreat ? Colors.green : Colors.red),
          ),
          behavior: SnackBarBehavior.floating,
          padding: currentState?.context.padding.low,
        ),
      );
    }
  }

  Text buildMessage(BuildContext? context, String message, Color? textColor) {
    return Text(
      message,
      style: context?.general.textTheme.bodyMedium?.copyWith(
        color: textColor ?? Colors.white,
      ),
    );
  }
}

Icon buildIcon(IconData? icon, Color? textColor) {
  return Icon(icon, color: textColor ?? Colors.white);
}
