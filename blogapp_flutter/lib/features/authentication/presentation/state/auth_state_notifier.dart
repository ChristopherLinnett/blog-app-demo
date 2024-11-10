import 'package:blogapp_flutter/features/authentication/data/models/auth_response.dart';
import 'package:blogapp_flutter/features/authentication/presentation/state/auth_state.dart';
import 'package:blogapp_flutter/features/authentication/typedefs/token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(AuthState.initial());

  void createAuth(AuthResponse authResponse) {
    state = AuthState(
        user: authResponse.user,
        token: Token(
            value: authResponse.token.value,
            expires: authResponse.token.expires));
  }

  void clearUser() {
    state = AuthState.initial();
  }

  void refreshToken() {
    if (state.token != null) {
      state = state.copyWith(
        token: state.token!.copyWith(
          expires: DateTime.now().millisecondsSinceEpoch + 10 * 60 * 1000,
        ),
      );
    }
  }
}
