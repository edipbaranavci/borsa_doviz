class CryptoViewStrings {
  static CryptoViewStrings? _instance;
  // Avoid self instance
  CryptoViewStrings._();
  static CryptoViewStrings get instance => _instance ??= CryptoViewStrings._();

  final String pageTitle = 'Kripto';
  final String lastUpdateTitle = 'Son Güncellenme Tarihi: ';
  final String addedFavoriteTitle = 'Favoriye Eklenenler';
  final String generalListTitle = 'Genel Liste';
}
