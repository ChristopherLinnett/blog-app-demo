import 'package:blogapp_flutter/core/errors/handle_exception.dart';
import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/features/authentication/data/models/response_message.dart';
import 'package:blogapp_flutter/features/posts/data/datasources/posts_datasource.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_comment.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

import '../models/post_template.dart';

/// A repository implementation for managing posts and comments.
///
/// This class implements the [PostsRepo] interface and provides concrete implementations
/// for post and comment related operations using a [PostsDatasource].
///
/// The implementation handles all operations by:
/// 1. Attempting to execute the operation through the datasource
/// 2. Wrapping successful results in a [Right]
/// 3. Catching exceptions and wrapping them in a [Left] after processing through [handleException]
///
/// Methods:
/// - [getPosts]: Retrieves all posts
/// - [addPost]: Creates a new post
/// - [deletePost]: Removes a post by ID
/// - [updatePost]: Modifies an existing post
/// - [addComment]: Adds a comment to a post
/// - [getCommentsByPostId]: Retrieves all comments for a specific post
class PostsRepoImplementation implements PostsRepo {
  final PostsDatasource datasource;

  PostsRepoImplementation(this.datasource);

  @override
  AsyncResult<List<CompletedPost>> getPosts() async {
    try {
      final result = await datasource.getPosts();
      return Right(result);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }

  @override
  AsyncResult<CompletedPost> addPost(PostTemplate post) async {
    try {
      final result = await datasource.addPost(post);
      return Right(result);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }

  @override
  AsyncResult<ResponseMessage> deletePost(String postId) async {
    try {
      final result = await datasource.deletePost(postId);
      return Right(result);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }

  @override
  AsyncResult<CompletedPost> updatePost(
    String postId,
    Map<String, dynamic> updateDetails,
  ) async {
    try {
      final result = await datasource.editPost(postId, updateDetails);
      return Right(result);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }

  @override
  AsyncResult<CompletedComment> addComment(
    String postId,
    String comment,
    String author,
  ) async {
    try {
      final result = await datasource.addComment(
          postId: postId, comment: comment, author: author);
      return Right(result);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }

  @override
  AsyncResult<List<CompletedComment>> getCommentsByPostId(String postId) async {
    try {
      final result = await datasource.getCommentsByPostId(postId);
      return Right(result);
    } catch (exception) {
      return Left(handleException(exception));
    }
  }
}
