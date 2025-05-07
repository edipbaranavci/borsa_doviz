class HomeTabsViewStrings {
  static HomeTabsViewStrings? _instance;
  // Avoid self instance
  HomeTabsViewStrings._();
  static HomeTabsViewStrings get instance =>
      _instance ??= HomeTabsViewStrings._();
  final String dovizTitle = 'Döviz';
  final String goldTitle = 'Altın';
  final String cryptoTitle = 'Kripto';
  final String settingsTitle = 'Ayarlar';
}
