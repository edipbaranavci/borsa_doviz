import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../core/components/button/custom_elevated_text_button.dart';
import '../../core/components/dialog/custom_dialog.dart';
import '../../core/constants/views/internet_connection_dialog_strings.dart';

class ConnectionDialog extends StatelessWidget {
  const ConnectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: InternetConnectionDialogStrings.instance.dialogTitle,
      backgroundColor: context.general.colorScheme.surfaceBright,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            InternetConnectionDialogStrings.instance.errorMessage,
            style: context.general.textTheme.bodyMedium?.copyWith(
              color:
                  context.general.appTheme.brightness == Brightness.dark
                      ? context.general.colorScheme.primary
                      : context.general.colorScheme.secondary,
            ),
          ),
          context.sized.emptySizedHeightBoxLow,
          context.sized.emptySizedHeightBoxLow,
          CustomElevatedTextButton(
            onPressed: () => context.route.pop(),
            title: InternetConnectionDialogStrings.instance.closeText,
            textColor: context.general.colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
