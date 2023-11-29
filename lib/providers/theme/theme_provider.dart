import 'package:state_notifier/state_notifier.dart';
import 'package:weather_app/providers/providers.dart';

part 'theme_state.dart';

class ThemeProvider extends StateNotifier<ThemeState> with LocatorMixin {
  ThemeProvider() : super(ThemeState.initial());

  @override
  void update(Locator watch) {
    final weather = watch<WeatherState>().weather;
    if (weather.temp > 20) {
      state = state.copyWith(appTheme: AppTheme.light);
    } else {
      state = state.copyWith(appTheme: AppTheme.dark);
    }
    super.update(watch);
  }
}
