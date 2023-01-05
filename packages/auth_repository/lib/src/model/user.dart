import 'package:equatable/equatable.dart';

///{@template user}
/// A user model.
/// {@endtemplate}

class User extends Equatable {
  ///{@macro user}
  /// [id] is the id of the user.
  /// [username] is the username of the user.
  /// [email] is the email of the user.
  /// [avatar] is the avatar of the user.
  /// [bio] is the bio of the user.

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.bio,
  });

  /// An empty user which represents an unauthenticated user.
  static const empty = User(
    id: '',
    username: '',
    email: '',
    avatar: '',
    bio: '',
  );

  /// The id of the user.
  final String id;

  /// The username of the user.
  final String username;

  /// The email of the user.
  final String email;

  /// The avatar of the user.
  final String avatar;

  /// The bio of the user.
  final String bio;

  @override
  List<Object> get props => [
        id,
        username,
        email,
        avatar,
        bio,
      ];

  /// Creates a [User] from a JSON map.
  /// Returns null if the JSON is null.
  /// Throws a [FormatException] if the JSON is not in the expected format.

  static User? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    try {
      return User(
        id: json['_id'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        avatar: json['avatar'] as String,
        bio: json['bio'] as String,
      );
    } on Exception {
      throw const FormatException('Unable to parse JSON into User');
    }
  }

  /// Creates a [User] from a access token claims.
  /// Returns null if the claims is null.
  /// Throws a [FormatException] if the claims is not in the expected format.

  // ignore: prefer_constructors_over_static_methods
  static User fromClaims(Map<String, dynamic> claims) {
    try {
      return User(
        id: claims['userId'] as String,
        username: claims['username'] as String,
        email: claims['email'] as String,
        avatar: claims['avatar'] as String,
        bio: claims['bio'] as String,
      );
    } on Exception {
      throw const FormatException('Unable to parse claims into User');
    }
  }

  /// Creates a JSON map from a [User].
  /// Returns null if the [User] is null.
  /// Throws a [FormatException] if the [User] is not in the expected format.
  /// The [User] is expected to have a valid id, username, email, avatar and bio
  /// The id, username, email, avatar and bio must not be empty.

  static Map<String, dynamic>? toJson(User? user) {
    if (user == null) {
      return null;
    }

    try {
      return <String, dynamic>{
        '_id': user.id,
        'username': user.username,
        'email': user.email,
        'avatar': user.avatar,
        'bio': user.bio,
      };
    } on Exception {
      throw const FormatException('Unable to parse User into JSON');
    }
  }
}
