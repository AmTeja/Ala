import 'package:ala_mod/article_builder/bloc/article_builder_bloc.dart';
import 'package:ala_mod/article_builder/view/article_add_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleAddPage extends StatelessWidget {
  const ArticleAddPage({super.key});

  static const routeName = '/article/add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => ArticleBuilderBloc(),
        child: const ArticleAddView(),
      ),
    );
  }
}
