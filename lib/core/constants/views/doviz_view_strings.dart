class DovizViewStrings {
  static DovizViewStrings? _instance;
  // Avoid self instance
  DovizViewStrings._();
  static DovizViewStrings get instance => _instance ??= DovizViewStrings._();

  final String pageTitle = 'Doviz';
  final String lastUpdateTitle = 'Son Güncellenme Tarihi: ';
  final String addedFavoriteTitle = 'Favoriye Eklenenler';
  final String generalListTitle = 'Genel Liste';
}
