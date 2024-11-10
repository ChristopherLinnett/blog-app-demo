import 'dart:io';

import 'package:blogapp_flutter/core/errors/exceptions.dart';
import 'package:blogapp_flutter/features/authentication/data/models/response_message.dart';
import 'package:blogapp_flutter/features/posts/data/datasources/posts_datasource.dart';
import 'package:dio/dio.dart';

import '../models/completed_comment.dart';
import '../models/completed_post.dart';
import '../models/post_template.dart';

/// Implementation of [PostsDatasource] interface that provides concrete methods
/// for accessing and manipulating post data from a data source.
///
/// This class is responsible for handling all direct data operations related to posts,
/// such as fetching, creating, updating, and deleting posts from the underlying
/// data storage system.
class PostsDatasourceImplementation implements PostsDatasource {
  final Dio httpClient;
  final String url;

  PostsDatasourceImplementation({required this.httpClient})
      : url = _getBaseUrl();

  static String _getBaseUrl() {
    return 'http://${Platform.isIOS ? 'localhost' : '10.0.2.2'}:3001/api';
  }

  @override
  /// Retrieves a list of completed posts from the data source.
  /// 
  /// This method asynchronously fetches all available completed posts.
  /// 
  /// Returns a [Future] that completes with a [List] of [CompletedPost] objects.
  /// If the operation fails, it may throw an exception.
  Future<List<CompletedPost>> getPosts() async {
    final endpoint = '$url/posts';

    try {
      final response = await httpClient.get(endpoint);
      return (response.data as List)
          .map((post) => CompletedPost.fromJson(post))
          .toList();
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ?? 'Authentication Error',
        e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw UnknownException(
        'An Unknown Exception has occurred',
        500,
      );
    }
  }

  @override
  /// Adds a new post to the data source
  /// 
  /// Takes a [PostTemplate] object containing the post details and returns a [Future]
  /// that completes with a [CompletedPost] once the post is successfully added.
  /// 
  /// The [post] parameter contains the template data for creating a new post.
  /// 
  /// Returns a [CompletedPost] object containing the complete post data including
  /// server-generated fields.
  ///
  Future<CompletedPost> addPost(PostTemplate post) async {
    final endpoint = '$url/posts';

    try {
      final response = await httpClient.post(endpoint, data: post.toJson());
      return CompletedPost.fromJson(response.data);
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ?? 'Authentication Error',
        e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw UnknownException(
        'An Unknown Exception has occurred',
        500,
      );
    }
  }

  @override
  /// Deletes a post from the data source using the provided post ID.
  /// 
  /// Parameters:
  ///   - postId: A unique identifier string for the post to be deleted.
  /// 
  /// Returns a Future<ResponseMessage> which contains the status of the deletion operation.
  Future<ResponseMessage> deletePost(String postId) async {
    final endpoint = '$url/posts/$postId';

    try {
      final response = await httpClient.delete(endpoint);
      return ResponseMessage.fromJson(response.data);
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ?? 'Authentication Error',
        e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw UnknownException(
        'An Unknown Exception has occurred',
        500,
      );
    }
  }
  /// Updates an existing post with the provided details
  /// 
  /// Takes a [postId] to identify the post to be updated and [updateDetails] containing the fields to be modified
  /// 
  /// Returns a [CompletedPost] object containing the updated post data
  /// 
  /// Throws [AuthException] if there are authentication/authorization issues
  /// Throws [UnknownException] for any other unexpected errors

  @override
  Future<CompletedPost> editPost(
    String postId,
    Map<String, dynamic> updateDetails,
  ) async {
    final endpoint = '$url/posts/$postId';

    try {
      final response = await httpClient.put(
        endpoint,
        data: {'postId': postId, ...updateDetails},
      );
      return CompletedPost.fromJson(response.data);
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ?? 'Authentication Error',
        e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw UnknownException(
        'An Unknown Exception has occurred',
        500,
      );
    }
  }

  @override
  /// Adds a new comment to a specific post.
  ///
  /// Parameters:
  /// - [postId]: The unique identifier of the post to comment on.
  /// - [comment]: The content of the comment to be added.
  /// - [author]: The name or identifier of the comment author.
  ///
  /// Returns a [CompletedComment] object containing the created comment details.
  ///
  /// Throws:
  /// - [AuthException]: If there's an authentication error during the request.
  /// - [UnknownException]: If an unexpected error occurs during the process.
  Future<CompletedComment> addComment(
      {required String postId,
      required String comment,
      required String author}) async {
    final endpoint = '$url/comments/$postId';
    try {
      final response = await httpClient.post(
        endpoint,
        data: {'content': comment, 'author': author},
      );
      return CompletedComment.fromJson(response.data);
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ?? 'Authentication Error',
        e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw UnknownException(
        'An Unknown Exception has occurred',
        500,
      );
    }
  }

  @override
  /// Fetches a list of comments for a specific post from the remote data source.
  /// 
  /// [postId] The unique identifier of the post for which comments are being retrieved.
  /// 
  /// Returns a [Future] containing a [List] of [CompletedComment] objects.
  /// 
  /// Throws:
  /// - [AuthException] if there's an authentication error or API request fails
  /// - [UnknownException] for any other unexpected errors during the operation
  Future<List<CompletedComment>> getCommentsByPostId(String postId) async {
    final endpoint = '$url/comments/$postId';

    try {
      final response = await httpClient.get(endpoint);
      return (response.data as List)
          .map((comment) => CompletedComment.fromJson(comment))
          .toList();
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ?? 'Authentication Error',
        e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw UnknownException(
        'An Unknown Exception has occurred',
        500,
      );
    }
  }
}
