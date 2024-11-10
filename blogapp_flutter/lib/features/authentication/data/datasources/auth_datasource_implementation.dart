import 'dart:io' show Platform;

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';
import '../models/response_message.dart';
import './auth_datasource.dart';

class AuthDatasourceImplementation implements AuthDatasource {
  final Dio httpClient;
  late final String url;

  AuthDatasourceImplementation({required this.httpClient}) {
    final address = Platform.isIOS ? 'localhost' : '10.0.2.2';
    url = 'http://$address:3001/api/auth';
  }

  @override
  Future<AuthResponse> login(String username, String password) async {
    final endpoint = '$url/login';
    final body = AuthRequest(username: username, password: password);

    try {
      final response = await httpClient.post<Map<String, dynamic>>(
        endpoint,
        data: body.toJson(),
      );
      return AuthResponse.fromJson(response.data!);
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionError) {
        throw ServerException('Could not connect to the server', 503);
      }
      throw AuthException(
        exception.response?.data['message'] as String? ??
            'Authentication failed',
        exception.response?.statusCode ?? 400,
      );
    } catch (exception) {
      throw UnknownException('An Unknown Exception has occurred', 500);
    }
  }

  @override
  Future<AuthResponse> signUp(String username, String password) async {
    final endpoint = '$url/signUp';
    final body = AuthRequest(username: username, password: password);

    try {
      final response = await httpClient.post<Map<String, dynamic>>(
        endpoint,
        data: body.toJson(),
      );
      final responseFromJson = AuthResponse.fromJson(response.data!);
      
      return responseFromJson;
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionError) {
        throw ServerException('Could not connect to the server', 503);
      }
      throw AuthException(
        exception.response?.data['message'] as String? ??
            'Authentication failed',
        exception.response?.statusCode ?? 400,
      );
    } catch (exception) {
      throw UnknownException('An Unknown Exception has occurred', 500);
    }
  }

  @override
  Future<ResponseMessage> logout() async {
    return ResponseMessage(message: 'success');
  }
}
