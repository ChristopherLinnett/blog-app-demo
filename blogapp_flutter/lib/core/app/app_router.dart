import 'package:blogapp_flutter/features/authentication/presentation/pages/auth_page.dart';
import 'package:blogapp_flutter/features/authentication/presentation/state/providers/is_authenticated_provider.dart';
import 'package:blogapp_flutter/features/posts/presentation/pages/post_detail_page.dart';
import 'package:blogapp_flutter/features/posts/presentation/pages/post_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppNavigator extends ConsumerWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signedIn = ref.watch(isAuthenticatedProvider);

    return MaterialApp.router(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      routerConfig: GoRouter(
        routes: signedIn ? authenticatedScreens : unauthenticatedScreens,
      ),
    );
  }

  List<GoRoute> get authenticatedScreens => [
        GoRoute(
          path: '/',
          builder: (context, state) => const PostListPage(),
        ),
        GoRoute(
          path: '/postDetails/:postId',
          builder: (context, state) {
            final postId = state.pathParameters['postId']!;
            return PostDetailPage(postId: postId);
          },
        ),
      ];

  List<GoRoute> get unauthenticatedScreens => [
        GoRoute(
          path: '/',
          builder: (context, state) => const AuthPage(),
        ),
      ];
}
