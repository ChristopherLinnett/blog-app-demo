import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:blogapp_flutter/core/typedefs/query_ids.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/get_posts.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';

Query<List<CompletedPost>> getPostsQuery() =>
    Query<List<CompletedPost>>(key: QueryIds.getPosts.name, queryFn: queryFn);

Future<List<CompletedPost>> queryFn() async {
  final GetPosts getPosts = services();
  final result = await getPosts();
  return result.fold(
    (failure) => throw failure,
    (successResult) => successResult,
  );
}
