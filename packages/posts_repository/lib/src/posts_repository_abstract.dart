import 'package:posts_repository/src/models/models.dart';

/// {@template posts_repository_abstract}
/// Posts Repository Abstract.
/// {@endtemplate}
abstract class IPostsRepository {
  /// this function returns a list of posts.
  Future<List<Post>> getPosts(String accessToken, {int? page, int? limit});

  // /// this function returns a post.
  // Future<Post> getPost(int id);

  /// this function adds a post.
  Future<void> addPost(String accessToken, {required Post post});

  // /// this function updates a post.
  // Future<void> updatePost(Post post);

  // /// this function deletes a post.
  // Future<void> deletePost(int id);
}
