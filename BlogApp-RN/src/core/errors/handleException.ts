import {
  AuthException,
  CacheException,
  DataFormatException,
  FileSystemException,
  ServerException,
  UnknownException,
} from "./exceptions";
import {
  AuthFailure,
  CacheFailure,
  DataFormatFailure,
  Failure,
  FileSystemFailure,
  ServerFailure,
  UnknownFailure,
} from "./failures";

export const handleException: (exception: unknown) => Failure = (exception) => {
  if (exception instanceof AuthException)
    return AuthFailure.fromException(exception);
  if (exception instanceof ServerException)
    return ServerFailure.fromException(exception);
  if (exception instanceof FileSystemException)
    return FileSystemFailure.fromException(exception);
  if (exception instanceof DataFormatException)
    return DataFormatFailure.fromException(exception);
  if (exception instanceof CacheException)
    return CacheFailure.fromException(exception);
  if (exception instanceof UnknownException)
    return UnknownFailure.fromException(exception);
  return new UnknownFailure("An uknown error has occurred", 500);
};
