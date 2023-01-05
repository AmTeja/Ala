import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:posts_repository/src/models/models.dart';
import 'package:posts_repository/src/models/post_error.dart';
import 'package:posts_repository/src/posts_repository_abstract.dart';

/// {@template posts_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class PostsRepository implements IPostsRepository {
  /// {@macro posts_repository}
  PostsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Returns a list of posts.
  @override
  Future<List<Post>> getPosts(
    String? accessToken, {
    int? page,
    int? limit,
  }) async {
    String path;
    if (page != null && limit != null) {
      path = '/posts?page=$page&limit=$limit';
    } else if (page != null) {
      path = '/posts?page=$page';
    } else if (limit != null) {
      path = '/posts?limit=$limit';
    } else {
      path = '/posts';
    }
    final response = await _apiClient.get(path, accessToken: accessToken);
    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body)['data'];
      final mapList = decodedBody['data'] as List<dynamic>;
      final posts =
          mapList.map((e) => Post.fromMap(e as Map<String, dynamic>)).toList();
      return posts;
    } else if (response.statusCode == 401) {
      throw PostException('Failed to authenticated', 401);
    } else {
      throw PostException('Failed to get posts', response.statusCode);
    }
  }

  @override
  Future<void> addPost(String accessToken, {required Post post}) async {
    final response = await _apiClient.post('/posts',
        accessToken: accessToken, data: post.toMap());
  }

  // @override
  // Future<void> deletePost(int id) {
  //   // TODO: implement deletePost
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Post> getPost(int id) {
  //   // TODO: implement getPost
  //   throw UnimplementedError();
  // }

  // @override
  // Future<void> updatePost(Post post) {
  //   // TODO: implement updatePost
  //   throw UnimplementedError();
  // }
}
