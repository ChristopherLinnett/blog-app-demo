import 'package:blogapp_flutter/core/typedefs/usecases.dart';

import '../../../../core/typedefs/async_result.dart';
import '../../data/models/auth_response.dart';
import '../repos/auth_repo.dart';

class Login extends UsecaseWithParams<AuthResponse, LoginParams> {
  final AuthRepo _repo;

  Login(this._repo);
  @override
  AsyncResult<AuthResponse> call(LoginParams params) {
    return _repo.login(username: params.username, password: params.password);
  }
}

class LoginParams {
  final String username;
  final String password;
  LoginParams(this.username, this.password);
}
