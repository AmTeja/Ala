// To parse this JSON data, do
//
//     final post = postFromMap(jsonString);

import 'dart:convert';

Article articleFromMap(String str) =>
    Article.fromMap(jsonDecode(str) as Map<String, dynamic>);

String articleToMap(Article data) => json.encode(data.toMap());

/// The model for an article
class Article {
  /// Creates a new instance of [Article] from a map
  factory Article.fromMap(Map<String, dynamic> json) => Article(
        id: json['id'].toString(),
        userId: json['user_id'].toString(),
        user: ArticleUser.fromMap(
            (json['user'] as List<dynamic>).first as Map<String, dynamic>),
        title: json['title'].toString(),
        summary: json['summary'].toString(),
        coverImage: json['cover_image'].toString(),
        category: json['category'].toString(),
        subCategory: json['sub_category'].toString(),
        steps: List<ArticleStep>.from(
          (json['steps'] as List<dynamic>)
              .map((x) => ArticleStep.fromMap(x as Map<String, dynamic>)),
        ).toList(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        updatedAt: DateTime.parse(json['updated_at'].toString()),
        deletedAt: DateTime.parse(json['deleted_at'].toString()),
        isPublic: json['is_public'] as bool,
      );

  /// Creates a new instance of [Article]
  Article({
    required this.id,
    required this.userId,
    required this.user,
    required this.title,
    required this.summary,
    required this.coverImage,
    required this.category,
    required this.subCategory,
    required this.steps,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.isPublic,
  });

  /// The id of the article
  final String id;

  /// The id of the user who created the post
  final String userId;

  /// The user who created the post
  final ArticleUser user;

  /// The title of the article
  final String title;

  /// The summary of the article
  final String summary;

  /// The cover image of the article
  final String coverImage;

  /// The category of the article
  final String category;

  /// The sub category of the article
  final String subCategory;

  /// The steps of the article
  final List<ArticleStep> steps;

  /// The date the article was created
  final DateTime createdAt;

  /// The date the article was last updated
  final DateTime updatedAt;

  /// The date the article was deleted
  final DateTime deletedAt;

  /// Whether the article is public or not
  final bool isPublic;

  /// Creates a copy of the article with the given fields replaced with the new
  Article copyWith({
    String? id,
    String? userId,
    ArticleUser? user,
    String? title,
    String? summary,
    String? coverImage,
    String? category,
    String? subCategory,
    List<ArticleStep>? steps,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool? isPublic,
  }) =>
      Article(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        user: user ?? this.user,
        title: title ?? this.title,
        summary: summary ?? this.summary,
        coverImage: coverImage ?? this.coverImage,
        category: category ?? this.category,
        subCategory: subCategory ?? this.subCategory,
        steps: steps ?? this.steps,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        isPublic: isPublic ?? this.isPublic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user': user.toMap(),
        'title': title,
        'summary': summary,
        'cover_image': coverImage,
        'category': category,
        'sub_category': subCategory,
        'steps': List<dynamic>.from(steps.map((x) => x.toMap())),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'deleted_at': deletedAt.toIso8601String(),
        'is_public': isPublic,
      };
}

/// The model for a step in an article
class ArticleStep {
  /// Creates a new instance of [ArticleStep]
  ArticleStep({
    required this.stepNumber,
    required this.description,
    this.image,
  });

  factory ArticleStep.fromMap(Map<String, dynamic> json) => ArticleStep(
        stepNumber: json['step_number'] as int,
        description: json['description'].toString(),
        image: json['image'].toString(),
      );

  /// The step number
  final int stepNumber;

  /// The description of the step
  final String description;

  /// The image of the step
  final String? image;

  ArticleStep copyWith({
    int? stepNumber,
    String? description,
    String? image,
  }) =>
      ArticleStep(
        stepNumber: stepNumber ?? this.stepNumber,
        description: description ?? this.description,
        image: image ?? this.image,
      );

  Map<String, dynamic> toMap() => {
        'step_number': stepNumber,
        'description': description,
        'image': image,
      };
}

class ArticleUser {
  factory ArticleUser.fromMap(Map<String, dynamic> json) => ArticleUser(
        id: json['_id'].toString(),
        username: json['username'].toString(),
        avatar: json['avatar'].toString(),
      );
  ArticleUser({
    required this.id,
    required this.username,
    required this.avatar,
  });

  final String id;
  final String username;
  final String avatar;

  ArticleUser copyWith({
    String? id,
    String? username,
    String? avatar,
  }) =>
      ArticleUser(
        id: id ?? this.id,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'username': username,
        'avatar': avatar,
      };
}
