import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/providers/theme/theme_provider.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';

void main() async {
  // 환경변수 불러오기
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // WeatherRepository 객체는 한번만 사용되기에 Provider로 선언
        Provider<WeatherRepository>(
          create: (context) => WeatherRepository(
              weatherApiServices:
                  WeatherApiServices(httpClient: http.Client())),
        ),
        StateNotifierProvider<WeatherProvider, WeatherState>(
          create: (context) => WeatherProvider(),
        ),
        StateNotifierProvider<TempSettingsProvider, TempSettingState>(
            create: (context) => TempSettingsProvider()),
        StateNotifierProvider<ThemeProvider, ThemeState>(
          create: (context) => ThemeProvider(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: context.watch<ThemeState>().appTheme == AppTheme.light
            ? ThemeData.light(useMaterial3: true)
            : ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
