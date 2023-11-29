import 'package:flutter/material.dart';

part 'temp_settings_state.dart';

class TempSettingsProvider with ChangeNotifier {
  TempSettingState _state = TempSettingState.initial();
  // state Getter : 외부에서 state에 접근할 수 있도록 설정
  TempSettingState get state => _state;

  void toggleTempUnit() {
    _state = _state.copyWith(
        tempUnit: _state.tempUnit == TempUnit.celcius
            ? TempUnit.fahrenheit
            : TempUnit.celcius);
    notifyListeners();
  }
}
