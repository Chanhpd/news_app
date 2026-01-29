class AppConstants {
  // API Configuration
  static const String newsApiBaseUrl = 'https://newsapi.org/v2';
  static const String newsApiKey = '88a94bdf28174b318f14394a5ac96e64';
  
  // App Information
  static const String appName = 'Smart News';
  static const String appVersion = '1.0.0';
  
  // Pagination
  static const int pageSize = 20;
  static const int initialPage = 1;
  
  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 1);
  
  // Timeout
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Keys
  static const String bookmarksKey = 'bookmarks';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
}
