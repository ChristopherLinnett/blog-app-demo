import 'package:blogapp_flutter/features/authentication/data/models/response_message.dart';

import '../models/completed_comment.dart';
import '../models/completed_post.dart';
import '../models/post_template.dart';

/// An abstract class that defines the contract for interacting with post-related data.
///
/// This datasource interface provides methods to perform CRUD operations on posts
/// and their associated comments.
///
/// Methods:
/// - [getPosts]: Retrieves all posts
/// - [addPost]: Creates a new post
/// - [deletePost]: Removes an existing post
/// - [editPost]: Updates an existing post
/// - [addComment]: Adds a comment to a specific post
/// - [getCommentsByPostId]: Retrieves all comments for a specific post
///
/// Implementations of this class should handle the actual data persistence
/// and retrieval logic, whether it's through an API, local database, or other means.
abstract class PostsDatasource {
  Future<List<CompletedPost>> getPosts();

  Future<CompletedPost> addPost(PostTemplate post);

  Future<ResponseMessage> deletePost(String postId);

  Future<CompletedPost> editPost(
      String postId, Map<String, dynamic> updateDetails);

  Future<CompletedComment> addComment({
    required String postId,
    required String comment,
    required String author,
  });

  Future<List<CompletedComment>> getCommentsByPostId(String postId);
}
