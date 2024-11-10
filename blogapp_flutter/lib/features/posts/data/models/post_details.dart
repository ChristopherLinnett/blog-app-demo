import 'completed_comment.dart';
/// A model class representing the details of a post.
///
/// Contains all the information related to a single post including:
/// * The author of the post
/// * A list of comments associated with the post
/// * The main content of the post
/// * A unique identifier for the post
/// * The title of the post
///
/// Provides methods to convert to and from JSON format for data persistence
/// and API communication.
///
/// Example:
/// ```dart
/// final postDetails = PostDetails(
///   author: 'John Doe',
///   comments: [],
///   content: 'Post content here',
///   id: '123',
///   title: 'My Post'
/// );
/// ```

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