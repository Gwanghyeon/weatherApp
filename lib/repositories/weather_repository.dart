import 'package:weather_app/exceptions/weather_exception.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  WeatherRepository({required this.weatherApiServices});

  // WeatherApiService 에서 정의한 함수를 사용하여 city 날씨 정보 반환
  // getDirectGeoCoding + getWeather in WeatherApiServices class
  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeoCoding(city);
      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);

      // directGeocoding 에서의 위치 정보로 대치하여 제공
      final Weather weather = tempWeather.copyWith(
          name: directGeocoding.name, country: directGeocoding.country);
      return weather;
    } on WeatherException catch (e) {
      // 에러 종류에 따른 예외처리
      throw CustomError(errMsg: e.errMsg);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
