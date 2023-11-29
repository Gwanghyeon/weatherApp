import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/const/constants.dart';
import 'package:weather_app/exceptions/weather_exception.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({
    required this.httpClient,
  });

  // 사용자 입력 정보를 바탕으로 좌표정보를 받아오는 함수
  Future<DirectGeocoding> getDirectGeoCoding(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: cApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': cLimit,
        'appid': dotenv.env['APIKEY'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);

      // 오류 발생시 에러 처리: 별도 함수
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = json.decode(response.body);

      // 받아온 정보가 비어있는 경우
      if (responseBody.isEmpty) {
        // Custom Exception 클래스 throw
        throw WeatherException('Cannot get the location of $city');
      }

      // 오류가 없을 경우 DirectGeocoding 객체 반환
      return DirectGeocoding.fromJson(responseBody);
    } catch (e) {
      // 해당 함수를 호출한 곳으로 오류 전파
      // rethrow: 여기서 오류처리를 하지않고 호출한 곳으로 에러를 던짐
      rethrow;
    }
  }

  // 좌표를 이용해 날씨를 반환
  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: cApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lon}',
        'units': cUnit,
        'appid': dotenv.get('APIKEY'),
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final weatherJson = json.decode(response.body);
      return Weather.fromJson(weatherJson);
    } catch (e) {
      rethrow;
    }
  }
}
