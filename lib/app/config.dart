enum Environment { development, staging, production }

class Config {
  static const Environment environment = Environment.development;

  // Preview mode keeps the UI usable while the backend is unavailable.
  // Override with --dart-define=VIDSPOD_PREVIEW_MODE=false when APIs are ready.
  static const bool previewMode = bool.fromEnvironment(
    'VIDSPOD_PREVIEW_MODE',
    defaultValue: true,
  );

  static String get apiUrl {
    switch (environment) {
      case Environment.staging:
        return 'https://staging.api.vidspod.com/api/v1';
      case Environment.production:
        return 'https://api.vidspod.com/api/v1';
      case Environment.development:
        return 'http://localhost:8000/api/v1';
    }
  }
}
