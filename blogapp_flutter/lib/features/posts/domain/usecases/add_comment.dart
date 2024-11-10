import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/core/typedefs/usecases.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_comment.dart';
import 'package:blogapp_flutter/features/posts/domain/repos/posts_repo.dart';

class AddComment extends UsecaseWithParams<CompletedComment, AddCommentParams> {
  final PostsRepo _repo;
  AddComment(this._repo);
  @override
  AsyncResult<CompletedComment> call(params) {
    return _repo.addComment(params.postId, params.comment, params.author);
  }
}

class AddCommentParams {
  final String postId;
  final String comment;
  final String author;
  AddCommentParams(
      {required this.postId, required this.comment, required this.author});
}
