class SettingsViewStrings {
  static SettingsViewStrings? _instance;
  // Avoid self instance
  SettingsViewStrings._();
  static SettingsViewStrings get instance =>
      _instance ??= SettingsViewStrings._();

  final String pageTitle = 'Ayarlar';
  final String appTitle = 'Uygulama';
  final String themeTitle = 'Tema';
  final String themeDarkSubTitle = 'Koyu Mod';
  final String themeLightSubTitle = 'Açık Mod';
  final String themeSystemSubTitle = 'Sistem Teması';
  final String helpTitle = 'Yardım';
  final String contactUsTitle = 'İletişime Geç';
  final String contactUsSubTitle = 'Tavsiye / Öneri / Hata';
  final String privacyPoliticyTitle = 'Gizlilik Politikası';
  final String aboutTitle = 'Hakkında';
  final String googlePlayStoreTitle = 'Google Play Store';
  final String googlePlayStoreSubTitle =
      "Google Play Store' dan yorum yapabilirsin";
  final String appVersionTitle = 'Uygulama Versiyonu';
  final String developerTitle = 'Geliştirici';
  final String websiteTitle = 'Website';
  final String websiteSubTitle =
      'Geliştiricinin websitesini ziyaret edebilirsin';
}
