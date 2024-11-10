import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:blogapp_flutter/features/authentication/domain/usecases/logout.dart';
import 'package:blogapp_flutter/features/authentication/presentation/state/providers/auth_state_provider.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdaptiveAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String header;
  final bool showSignout;

  const AdaptiveAppbar(
      {super.key, required this.header, this.showSignout = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      leadingWidth: 100,
      leading: context.canPop()
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: context.pop,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.back,
                      color: CupertinoColors.activeBlue, size: 32),
                  Text('Back',
                      style: TextStyle(
                          color: CupertinoColors.activeBlue, fontSize: 20)),
                ],
              ),
            )
          : null,
      shadowColor: Colors.transparent,
      title: Text(header, style: const TextStyle(color: Colors.black)),
      actions: showSignout
          ? [
              Consumer(builder: (context, ref, child) {
                return CupertinoButton(
                  child: const Text('Sign Out',
                      style: TextStyle(
                          color: CupertinoColors.activeBlue, fontSize: 20)),
                  onPressed: () {
                    final Logout signOut = services();
                    CachedQuery.instance.deleteCache();
                    signOut();
                    ref.read(authStateProvider.notifier).clearUser();
                  },
                );
              })
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
