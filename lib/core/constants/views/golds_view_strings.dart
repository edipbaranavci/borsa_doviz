class GoldsViewStrings {
  static GoldsViewStrings? _instance;
  // Avoid self instance
  GoldsViewStrings._();
  static GoldsViewStrings get instance => _instance ??= GoldsViewStrings._();

  final String pageTitle = 'Altın';
  final String lastUpdateTitle = 'Son Güncellenme Tarihi: ';
  final String addedFavoriteTitle = 'Favoriye Eklenenler';
  final String generalListTitle = 'Genel Liste';
}
