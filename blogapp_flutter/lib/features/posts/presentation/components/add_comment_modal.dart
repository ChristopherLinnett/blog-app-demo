import 'package:blogapp_flutter/features/authentication/presentation/state/providers/auth_state_provider.dart';
import 'package:blogapp_flutter/features/posts/domain/usecases/add_comment.dart';
import 'package:blogapp_flutter/features/posts/queries/add_comment_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCommentModal extends StatefulWidget {
  final String postId;

  const AddCommentModal({
    super.key,
    required this.postId,
  });

  @override
  State<AddCommentModal> createState() => _AddCommentModalState();
}

class _AddCommentModalState extends State<AddCommentModal> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _handleSubmit(String author) {
    if (_commentController.text.isNotEmpty) {
      addCommentMutation(widget.postId).mutate(AddCommentParams(
          postId: widget.postId,
          comment: _commentController.text,
          author: author));
      _commentController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.only(
          bottom: 32 + MediaQuery.viewInsetsOf(context).bottom,
          left: 16,
          right: 16,
          top: 32,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add new Comment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              autofocus: true,
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Comment',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 8),
                Consumer(builder: (context, ref, child) {
                  return CupertinoButton(
                    onPressed: () =>
                        _handleSubmit(ref.read(authStateProvider).email),
                    child: const Text('Submit'),
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
