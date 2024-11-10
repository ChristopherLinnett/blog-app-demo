import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/core/typedefs/usecases.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_comment.dart';
import 'package:blogapp_flutter/features/posts/domain/repos/posts_repo.dart';

class GetComments extends UsecaseWithParams<List<CompletedComment>, String> {
  final PostsRepo _repo;
  GetComments(this._repo);
  @override
  AsyncResult<List<CompletedComment>> call(params) {
    return _repo.getCommentsByPostId(params);
  }
}
