import 'package:blogapp_flutter/features/authentication/data/models/auth_response.dart';
import 'package:blogapp_flutter/features/authentication/presentation/state/providers/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authCreateProvider = Provider<void Function(AuthResponse)>((ref) {
  return (ref.read(authStateProvider.notifier).createAuth);
});
