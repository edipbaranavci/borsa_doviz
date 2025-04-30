import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomDropDownFormField<Object> extends StatelessWidget {
  const CustomDropDownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.prefixTitle,
    this.onTap,
    this.isCloseMenu = false,
  });

  final String prefixTitle;
  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?)? onChanged;
  final VoidCallback? onTap;
  final bool isCloseMenu;

  OutlineInputBorder outlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: context.border.lowBorderRadius,
      borderSide: BorderSide(color: context.general.colorScheme.primary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Object>(
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      onTap: onTap,
      borderRadius: context.border.lowBorderRadius,
      decoration: InputDecoration(
        border: outlineInputBorder(context),
        contentPadding: context.padding.low,
        enabledBorder: outlineInputBorder(context),
        focusedBorder: outlineInputBorder(context),
        disabledBorder: outlineInputBorder(context),
        labelText: prefixTitle.isNotEmpty ? '$prefixTitle   ' : prefixTitle,
        labelStyle: context.general.textTheme.titleMedium?.copyWith(
          color: context.general.colorScheme.primary,
        ),
      ),
      menuMaxHeight: isCloseMenu ? 0 : null,
      value: value,
      isExpanded: true,
      elevation: isCloseMenu ? 0 : 8,
      style: context.general.appTheme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.general.colorScheme.primary,
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
