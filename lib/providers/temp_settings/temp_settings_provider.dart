import 'package:flutter_state_notifier/flutter_state_notifier.dart';

part 'temp_settings_state.dart';

class TempSettingsProvider extends StateNotifier<TempSettingState> {
  TempSettingsProvider() : super(TempSettingState.initial());

  void toggleTempUnit() {
    state = state.copyWith(
        tempUnit: state.tempUnit == TempUnit.celcius
            ? TempUnit.fahrenheit
            : TempUnit.celcius);
  }
}
