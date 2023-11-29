// ignore_for_file: public_member_api_docs, sort_constructors_first
// Weather 에서 발생할 수 있는 오류를 다루기 위한 클래스
import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errMsg;

  CustomError({this.errMsg = ''});

  @override
  List<Object> get props => [errMsg];

  @override
  String toString() => 'CustomError(message: $errMsg)';
}
