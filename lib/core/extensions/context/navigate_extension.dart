import 'package:flutter/material.dart';

extension IntegerExtension on BuildContext? {
  void pushAndRemoveUntil(Widget page) {
    if (this != null) {
      Navigator.pushAndRemoveUntil(
        this!,
        MaterialPageRoute(builder: (context) => page),
        (_) => false,
      );
    }
  }
}
