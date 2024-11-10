/// A template class for blog post comments.
///
/// This class represents the structure of a comment with its essential properties:
/// [postId], [content], and [author].
///
/// The class provides methods to convert to and from JSON format:
/// * [toJson] converts the comment instance to a JSON map
/// * [fromJson] creates a new comment instance from a JSON map
///
/// Example:
/// ```dart
/// final comment = CommentTemplate(
///   postId: '123',
///   content: 'Great post!',
///   author: 'John Doe'
/// );
/// ```
class CommentTemplate {
  final String postId;
  final String content;
  final String author;

  const CommentTemplate({
    required this.postId,
    required this.content,
    required this.author,
  });

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'content': content,
        'author': author,
      };

  factory CommentTemplate.fromJson(Map<String, dynamic> json) {
    return CommentTemplate(
      postId: json['postId'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
    );
  }
}