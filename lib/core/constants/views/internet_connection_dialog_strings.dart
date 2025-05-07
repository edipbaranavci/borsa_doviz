class InternetConnectionDialogStrings {
  static InternetConnectionDialogStrings? _instance;
  // Avoid self instance
  InternetConnectionDialogStrings._();
  static InternetConnectionDialogStrings get instance =>
      _instance ??= InternetConnectionDialogStrings._();

  final String dialogTitle = 'Bağlantı Hatası';
  final String errorMessage =
      'İnternet\' e Bağlı değilsiniz, lütfen internet bağlantınızı kontrol ediniz.';
  final String closeText = 'Kapat';
}
