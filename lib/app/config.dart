enum Environment {
  development,
  staging,
  production,
}

class Config {
  static const Environment environment = Environment.development;

  static String get apiUrl {
    switch (environment) {
      case Environment.staging:
        return 'https://staging.api.vidspod.com/api/v1';
      case Environment.production:
        return 'https://api.vidspod.com/api/v1';
      case Environment.development:
      default:
        return 'http://localhost:8000/api/v1';
    }
  }
}
