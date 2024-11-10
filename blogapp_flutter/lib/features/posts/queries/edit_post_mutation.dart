import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:blogapp_flutter/core/typedefs/query_ids.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/edit_post.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';

Mutation<CompletedPost, EditPostParams> editPostMutation(
        String postId) =>
    Mutation<CompletedPost, EditPostParams>(
      key: QueryIds.updatePost.name + postId,
      queryFn: _queryFn,
      refetchQueries: [QueryIds.getPosts.name],
      onStartMutation: (post) => CachedQuery.instance.updateQuery(
          key: QueryIds.getPosts.name,
          updateFn: (old) => _optimisticUpdateFn(old, post)),
    );

List<CompletedPost> _optimisticUpdateFn(
    List<CompletedPost> old, EditPostParams updateData) {
  final oldPost = old.firstWhere((oldPost) => oldPost.id == updateData.postId);
  updateData.updateDetails;
  final newPost = oldPost.updateFromMap(updateData.updateDetails);
  final newList = [...old];
  final index = newList.indexWhere((oldPost) => oldPost.id == newPost.id);
  newList[index] = newPost;
  return newList;
}

Future<CompletedPost> _queryFn(EditPostParams params) async {
  final EditPost editPost = services();
  final result = await editPost(params);
  return result.fold(
      (failure) => throw failure, (successResult) => successResult);
}
