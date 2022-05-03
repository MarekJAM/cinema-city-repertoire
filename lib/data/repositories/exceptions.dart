abstract class BaseException implements Exception {
  final String message;

  const BaseException([this.message = ""]);

  @override
  String toString() => "BaseException: $message";
}

class ClientException extends BaseException {
  const ClientException([String message]) : super(message);

  @override
  String toString() => "ClientException: $message";
}

class ServerException extends BaseException {
  const ServerException([String message]) : super(message);

  @override
  String toString() => "ServerException: $message";
}
