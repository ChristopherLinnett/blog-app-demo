class CustomException implements Exception {
  final String message;
  final int statusCode;

  CustomException(this.message, this.statusCode);

  @override
  String toString() {
    return '$runtimeType: $message (Status Code: $statusCode)';
  }

  bool equals(CustomException other) {
    return message == other.message && statusCode == other.statusCode;
  }
}

class ServerException extends CustomException {
  ServerException(super.message, [super.statusCode = 500]);
}

class CacheException extends CustomException {
  CacheException(super.message, [super.statusCode = 500]);
}

class AuthException extends CustomException {
  AuthException(super.message, [super.statusCode = 401]);
}

class FileSystemException extends CustomException {
  FileSystemException(super.message, [super.statusCode = 500]);
}

class UnknownException extends CustomException {
  UnknownException(super.message, [super.statusCode = 500]);
}

class DataFormatException extends CustomException {
  DataFormatException(super.message, [super.statusCode = 400]);
}
