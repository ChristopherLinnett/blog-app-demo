import 'package:blogapp_flutter/features/authentication/data/datasources/auth_datasource_implementation.dart';
import 'package:blogapp_flutter/features/authentication/data/domain/auth_repo_implementation.dart';
import 'package:blogapp_flutter/features/authentication/domain/repos/auth_repo.dart';
import 'package:blogapp_flutter/features/authentication/domain/usecases/login.dart';
import 'package:blogapp_flutter/features/authentication/domain/usecases/logout.dart';
import 'package:blogapp_flutter/features/authentication/domain/usecases/sign_up.dart';
import 'package:blogapp_flutter/features/posts/data/datasources/posts_datasource_implementation.dart';
import 'package:blogapp_flutter/features/posts/data/domain/posts_repo_implementation.dart';
import 'package:blogapp_flutter/features/posts/domain/repos/posts_repo.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/add_comment.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/add_post.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/delete_post.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/edit_post.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/get_comments.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/get_posts.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final services = GetIt.instance;

/// Sets up dependency injection for the application using GetIt service locator.
///
/// This function initializes all necessary dependencies including:
/// - HTTP client (Dio) with auth token interceptor
/// - Secure storage for authentication tokens
/// - Authentication related dependencies (Repository and Use Cases)
/// - Posts related dependencies (Repository and Use Cases)
///
/// The Dio client is configured with two interceptors:
/// 1. Request interceptor: Adds authentication token to request headers if available
/// 2. Response interceptor: Handles authentication token storage from responses
///
/// Authentication dependencies include:
/// - AuthRepo
/// - Login use case
/// - Logout use case
/// - SignUp use case
///
/// Posts dependencies include:
/// - PostsRepo
/// - AddComment use case
/// - AddPost use case
/// - DeletePost use case
/// - EditPost use case
/// - GetComments use case
/// - GetPosts use case
void setupDependencies() {
  final Dio dio = Dio();

  const storage = FlutterSecureStorage();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final hasKey = await storage.containsKey(key: 'authToken');
      if (!hasKey) return handler.next(options);

      final idToken = await storage.read(key: 'authToken');
      if (idToken != null) {
        options.headers['Authorization'] = 'Bearer $idToken';
      }
      return handler.next(options);
    },
  ));
  dio.interceptors.add(InterceptorsWrapper(
    onResponse: (response, handler) async {
      if (response.data is! Map<String, dynamic>) return handler.next(response);
      if (!(response.data as Map<String, dynamic>).containsKey("token")) {
        return handler.next(response);
      }
      final authResponse = response.data as Map<String, dynamic>;
      final token = authResponse['token']?['value'];
      if (token == null) return handler.next(response);
      if (token == null) return handler.next(response);
      const storage = FlutterSecureStorage();
      await storage.write(key: 'authToken', value: token);
      return handler.next(response);
    },
  ));

  // Authentication
  services
    ..registerLazySingleton<AuthRepo>(() =>
        AuthRepoImplementation(AuthDatasourceImplementation(httpClient: dio)))
    ..registerLazySingleton(() => Login(services()))
    ..registerLazySingleton(() => Logout(services()))
    ..registerLazySingleton(() => SignUp(services()));

  // Posts
  services
    ..registerLazySingleton<PostsRepo>(() =>
        PostsRepoImplementation(PostsDatasourceImplementation(httpClient: dio)))
    ..registerLazySingleton(() => AddComment(services()))
    ..registerLazySingleton(() => AddPost(services()))
    ..registerLazySingleton(() => DeletePost(services()))
    ..registerLazySingleton(() => EditPost(services()))
    ..registerLazySingleton(() => GetComments(services()))
    ..registerLazySingleton(() => GetPosts(services()));
}
