import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:articles_repository/src/articles_repository_abstract.dart';
import 'package:articles_repository/src/models/article.dart';
import 'package:articles_repository/src/models/article_error.dart';

/// {@template articles_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ArticlesRepository implements IArticlesRepository {
  /// {@macro articles_repository}
  const ArticlesRepository(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<void> addArticle(
    String? accessToken, {
    required Article article,
  }) async {
    final response = await _apiClient.post('/articles',
        accessToken: accessToken, data: article.toMap());
    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 401) {
      throw ArticleException('Failed to authenticated', 401);
    } else {
      throw ArticleException('Failed to add article', response.statusCode);
    }
  }

  @override
  Future<List<Article>> getArticles(String? accessToken,
      {int? page, int? limit}) async {
    String path;
    if (page != null && limit != null) {
      path = '/articles?page=$page&limit=$limit';
    } else if (page != null) {
      path = '/articles?page=$page';
    } else if (limit != null) {
      path = '/articles?limit=$limit';
    } else {
      path = '/articles';
    }

    final response = await _apiClient.get(path, accessToken: accessToken);
    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body)['data'];
      final mapList = decodedBody['data'] as List<dynamic>;
      final articles = mapList
          .map((e) => Article.fromMap(e as Map<String, dynamic>))
          .toList();
      return articles;
    } else if (response.statusCode == 401) {
      throw ArticleException('Failed to authenticated', 401);
    } else {
      throw ArticleException('Failed to get posts', response.statusCode);
    }
  }
}
