import 'package:blogapp_flutter/core/typedefs/usecases.dart';

import '../../../../core/typedefs/async_result.dart';
import '../../data/models/auth_response.dart';
import '../repos/auth_repo.dart';

class SignUp extends UsecaseWithParams<AuthResponse, SignUpParams> {
  final AuthRepo _repo;

  SignUp(this._repo);

  @override
  AsyncResult<AuthResponse> call(params) {
    return _repo.signUp(username: params.username, password: params.password);
  }
}

class SignUpParams {
  final String username;
  final String password;
  SignUpParams(this.username, this.password);
}
