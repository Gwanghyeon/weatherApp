import 'package:http/http.dart' as http;

// 정보를 읽어오는 과정에서 발생한 에러를 처리하기 위한 함수
// Exception 의 인자로 전달
// Exception : 오류 메세지 출력
String httpErrorHandler(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPhrease = response.reasonPhrase;

  return 'Request failed\nStatus Code: $statusCode\nReason: $reasonPhrease';
}
