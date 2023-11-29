import 'package:flutter/material.dart';
import 'package:weather_app/const/constants.dart';
import 'package:weather_app/providers/providers.dart';

part 'theme_state.dart';

class ThemeProvider with ChangeNotifier {
  ThemeState _state = ThemeState.initial();

  ThemeState get state => _state;

  // 온도 정보를 불러와 Theme 재설정
  void update(WeatherProvider weatherProvider) {
    final temparature = weatherProvider.state.weather.temp;

    if (temparature < cWarmOrNot) {
      _state = _state.copyWith(appTheme: AppTheme.dark);
    } else {
      _state = _state.copyWith(appTheme: AppTheme.light);
    }

    notifyListeners();
  }
}
