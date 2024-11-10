import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:blogapp_flutter/core/typedefs/query_ids.dart';
import 'package:blogapp_flutter/features/authentication/data/models/response_message.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/delete_post.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';

Mutation<ResponseMessage, String> deletePostMutation(String postId) =>
    Mutation<ResponseMessage, String>(
      key: QueryIds.deletePost.name,
      queryFn: (postId) => _queryFn(postId),
      refetchQueries: [QueryIds.getPosts.name],
      onStartMutation: (post) => CachedQuery.instance.updateQuery(
          key: QueryIds.getPosts.name,
          updateFn: (old) => _optimisticUpdateFn(old, postId)),
    );

List<CompletedPost> _optimisticUpdateFn(
    List<CompletedPost> old, String deleteId) {
  final newList = [...old];
  newList.removeWhere((oldPost) => oldPost.id == deleteId);
  return newList;
}

Future<ResponseMessage> _queryFn(String postId) async {
  final DeletePost deletePost = services();
  final result = await deletePost(postId);
  return result.fold(
      (failure) => throw failure, (successResult) => successResult);
}
