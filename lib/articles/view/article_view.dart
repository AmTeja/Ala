import 'package:ala_mod/articles/widgets/article_page_author_container.dart';
import 'package:ala_mod/articles/widgets/article_page_step.dart';
import 'package:ala_mod/articles/widgets/article_summary_container.dart';
import 'package:ala_mod/shared/custom_hero.dart';
import 'package:articles_repository/articles_repository.dart';
import 'package:flutter/material.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: '${article.id}Image',
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                article.coverImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                CustomHeroWrapper(
                  tag: '${article.id}Title',
                  child: Text(
                    article.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ArticleAuthorContainerWithShare(
                  article: article,
                ),
                const SizedBox(height: 20),
                ArticleSummaryContainer(article: article),
                const SizedBox(height: 20),
                _StepsBuilder(article.steps),
                const SizedBox(height: 20),
                const CommentSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _StepsBuilder extends StatelessWidget {
  const _StepsBuilder(this.steps);

  final List<ArticleStep> steps;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return ArticleStepContainer(step: steps[index]);
      },
    );
  }
}

class CommentSection extends StatelessWidget {
  const CommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Text('Comment Section'),
    );
  }
}
