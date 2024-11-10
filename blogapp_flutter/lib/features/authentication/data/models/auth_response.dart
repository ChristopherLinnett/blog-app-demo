import 'package:blogapp_flutter/core/errors/exceptions.dart';
import 'package:blogapp_flutter/features/authentication/data/models/token.dart';
import 'package:blogapp_flutter/features/authentication/typedefs/user.dart';

class AuthResponse {
  final User user;
  final Token token;

  AuthResponse({
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    try {
      return AuthResponse(
        user: User.fromJson(json['user']),
        token: Token.fromJson(json['token']),
      );
    } catch (exception) {
      if (exception is DataFormatException) {
        rethrow;
      }
      throw DataFormatException("Unable to parse AuthResponse from JSON");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token.toJson(),
    };
  }
}
