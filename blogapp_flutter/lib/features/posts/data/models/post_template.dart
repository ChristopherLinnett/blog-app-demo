/// A template class for blog posts.
///
/// This class represents the basic structure of a blog post with title, content, and author information.
/// It provides functionality to convert the post data to and from JSON format.
///
/// Example:
/// ```dart
/// final post = PostTemplate(
///   title: 'My Blog Post',
///   content: 'This is the content',
///   author: 'John Doe'
/// );
/// ```
///
/// Properties:
/// - [title] The title of the blog post
/// - [content] The main content of the blog post
/// - [author] The name of the post author
class PostTemplate {
  final String title;
  final String content;
  final String author;

  PostTemplate({
    required this.title,
    required this.content,
    required this.author,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'author': author,
      };

  // Create from JSON
  factory PostTemplate.fromJson(Map<String, dynamic> json) {
    return PostTemplate(
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
    );
  }
}
