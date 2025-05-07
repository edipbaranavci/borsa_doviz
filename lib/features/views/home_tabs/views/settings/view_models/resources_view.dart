part of '../view/settings_view.dart';

class _ResourcesView extends StatelessWidget {
  _ResourcesView();

  final String title = 'Kullanılan Kaynaklar';
  final String apiTitle =
      '"Truncgil Finans - Ücretsiz Döviz ve Finans Bilgileri Bilgi Sağlayıcı Finans API" sitesinden ücretsiz bir şekilde uygulamamıza entegre ederek sizlere sunuyoruz.';

  final String borsaUsedTitle = 'Borsa verileri';
  final String uiUsedTitle = 'Ui';
  final String backendUsedTitle = 'Backend';

  final List<String> uiUsedList = [
    'Flutter',
    'google_mobile_ads',
    'kartal',
    'flex_color_scheme',
    'google_fonts',
    'package_info_plus',
    'intl',
    'flutter_localization',
  ];

  final List<String> backendUsedList = [
    'url_launcher',
    'http',
    'hive',
    'hive_flutter',
    'logger',
    'flutter_bloc',
    'equatable',
    'either_dart',
    'connectivity_plus',
    'upgrader',
    'path_provider',
    'cupertino_icons',
    'hive_generator',
    'build_runner',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Kullanılan Kaynaklar'),
      body: SingleChildScrollView(
        padding: context.padding.low,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildApiCard(context),
            buildUiCard(context),
            buildBackEndCard(context),
          ],
        ),
      ),
    );
  }

  Card buildBackEndCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.padding.low,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildCardTitle(context, backendUsedTitle),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: backendUsedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  leading: buildDot(context),
                  title: SelectableText(backendUsedList[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Card buildUiCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.padding.low,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildCardTitle(context, uiUsedTitle),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: uiUsedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  leading: buildDot(context),
                  title: SelectableText(uiUsedList[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Card buildApiCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.padding.low,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCardTitle(context, borsaUsedTitle),
            ListTile(
              leading: buildDot(context),
              title: SelectableText(apiTitle),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardTitle(BuildContext context, String title) {
    return Padding(
      padding: context.padding.normal,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: context.general.textTheme.titleLarge?.copyWith(
          color:
              context.general.appTheme.brightness == Brightness.dark
                  ? context.general.colorScheme.primary
                  : context.general.colorScheme.secondary,
        ),
      ),
    );
  }

  Widget buildDot(BuildContext context) {
    return Text(
      "•",
      style: context.general.textTheme.headlineMedium?.copyWith(
        color:
            context.general.appTheme.brightness == Brightness.dark
                ? context.general.colorScheme.primary
                : null,
      ),
    );
  }
}
