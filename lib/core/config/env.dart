class Env {
  Env._();

  static void init() {
    name = const String.fromEnvironment('APP_NAME');
    openWeatherApiKey = const String.fromEnvironment('OPENWEATHER_API_KEY');
  }

  static String name = '';
  static String openWeatherApiKey = '';
}
