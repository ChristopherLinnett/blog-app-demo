import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/core/typedefs/usecases.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/domain/repos/posts_repo.dart';

class EditPost extends UsecaseWithParams<CompletedPost, EditPostParams> {
  final PostsRepo _repo;
  EditPost(this._repo);
  @override
  AsyncResult<CompletedPost> call(params) {
    return _repo.updatePost(params.postId, params.updateDetails);
  }
}

class EditPostParams {
  final String postId;
  final Map<String, dynamic> updateDetails;

  EditPostParams({required this.postId, required this.updateDetails});
}
