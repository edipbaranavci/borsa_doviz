part of '../views/home_tabs_view.dart';

class _ConnectionDialog extends StatelessWidget {
  const _ConnectionDialog();

  final String dialogTitle = 'İnternet Bağlantısı';
  final String errorMessage =
      'İnternet\' e Bağlı değilsiniz, lütfen internet bağlantınızı kontrol ediniz.';
  final String retryText = 'Tekrar Dene';
  final String closeText = 'Kapat';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeTabsCubit>();
    return CustomDialog(
      title: dialogTitle,
      backgroundColor: context.general.colorScheme.surfaceBright,
      child: Column(
        children: [
          Text(errorMessage),
          context.sized.emptySizedHeightBoxLow,
          const CircularProgressIndicator(),
          Row(
            children: [
              Expanded(
                child: CustomElevatedTextButton(
                  onPressed: () => cubit.checkInternetConnection(),
                  title: retryText,
                ),
              ),
              Expanded(
                child: CustomElevatedTextButton(
                  onPressed: () => context.route.pop(),
                  title: closeText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
