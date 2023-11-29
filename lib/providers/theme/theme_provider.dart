import 'package:weather_app/const/constants.dart';
import 'package:weather_app/providers/providers.dart';

part 'theme_state.dart';

class ThemeProvider {
  final WeatherProvider weatherProvider;

  ThemeProvider({required this.weatherProvider});

  ThemeState get state {
    if (weatherProvider.state.weather.temp > cWarmOrNot) {
      return ThemeState();
    } else {
      return ThemeState(appTheme: AppTheme.dark);
    }
  }
}
