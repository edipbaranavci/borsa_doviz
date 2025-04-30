part of '../view/settings_view.dart';

class _ThemeModeDialog extends StatelessWidget {
  const _ThemeModeDialog();

  final String dialogTitle = 'Tema Modunu Seç';
  final String themeDarkSubTitle = 'Koyu Mod';
  final String themeLightSubTitle = 'Açık Mod';
  final String themeSystemSubTitle = 'Sistem Teması';
  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return CustomDialog(
      title: dialogTitle,
      backgroundColor: context.general.colorScheme.surfaceBright,
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                title: Text(themeDarkSubTitle),
                groupValue: state.themeMode,
                onChanged: (value) {
                  mainCubit.changeThemeMode(value);
                  context.route.pop();
                },
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                title: Text(themeLightSubTitle),
                groupValue: state.themeMode,
                onChanged: (value) {
                  mainCubit.changeThemeMode(value);
                  context.route.pop();
                },
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                title: Text(themeSystemSubTitle),
                groupValue: state.themeMode,
                onChanged: (value) {
                  mainCubit.changeThemeMode(value);
                  context.route.pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
