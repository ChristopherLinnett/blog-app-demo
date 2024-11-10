import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/core/typedefs/usecases.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/domain/repos/posts_repo.dart';

class GetPosts extends UsecaseWithoutParams<List<CompletedPost>> {
  final PostsRepo _repo;
  GetPosts(this._repo);
  @override
  AsyncResult<List<CompletedPost>> call() {
    return _repo.getPosts();
  }
}
