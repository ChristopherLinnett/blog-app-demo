import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:blogapp_flutter/core/typedefs/query_ids.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_comment.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/get_comments.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';

Query<List<CompletedComment>> getCommentsQuery(String postId) =>
    Query<List<CompletedComment>>(
        key: '${QueryIds.getComments.name}$postId',
        queryFn: () => queryFn(postId));

Future<List<CompletedComment>> queryFn(String postId) async {
  final GetComments getComments = services();
  final result = await getComments(postId);
  return result.fold(
    (failure) => throw failure,
    (successResult) => successResult,
  );
}
