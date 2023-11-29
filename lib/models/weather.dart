import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String name;
  final String country;
  final DateTime lasteUpdated;

  Weather({
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.name,
    required this.country,
    required this.lasteUpdated,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return Weather(
        description: weather['description'],
        icon: weather['icon'],
        temp: main['temp'],
        tempMin: main['temp_min'],
        tempMax: main['temp_max'],
        name: '',
        country: '',
        lasteUpdated: DateTime.now());
  }

  // 겹치지 않을 값들로 초기화
  // Weather 상태를 다룰 때에 null 값을 방지하기 위한 초기화 함수
  factory Weather.initial() => Weather(
      description: '',
      icon: '',
      temp: 100,
      tempMin: 100,
      tempMax: 100,
      name: '',
      country: '',
      lasteUpdated: DateTime(1970));

  @override
  List<Object> get props => [
        description,
        icon,
        temp,
        tempMin,
        tempMax,
        name,
        country,
        lasteUpdated,
      ];

  Weather copyWith({
    String? description,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? name,
    String? country,
    DateTime? lasteUpdated,
  }) {
    return Weather(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      name: name ?? this.name,
      country: country ?? this.country,
      lasteUpdated: lasteUpdated ?? this.lasteUpdated,
    );
  }

  @override
  bool get stringify => true;
}
