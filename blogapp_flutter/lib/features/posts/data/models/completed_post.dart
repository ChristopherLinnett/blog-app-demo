import 'package:blogapp_flutter/features/posts/data/models/completed_comment.dart';
import 'package:blogapp_flutter/features/posts/data/models/post_template.dart';

/// A completed post model that extends [PostTemplate].
///
/// This class represents a fully formed post with a unique identifier and comments.
/// It includes functionality to create, update, and convert post data.
///
/// Properties:
/// * [id] - Unique identifier for the post
/// * [comments] - List of [CompletedComment] associated with this post
/// * [title] - Inherited from [PostTemplate], the title of the post
/// * [content] - Inherited from [PostTemplate], the main content of the post
/// * [author] - Inherited from [PostTemplate], the author of the post
///
/// The [ready] getter indicates if the post is fully formed (not temporary)
/// based on the [id] property not containing 'temp'.
///
/// Methods:
/// * [updateFromMap] - Updates the post with new data from a map
/// * [copyWith] - Creates a new instance with optional updated properties
/// * [fromJson] - Factory constructor to create instance from JSON
/// * [toJson] - Converts the post to a JSON-compatible map

class CompletedPost extends PostTemplate {
  final String id;
  final List<CompletedComment> comments;

  CompletedPost({
    required this.id,
    required this.comments,
    required super.title,
    required super.content,
    required super.author,
  });

  bool get ready => !id.contains('temp');

  CompletedPost updateFromMap(Map<String, dynamic> map) {
    final newValue = copyWith(
      id: map['id'] as String?,
      comments: map['comments'] != null
          ? (map['comments'] as List<dynamic>)
              .map((e) => CompletedComment.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      title: map['title'] as String?,
      content: map['content'] as String?,
      author: map['author'] as String?,
    );
    return newValue;
  }

  CompletedPost copyWith({
    String? id,
    List<CompletedComment>? comments,
    String? title,
    String? content,
    String? author,
  }) {
    return CompletedPost(
      id: id ?? this.id,
      comments: comments ?? this.comments,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
    );
  }

  factory CompletedPost.fromJson(Map<String, dynamic> json) {
    return CompletedPost(
      id: json['id'] as String,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CompletedComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'comments': comments.map((e) => e.toJson()).toList(),
        'title': title,
        'content': content,
        'author': author,
      };
}
