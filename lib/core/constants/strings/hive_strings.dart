class HiveStrings {
  static HiveStrings? _instance;
  // Avoid self instance
  HiveStrings._();
  static HiveStrings get instance => _instance ??= HiveStrings._();
  final String borsaDovizBox = 'borsaDovizBox';
  final String hiveThemeModeBoxKey = 'hiveThemeModeBoxKey';
  final String hiveTabIndexKey = 'hiveTabIndexKey';
}
