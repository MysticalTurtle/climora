import 'package:climora/app/app.dart';
import 'package:climora/bootstrap.dart';
import 'package:climora/core/core.dart';
import 'package:climora/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.init();
  final dio = await DioInstance().getDioInstance(
    secureStorage: const FlutterSecureStorage(),
  );
  await di.init(dio: dio, apiKey: Env.openWeatherApiKey);
  await bootstrap(() => const App());
}
