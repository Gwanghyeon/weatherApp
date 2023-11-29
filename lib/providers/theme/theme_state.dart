part of 'theme_provider.dart';

enum AppTheme { light, dark }

class ThemeState {
  final AppTheme appTheme;

  ThemeState({this.appTheme = AppTheme.light});

  factory ThemeState.initial() => ThemeState();

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }

  @override
  String toString() => 'ThemeState(appTheme: $appTheme)';
}
