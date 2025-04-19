abstract class CommonException implements Exception {
  final String message;
  const CommonException(this.message);
}

class AuthException extends CommonException {
  const AuthException(super.message);
}

class VerificationException extends CommonException {
  const VerificationException(super.message);
}

class NetworkException extends CommonException {
  const NetworkException(super.message);
}

class ServerException extends CommonException {
  const ServerException(super.message);
}
