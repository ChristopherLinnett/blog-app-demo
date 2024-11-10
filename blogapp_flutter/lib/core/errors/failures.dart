import 'exceptions.dart';

abstract class Failure {
  final String message;
  final dynamic statusCode;

  Failure(this.message, this.statusCode) {
    if (statusCode is! int && statusCode is! String) {
      throw ArgumentError(
          '${statusCode.runtimeType} is not valid for a statusCode. Use a String or integer only.');
    }
  }

  String get errorMessage {
    return '$statusCode${statusCode is int ? " Error" : ""}: $message';
  }

  bool equals(Failure other) {
    return message == other.message && statusCode == other.statusCode;
  }
}

class CacheFailure extends Failure {
  CacheFailure(super.message, super.statusCode);

  factory CacheFailure.fromException(CacheException exception) {
    return CacheFailure(exception.message, exception.statusCode);
  }
}

class ServerFailure extends Failure {
  ServerFailure(super.message, super.statusCode);

  factory ServerFailure.fromException(ServerException exception) {
    return ServerFailure(exception.message, exception.statusCode);
  }
}

class AuthFailure extends Failure {
  AuthFailure(super.message, super.statusCode);

  factory AuthFailure.fromException(AuthException exception) {
    return AuthFailure(exception.message, exception.statusCode);
  }
}

class FileSystemFailure extends Failure {
  FileSystemFailure(super.message, super.statusCode);

  factory FileSystemFailure.fromException(FileSystemException exception) {
    return FileSystemFailure(exception.message, 500);
  }
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message, super.statusCode);

  factory UnknownFailure.fromException(dynamic exception) {
    return UnknownFailure(
        exception is UnknownException
            ? exception.message
            : "An unknown error has occurred",
        500);
  }
}

class DataFormatFailure extends Failure {
  DataFormatFailure(super.message, super.statusCode);

  factory DataFormatFailure.fromException(DataFormatException exception) {
    return DataFormatFailure(exception.message, exception.statusCode);
  }
}
