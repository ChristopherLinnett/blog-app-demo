import 'package:blogapp_flutter/features/authentication/presentation/state/providers/auth_state_provider.dart';
import 'package:blogapp_flutter/features/posts/data/models/post_template.dart';
import 'package:blogapp_flutter/features/posts/queries/add_post_mutation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPostModal extends StatefulWidget {
  const AddPostModal({
    super.key,
  });

  @override
  AddPostModalState createState() => AddPostModalState();
}

class AddPostModalState extends State<AddPostModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _hide() {
    Navigator.of(context).pop();
  }

  Future<void> _handleAddPost(String author) async {
    addPostMutation().mutate(PostTemplate(
        title: _titleController.text,
        content: _contentController.text,
        author: author));
    _titleController.clear();
    _contentController.clear();
    _hide();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hide,
      child: GestureDetector(
        onTap: () {},
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.only(
              bottom: 16 + MediaQuery.viewInsetsOf(context).bottom,
              left: 16,
              right: 16,
              top: 32,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Create New Post',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autofocus: true,
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                        hintText: 'Content',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.grey[400]),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                    minLines: 1,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        onPressed: _hide,
                        child: Text(
                          'Cancel',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.red,
                                  ),
                        ),
                      ),
                      Consumer(builder: (context, ref, child) {
                        return CupertinoButton(
                          onPressed: () =>
                              _handleAddPost(ref.read(authStateProvider).email),
                          child: const Text('Submit'),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
