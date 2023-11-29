// ignore_for_file: public_member_api_docs, sort_constructors_first
// 좌표정보를 저장하기 위한 클래스
import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;

  DirectGeocoding(
      {required this.name,
      required this.lat,
      required this.lon,
      required this.country});

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0]; // 첫번째 데이터만을 사용

    return DirectGeocoding(
        name: data['name'],
        lat: data['lat'],
        lon: data['lon'],
        country: data['country']);
  }

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  bool get stringify => true;
}
