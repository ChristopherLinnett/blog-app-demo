import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:blogapp_flutter/core/typedefs/query_ids.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_comment.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/add_comment.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';

Mutation<CompletedComment, AddCommentParams> addCommentMutation(
        String postId) =>
    Mutation<CompletedComment, AddCommentParams>(
      key: QueryIds.addComment.name + postId,
      queryFn: (params) => _queryFn(params),
      refetchQueries: [
        '${QueryIds.getComments.name}$postId',
      ],
      onStartMutation: (post) => CachedQuery.instance.updateQuery(
          key: '${QueryIds.getComments.name}$postId',
          updateFn: (old) => _optimisticUpdateFn(old, post)),
      onError: (arg, error, fallback) => fallback,
    );

List<CompletedComment> _optimisticUpdateFn(
    List<CompletedComment>? old, AddCommentParams newCommentParams) {
  final newComment = CompletedComment(
      postId: newCommentParams.postId,
      id: 'temp_${DateTime.now().toIso8601String()}',
      content: newCommentParams.comment,
      author: newCommentParams.author);
  if (old == null) {
    return [newComment];
  }
  old.add(newComment);
  return old;
}

Future<CompletedComment> _queryFn(AddCommentParams params) async {
  final AddComment addComment = services();
  final result = await addComment(params);
  return result.fold(
    (failure) => throw failure,
    (successResult) => successResult,
  );
}
