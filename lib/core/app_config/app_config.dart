class AppConfig {
  final String baseUrl;

  AppConfig({required this.baseUrl});

  static AppConfig? _instance;

  static void initialize({required String baseUrl}) {
    _instance = AppConfig(baseUrl: baseUrl);
  }

  static AppConfig get instance {
    if (_instance == null) {
      throw Exception("AppConfig is not initialized");
    }
    return _instance!;
  }
}
