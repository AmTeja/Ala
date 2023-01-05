/// A class that represents an error while fetching a post.
class ArticleException implements Exception {
  /// Creates a [ArticleException].
  ArticleException(this.message, this.code);

  /// The error message.
  final String message;

  /// The error code.
  final int code;

  @override
  String toString() => 'PostException: $message';
}
