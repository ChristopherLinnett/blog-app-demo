import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/features/authentication/data/models/response_message.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_comment.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/data/models/post_template.dart';

abstract class PostsRepo {
  AsyncResult<List<CompletedPost>> getPosts();

  AsyncResult<CompletedPost> addPost(PostTemplate post);

  AsyncResult<ResponseMessage> deletePost(String postId);

  AsyncResult<CompletedPost> updatePost(
    String postId,
    Map<String, dynamic> updateDetails,
  );

  AsyncResult<CompletedComment> addComment(
    String postId,
    String comment,
    String author,
  );

  AsyncResult<List<CompletedComment>> getCommentsByPostId(String postId);
}
