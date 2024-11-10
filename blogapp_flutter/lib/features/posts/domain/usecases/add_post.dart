import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/core/typedefs/usecases.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/data/models/post_template.dart';
import 'package:blogapp_flutter/features/posts/domain/repos/posts_repo.dart';

class AddPost extends UsecaseWithParams<CompletedPost, PostTemplate> {
  final PostsRepo _repo;
  AddPost(this._repo);
  @override
  AsyncResult<CompletedPost> call(params) {
    return _repo.addPost(params);
  }
}
