import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:blogapp_flutter/core/typedefs/query_ids.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/data/models/post_template.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/add_post.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';

Mutation<CompletedPost, PostTemplate> addPostMutation() =>
    Mutation<CompletedPost, PostTemplate>(
      key: QueryIds.addPost.name,
      queryFn: _queryFn,
      refetchQueries: [QueryIds.getPosts.name],
      onStartMutation: (post) => CachedQuery.instance.updateQuery(
          key: QueryIds.getPosts.name,
          updateFn: (old) => _optimisticUpdateFn(old, post)),
    );

List<CompletedPost> _optimisticUpdateFn(
    List<CompletedPost>? old, PostTemplate newItem) {
  final newPost = CompletedPost(
      id: 'temp + ${DateTime.now().toIso8601String()}',
      comments: [],
      title: newItem.title,
      content: newItem.content,
      author: newItem.author);
  if (old == null) {
    return [newPost];
  }
  final newList = [...old];
  newList.add(newPost);
  return newList;
}

Future<CompletedPost> _queryFn(PostTemplate post) async {
  final AddPost addPost = services();
  final result = await addPost(post);
  return result.fold(
      (failure) => throw failure, (successResult) => successResult);
}
