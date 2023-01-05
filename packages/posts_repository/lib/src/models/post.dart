import 'package:equatable/equatable.dart';

///{@template post}
/// A post.
/// {@endtemplate}
class Post extends Equatable {
  /// Creates a Post with the given [id], [title], [caption], [image], [userId],
  /// [user], [createdAt], [updatedAt], [deletedAt], and [tags].
  const Post({
    required this.id,
    required this.title,
    required this.caption,
    required this.image,
    required this.userId,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.tags,
  });

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json['_id'].toString(),
        title: json['title'].toString(),
        caption: json['caption'].toString(),
        image: json['image'].toString(),
        userId: json['user_id'].toString(),
        user: PostUser.fromMap(
          (json['user'] as List<dynamic>).first as Map<String, dynamic>,
        ),
        createdAt: DateTime.parse(json['created_at'].toString()),
        updatedAt: DateTime.parse(json['updated_at'].toString()),
        deletedAt: DateTime.parse(json['deleted_at'].toString()),
        tags: List<String>.from(json['tags'] as List<dynamic>).toList(),
      );

  /// The unique identifier for the Post.
  final String id;

  /// The title of the Post.
  final String title;

  /// The caption of the Post.
  final String caption;

  /// The image of the Post.
  final String image;

  /// The user_id of the Post.
  final String userId;

  /// The user of the Post.
  final PostUser user;

  /// The created_at of the Post.
  final DateTime createdAt;

  /// The updated_at of the Post.
  final DateTime updatedAt;

  /// The deleted_at of the Post.
  final DateTime deletedAt;

  /// The tags of the Post.
  final List<String> tags;

  /// Returns a copy of this Post instance with the given fields replaced with
  /// the new values.
  Post copyWith({
    String? id,
    String? title,
    String? caption,
    String? image,
    String? userId,
    PostUser? user,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<String>? tags,
  }) =>
      Post(
        id: id ?? this.id,
        title: title ?? this.title,
        caption: caption ?? this.caption,
        image: image ?? this.image,
        userId: userId ?? this.userId,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        tags: tags ?? this.tags,
      );

  /// Returns a map representation of this Post instance.
  Map<String, dynamic> toMap() => {
        '_id': id,
        'title': title,
        'caption': caption,
        'image': image,
        'user_id': userId,
        'user': user,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'deleted_at': deletedAt.toIso8601String(),
        'tags': List<dynamic>.from(tags.map((x) => x)),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        caption,
        image,
        userId,
        user,
        createdAt,
        updatedAt,
        deletedAt,
        tags
      ];
}

/// Model for PostUser
class PostUser {
  /// Create a PostUser instance.
  PostUser({
    required this.id,
    required this.username,
    required this.avatar,
  });

  /// Create a PostUser instance from a Map.
  factory PostUser.fromMap(Map<String, dynamic> json) => PostUser(
        id: json['_id'].toString(),
        username: json['username'].toString(),
        avatar: json['avatar'].toString(),
      );

  /// The unique identifier for the user who posted the post.
  final String id;

  /// The username of the user who posted the post.
  final String username;

  /// The avatar of the user who posted the post.
  final String avatar;

  /// Create a copy of the PostUser with the given fields replaced with the
  /// new values.
  PostUser copyWith({
    String? id,
    String? username,
    String? avatar,
  }) =>
      PostUser(
        id: id ?? this.id,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
      );

  /// Convert a PostUser instance into a Map.
  Map<String, dynamic> toMap() => {
        '_id': id,
        'username': username,
        'avatar': avatar,
      };
}
