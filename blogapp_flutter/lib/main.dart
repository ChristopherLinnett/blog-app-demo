import 'package:blogapp_flutter/core/app/app_router.dart';
import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  CachedQuery.instance.configFlutter(config: QueryConfigFlutter());
  runApp(const ProviderScope(
    child: AppNavigator(),
  ));
}
