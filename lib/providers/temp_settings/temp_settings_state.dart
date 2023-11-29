// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'temp_settings_provider.dart';

enum TempUnit { celcius, fahrenheit }

class TempSettingState {
  final TempUnit tempUnit;

  TempSettingState({this.tempUnit = TempUnit.celcius});

  factory TempSettingState.initial() => TempSettingState();

  TempSettingState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }

  @override
  String toString() => 'TempSettingState(tempUnit: $tempUnit)';
}
