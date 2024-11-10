import 'package:blogapp_flutter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

/// A type definition for asynchronous operations that may result in either a [Failure] or a success value of type [T].
///
/// The [AsyncResult] combines Dart's [Future] with [Either] to handle both success and failure cases in asynchronous operations.
/// - On success: Returns [Right] containing the value of type [T]
/// - On failure: Returns [Left] containing a [Failure] object
///
/// Example usage:
/// ```dart
/// AsyncResult<User> fetchUser() async {
///   try {
///     final user = await api.getUser();
///     return Right(user);
///   } catch (e) {
///     return Left(Failure(e.toString()));
///   }
/// }
/// ```
typedef AsyncResult<T> = Future<Either<Failure, T>>;
