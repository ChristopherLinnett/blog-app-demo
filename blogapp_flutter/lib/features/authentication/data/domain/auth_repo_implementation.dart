import 'package:blogapp_flutter/core/errors/handle_exception.dart';
import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/features/authentication/data/datasources/auth_datasource.dart';
import 'package:blogapp_flutter/features/authentication/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../models/auth_response.dart';
import '../models/response_message.dart';

class AuthRepoImplementation implements AuthRepo {
  final AuthDatasource datasource;
  late String url;

  AuthRepoImplementation(this.datasource);

  @override
  AsyncResult<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await datasource.login(username, password);
      return Right(response);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }

  @override
  AsyncResult<AuthResponse> signUp(
      {required String username, required String password}) async {
    try {
      final response = await datasource.signUp(username, password);
      return Right(response);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }

  @override
  AsyncResult<ResponseMessage> logout() async {
    try {
      final response = await datasource.logout();
      return Right(response);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }
}
