
import 'package:blogapp_flutter/features/posts/data/models/comment_template.dart';
/// A complete comment model that extends [CommentTemplate].
///
/// This class represents a fully formed comment with a unique identifier.
/// It includes all the base properties from [CommentTemplate] (content, author, postId)
/// plus an additional [id] field.
///
/// The class provides methods to convert to and from JSON format:
/// * [toJson] converts the comment instance to a Map
/// * [fromJson] creates a new instance from a JSON Map
///
/// Example:
/// ```dart
/// final comment = CompletedComment(
///   id: '123',
///   content: 'Great post!',
///   author: 'John Doe',
///   postId: 'post456'
/// );
/// ```
class CompletedComment extends CommentTemplate {
  final String id;

  CompletedComment(
      {required this.id,
      required super.content,
      required super.author,
      required super.postId});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author': author,
      'postId': postId,
    };
  }

  factory CompletedComment.fromJson(Map<String, dynamic> json) {
    return CompletedComment(
      id: json['id'],
      content: json['content'],
      author: json['author'],
      postId: json['postId'],
    );
  }
}
