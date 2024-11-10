import 'package:blogapp_flutter/features/posts/presentation/components/add_comment_modal.dart';
import 'package:blogapp_flutter/features/posts/presentation/components/comment_tile.dart';
import 'package:blogapp_flutter/features/posts/presentation/components/loading_failure_view.dart';
import 'package:blogapp_flutter/features/posts/queries/get_comments_query.dart';
import 'package:blogapp_flutter/features/posts/queries/get_posts_query.dart';
import 'package:blogapp_flutter/widgets/adaptive_appbar.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final String postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdaptiveAppbar(
        header: 'Post',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QueryBuilder(
                query: getPostsQuery(),
                builder: (context, query) {
                  if (query.data != null) {
                    final post =
                        query.data!.firstWhere((post) => post.id == postId);
                    return Hero(
                        tag: postId,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.title,
                                  textAlign: TextAlign.left,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Text(
                                'By: ${post.author}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 5),
                              Text(post.content,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ));
                  }
                  if (query.status == QueryStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return LoadingFailureView(
                      onRetry: () => getPostsQuery().refetch(),
                      dataType: "Post");
                }),
            Expanded(
              child: QueryBuilder(
                  query: getCommentsQuery(postId),
                  builder: (context, query) {
                    if (query.data != null) {
                      return ListView.builder(
                        itemCount: query.data!.length,
                        itemBuilder: (context, index) {
                          final comment = query.data![index];
                          return CommentTile(
                            author: comment.author,
                            content: comment.content,
                          );
                        },
                      );
                    }
                    if (query.status == QueryStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return LoadingFailureView(
                          onRetry: () => getCommentsQuery(postId).refetch(),
                          dataType: "Comments");
                    }
                  }),
            ),
            const SizedBox(height: 16),
            CupertinoButton(
              color: const Color(0xFF4CAF50),
              onPressed: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => AddCommentModal(
                        postId: postId,
                      )),
              child: Text(
                'Add Comment',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
