import 'package:blogapp_flutter/features/authentication/presentation/state/providers/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAuthenticatedProvider =
    Provider((ref) => ref.watch(authStateProvider).signedIn);
