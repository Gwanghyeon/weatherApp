import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherProvider extends StateNotifier<WeatherState> with LocatorMixin {
  WeatherProvider() : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    state = state.copyWith(status: WeatherStatus.loading);

    try {
      final weather = await read<WeatherRepository>().fetchWeather(city);
      state = state.copyWith(status: WeatherStatus.loaded, weather: weather);
    } on CustomError catch (e) {
      state = state.copyWith(status: WeatherStatus.error, customError: e);
    }
  }
}
