import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String msg;
  final int? code;

  const CustomException(this.msg,{ this.code});

  @override
  String toString() {
    return msg;
  }
  
  @override
  List<Object?> get props => [msg];
}

class FetchDataException extends CustomException {
  const FetchDataException([msg]) : super(msg??"Error During Communication");
}

class BadRequestException extends CustomException {
  const BadRequestException([msg]) : super(msg??"Bad Request");
}
class NoVerifiedException extends CustomException {
  const NoVerifiedException([msg]) : super(msg??"Bad Request");
}

class UnauthorizedException extends CustomException {
  const UnauthorizedException([msg]) : super(msg??"Unauthorized");
}

class NotFoundException extends CustomException {
  const NotFoundException([msg]) : super(msg??"Requested Info Not Found");
}

class ConflictException extends CustomException {
  const ConflictException([msg]) : super(msg??"Conflict Occurred");
}

class InternalServerErrorException extends CustomException {
  const InternalServerErrorException([msg])
      : super(msg??"Internal Server Error");
}

class NoInternetConnectionException extends CustomException {
  const NoInternetConnectionException([msg])
      : super(msg??"No Internet Connection");
}

class CacheException implements Exception {}
