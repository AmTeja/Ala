import 'package:articles_repository/articles_repository.dart';
import 'package:flutter/material.dart';

class ArticleSummaryContainer extends StatelessWidget {
  const ArticleSummaryContainer({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Text(
      article.summary,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: Color(0xff626262),
      ),
    );
  }
}
