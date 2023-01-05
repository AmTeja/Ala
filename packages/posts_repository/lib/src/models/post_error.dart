/// A class that represents an error while fetching a post.
class PostException implements Exception {
  /// Creates a [PostException].
  PostException(this.message, this.code);

  /// The error message.
  final String message;

  /// The error code.
  final int code;

  @override
  String toString() => 'PostException: $message';
}
