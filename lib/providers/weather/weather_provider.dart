import 'package:flutter/material.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherRepository weatherRepository;
  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;

  WeatherProvider({required this.weatherRepository});

  Future<void> fetchWeather(String city) async {
    _state = _state.copyWith(status: WeatherStatus.loading);
    notifyListeners();

    try {
      final weather = await weatherRepository.fetchWeather(city);
      _state = _state.copyWith(status: WeatherStatus.loaded, weather: weather);
      print('state: $_state');
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(status: WeatherStatus.error, customError: e);
      print('state: $_state');
      notifyListeners();
    }
  }
}
