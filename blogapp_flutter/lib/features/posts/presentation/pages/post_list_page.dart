import 'package:blogapp_flutter/core/errors/failures.dart';
import 'package:blogapp_flutter/features/posts/presentation/components/add_post_modal.dart';
import 'package:blogapp_flutter/features/posts/presentation/components/post_tile.dart';
import 'package:blogapp_flutter/features/posts/queries/add_post_mutation.dart';
import 'package:blogapp_flutter/features/posts/queries/get_posts_query.dart';
import 'package:blogapp_flutter/widgets/adaptive_appbar.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdaptiveAppbar(
        header: 'Posts',
        showSignout: true,
      ),
      body: QueryBuilder(
        query: getPostsQuery(),
        builder: (context, query) {
          if (query.data != null) {
            final posts = query.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return PostTile(
                          post: post,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  MutationListener(
                    mutation: addPostMutation(),
                    listener: (state) => setState(() {
                      loading = state.status == QueryStatus.loading;
                    }),
                    child: CupertinoButton(
                      color: const Color(0xFF4CAF50),
                      onPressed: loading
                          ? null
                          : () => showCupertinoModalPopup(
                              context: context,
                              builder: (context) => const AddPostModal()),
                      child: Text(
                        'Add Post',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          }
          if (query.status == QueryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text((query.error as Failure).message),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: getPostsQuery().refetch,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
