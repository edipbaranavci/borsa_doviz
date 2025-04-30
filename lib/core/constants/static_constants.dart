class StaticConstants {
  static StaticConstants? _instance;
  // Avoid self isntance
  StaticConstants._();
  static StaticConstants get instance {
    _instance ??= StaticConstants._();
    return _instance!;
  }
}
