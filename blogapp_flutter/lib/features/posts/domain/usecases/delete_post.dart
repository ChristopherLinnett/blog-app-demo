import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/core/typedefs/usecases.dart';
import 'package:blogapp_flutter/features/authentication/data/models/response_message.dart';
import 'package:blogapp_flutter/features/posts/domain/repos/posts_repo.dart';

class DeletePost extends UsecaseWithParams<ResponseMessage, String> {
  final PostsRepo _repo;
  DeletePost(this._repo);
  @override
  AsyncResult<ResponseMessage> call(params) {
    return _repo.deletePost(params);
  }
}
