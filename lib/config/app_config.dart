class AppConfig {
  // YouTube API Key (빌드 시 주입)
  static const String youtubeApiKey = String.fromEnvironment(
    'YOUTUBE_API_KEY',
    defaultValue: '',
  );

  // Google OAuth Client ID
  static const String androidClientId = String.fromEnvironment(
    'ANDROID_CLIENT_ID',
    defaultValue: '',
  );

  // 앱 정보
  static const String appName = 'TubeDeck';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.tubedeck.app';

  // YouTube API OAuth Scopes
  static const List<String> youtubeScopes = [
    'https://www.googleapis.com/auth/youtube.readonly',
  ];

  // 데이터베이스
  static const String databaseName = 'tubedeck.db';
  static const int databaseVersion = 8;

  // API 제한
  static const int maxChannelsPerRequest = 50;
  static const int dailyApiQuotaLimit = 10000;

  // 캐시 설정
  static const int maxMemoryCacheSize = 100;
  static const int maxDiskCacheSize = 200 * 1024 * 1024; // 200MB
  static const Duration cacheValidDuration = Duration(days: 7);
}
