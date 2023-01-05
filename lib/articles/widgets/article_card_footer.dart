import 'package:ala_mod/shared/custom_hero.dart';
import 'package:ala_mod/utils/strings.dart';
import 'package:articles_repository/articles_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Footer extends StatelessWidget {
  const Footer(this.article, {super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${article.user.username.firstLetterToUpperCase} on ${DateFormat('d/M/y').format(article.createdAt)}', // ignore: lines_longer_than_80_chars

            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          CustomHeroWrapper(
            tag: '${article.id}Title',
            child: Text(
              '${article.title.eachFirstLetterToUpperCase}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
