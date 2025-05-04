part of '../view/doviz_view.dart';

class _ConnectionDialog extends StatelessWidget {
  const _ConnectionDialog();

  final String dialogTitle = 'Bağlantı Hatası';
  final String errorMessage =
      'İnternet\' e Bağlı değilsiniz, lütfen internet bağlantınızı kontrol ediniz.';
  final String closeText = 'Kapat';
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: dialogTitle,
      backgroundColor: context.general.colorScheme.surfaceBright,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            errorMessage,
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
            title: closeText,
            textColor: context.general.colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
