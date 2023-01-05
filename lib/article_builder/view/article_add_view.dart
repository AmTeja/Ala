import 'package:ala_mod/article_builder/bloc/article_builder_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleAddView extends StatelessWidget {
  const ArticleAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          _ArticleBuilderCoverImage(),
        ],
      ),
    );
  }
}

class _ArticleBuilderCoverImage extends StatelessWidget {
  const _ArticleBuilderCoverImage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBuilderBloc, ArticleBuilderState>(
        builder: (context, state) {
      return Container(
        height: 200,
        color: Colors.grey,
        child: const Center(
          child: Text('Cover Image'),
        ),
      );
    });
  }
}
