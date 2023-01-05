import 'package:ala_mod/utils/strings.dart';
import 'package:articles_repository/articles_repository.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleAuthorContainerWithShare extends StatelessWidget {
  const ArticleAuthorContainerWithShare({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(article.user.avatar),
          ),
          const SizedBox(width: 8),
          Text(
            'By ${article.user.username.eachFirstLetterToUpperCase}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            timeago.format(article.createdAt),
            style: const TextStyle(
              color: Color(0xFF626262),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFF252525),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.share,
                color: Colors.white,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
