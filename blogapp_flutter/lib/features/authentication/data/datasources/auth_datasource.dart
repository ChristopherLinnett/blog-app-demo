import '../models/auth_response.dart';
import '../models/response_message.dart';

abstract class AuthDatasource {
  Future<AuthResponse> login(String username, String password);
  Future<ResponseMessage> logout();
  Future<AuthResponse> signUp(String username, String password);
}
