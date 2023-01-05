import 'package:articles_repository/src/models/article.dart';

/// {@template articles_repository_abstract}
/// Articles Repository Abstract.
/// {@endtemplate}
abstract class IArticlesRepository {
  /// this function returns a list of articles.
  Future<List<Article>> getArticles(String accessToken,
      {int? page, int? limit});

  /// this function adds an article.
  Future<void> addArticle(String accessToken, {required Article article});
}
