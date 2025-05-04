class CustomListLiteCardStrings {
  static CustomListLiteCardStrings? _instance;
  // Avoid self instance
  CustomListLiteCardStrings._();
  static CustomListLiteCardStrings get instance =>
      _instance ??= CustomListLiteCardStrings._();

  final String addFavoriteTitle = 'Favorilere Ekle';
  final String removeFavoriteTitle = 'Favorilerden Çıkar';
}
