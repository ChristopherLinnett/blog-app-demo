import 'package:blogapp_flutter/features/authentication/presentation/state/providers/auth_state_provider.dart';
import 'package:blogapp_flutter/features/posts/data/models/completed_post.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/edit_post.dart';
import 'package:blogapp_flutter/features/posts/queries/delete_post_mutation.dart';
import 'package:blogapp_flutter/features/posts/queries/edit_post_mutation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostTile extends StatefulWidget {
  final CompletedPost post;

  const PostTile({super.key, required this.post});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  bool editing = false;
  late TextEditingController _contentController;
  late TextEditingController _titleController;

  void toggleEditing() {
    setState(() {
      editing = !editing;
    });
  }

  void navigateToDetails(BuildContext context, String postId) {
    context.push('/postDetails/$postId');
  }

  void handleEditAction(BuildContext context) {
    if (!editing) {
      return setState(() {
        editing = true;
      });
    }
    editPostMutation(widget.post.id).mutate(EditPostParams(
        postId: widget.post.id,
        updateDetails: {
          "title": _titleController.text,
          "content": _contentController.text
        }));

    setState(() {
      editing = !editing;
    });
  }

  void handleDeletePost(BuildContext context) {
    deletePostMutation(widget.post.id).mutate(widget.post.id);
  }

  void cancelEdit() {
    setState(() {
      editing = false;
    });
  }

  @override
  void initState() {
    _contentController = TextEditingController(text: widget.post.content);
    _titleController = TextEditingController(text: widget.post.title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: editing || !widget.post.ready
          ? null
          : () => navigateToDetails(context, widget.post.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 15),
        constraints: const BoxConstraints(minHeight: 80, maxHeight: 120),
        decoration: BoxDecoration(
          color: widget.post.ready ? Colors.white : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Hero(
                flightShuttleBuilder: (
                  BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,
                ) {
                  return SingleChildScrollView(
                    child: fromHeroContext.widget,
                  );
                },
                tag: widget.post.id,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    editing
                        ? CupertinoTextField.borderless(
                            autofocus: true,
                            padding: EdgeInsets.zero,
                            placeholder: widget.post.content,
                            controller: _titleController,
                            decoration:
                                const BoxDecoration(), // Remove focus border
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.grey),
                          )
                        : Text(
                            widget.post.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color:
                                        widget.post.ready ? null : Colors.grey),
                          ),
                    Text(
                      'By: ${widget.post.author}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: widget.post.ready ? null : Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    editing
                        ? CupertinoTextField.borderless(
                            autofocus: true,
                            padding: EdgeInsets.zero,
                            placeholder: widget.post.content,
                            controller: _contentController,
                            decoration:
                                const BoxDecoration(), // Remove focus border
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey),
                          )
                        : Text(
                            widget.post.content,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color:
                                        widget.post.ready ? null : Colors.grey),
                          ),
                  ],
                ),
              ),
            ),
            Consumer(builder: (context, ref, child) {
              final user = ref.watch(authStateProvider);
              final author = user.email;
              final isAdmin = user.isAdmin;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.post.author == author && widget.post.ready)
                    CupertinoButton(
                      minSize: 0,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      onPressed: () => handleEditAction(context),
                      child: Text(
                        editing ? 'Save' : 'Edit',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  if ((widget.post.author == author || isAdmin) &&
                      !editing &&
                      widget.post.ready)
                    CupertinoButton(
                      minSize: 0,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      onPressed: () => handleDeletePost(context),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  if (editing && widget.post.ready)
                    CupertinoButton(
                      minSize: 0,
                      padding: EdgeInsets.zero,
                      onPressed: () => cancelEdit(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
