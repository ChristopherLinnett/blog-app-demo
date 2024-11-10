import 'package:blogapp_flutter/core/typedefs/async_result.dart';

/// A base abstract class for a use case that requires parameters.
///
/// [Type] represents the return type of the use case.
/// [Params] represents the parameter type required for the use case execution.
///
/// This class serves as a contract for implementing use cases that need input parameters
/// to perform their operations.
abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  AsyncResult<Type> call(Params params);
}

/// An abstract class that represents a usecase without parameters.
///
/// Type parameter [Type] represents the return type of the usecase.
/// 
/// This class should be extended by concrete usecases that don't require
/// input parameters to execute their business logic.
abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  AsyncResult<Type> call();
}

/// Represents a synchronous use case that takes parameters and returns a value.
///
/// [Type] is the type of value that the use case will return.
/// [Params] is the type of parameters that the use case requires.
/// 
/// This is typically used for business logic operations that don't require
/// asynchronous operations.
abstract class UsecaseWithParamsSync<Type, Params> {
  const UsecaseWithParamsSync();

  Type call(Params params);
}
