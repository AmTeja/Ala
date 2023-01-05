import 'package:ala_mod/articles/view/article_view.dart';
import 'package:articles_repository/articles_repository.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage(this.article, {super.key});

  static const routeName = '/article';

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ArticleView(article: article),
    );
  }
}
