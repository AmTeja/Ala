import 'package:articles_repository/articles_repository.dart';
import 'package:flutter/material.dart';

class ArticleStepContainer extends StatelessWidget {
  const ArticleStepContainer({super.key, required this.step});

  final ArticleStep step;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Step ${step.stepNumber}:',
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 16),
        if (step.image != null)
          Image.network(
            step.image!,
            fit: BoxFit.cover,
          ),
        if (step.image != null) const SizedBox(height: 16),
        Text(
          step.description,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
