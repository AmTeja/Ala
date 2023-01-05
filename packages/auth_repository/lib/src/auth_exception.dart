///{@template auth_exception}
/// An exception thrown during authentication.
/// {@endtemplate}

class AuthException implements Exception {
  ///{@macro auth_exception}
  /// [message] is the message of the exception.
  /// [code] is the code of the exception.
  AuthException(this.message, this.code);

  /// The message of the exception.
  final String message;

  /// The code of the exception.
  final String code;

  /// Creates a [AuthException] from an [Exception].
  /// Returns null if the exception is null.
  /// Throws a [FormatException] if the exception is not in the expected format.

  static AuthException fromException(Exception? exception) {
    try {
      final message = exception.toString();
      final code = message.split(' ').first;
      return AuthException(message, code);
    } on Exception {
      throw FormatException(
        'Unable to parse exception: $exception',
        exception,
      );
    }
  }

  @override
  String toString() => 'AuthException: $message ($code)';
}
