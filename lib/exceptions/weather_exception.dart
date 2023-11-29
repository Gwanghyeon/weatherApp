// API 에서 받아온 데이터의 바디가 비어있는 경우를 처리하기 위한 클래스
class WeatherException implements Exception {
  String errMsg;
  WeatherException({this.errMsg = 'Somthing wrong'}) {
    errMsg = 'Weather Exception: $errMsg';
  }

  @override
  String toString() => errMsg;
}
