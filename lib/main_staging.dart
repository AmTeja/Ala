import 'package:ala_mod/app/app.dart';
import 'package:ala_mod/bootstrap.dart';
import 'package:api_client/api_client.dart';
import 'package:articles_repository/articles_repository.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posts_repository/posts_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const secureStorage = FlutterSecureStorage();
  final accessToken = await secureStorage.read(key: 'access_token');
  final refreshToken = await secureStorage.read(key: 'refresh_token');
  final apiClient = ApiClient(
    config: ApiConfig.custom(
      baseUrl: 'http://192.168.29.134:3000',
      accessToken: accessToken,
      refreshToken: refreshToken,
    ),
  );
  final authRepository = AuthRepository(apiClient: apiClient);
  final postsRepository = PostsRepository(apiClient: apiClient);
  final articlesRepository = ArticlesRepository(apiClient);
  await bootstrap(
    () => App(
      authRepository: authRepository,
      postsRepository: postsRepository,
      articlesRepository: articlesRepository,
    ),
  );
}
