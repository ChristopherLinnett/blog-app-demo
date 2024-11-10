import 'exceptions.dart';
import 'failures.dart';

Failure handleException(Object exception) {
  if (exception is AuthException) {
    return AuthFailure.fromException(exception);
  } else if (exception is ServerException) {
    return ServerFailure.fromException(exception);
  } else if (exception is FileSystemException) {
    return FileSystemFailure.fromException(exception);
  } else if (exception is DataFormatException) {
    return DataFormatFailure.fromException(exception);
  } else if (exception is CacheException) {
    return CacheFailure.fromException(exception);
  } else if (exception is UnknownException) {
    return UnknownFailure.fromException(exception);
  }
  return UnknownFailure("An unknown error has occurred", 500);
}
