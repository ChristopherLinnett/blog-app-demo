import '../../../../core/typedefs/async_result.dart';
import '../../data/models/auth_response.dart';
import '../../data/models/response_message.dart';

abstract class AuthRepo {
  AsyncResult<AuthResponse> login({
    required String username,
    required String password,
  });

  AsyncResult<ResponseMessage> logout();

  AsyncResult<AuthResponse> signUp({
    required String username,
    required String password,
  });
}