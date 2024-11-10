import 'package:blogapp_flutter/features/authentication/presentation/state/auth_state.dart';
import 'package:blogapp_flutter/features/authentication/presentation/state/auth_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());
