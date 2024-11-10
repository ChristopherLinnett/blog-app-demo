import 'package:blogapp_flutter/features/posts/data/models/completed_comment.dart';


class PostDetails {
  final String author;
  final List<CompletedComment> comments;
  final String content;
  final String id;
  final String title;

  PostDetails({
    required this.author,
    required this.comments,
    required this.content,
    required this.id,
    required this.title,
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) {
    return PostDetails(
      author: json['author'] as String,
      comments: (json['comments'] as List)
          .map((e) => CompletedComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String,
      id: json['id'] as String,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'author': author,
        'comments': comments.map((e) => e.toJson()).toList(),
        'content': content,
        'id': id,
        'title': title,
      };
}