import 'package:ala_mod/app/app.dart';
import 'package:ala_mod/article_builder/view/article_add_page.dart';
import 'package:ala_mod/homepage/bloc/post_bloc.dart';
import 'package:ala_mod/homepage/view/home_view.dart';
import 'package:articles_repository/articles_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF252525),
          title: const Text('Ala'),
          centerTitle: true,
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SearchBarWithProfile(),
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => ArticleBloc(context.read<ArticlesRepository>()),
          child: const HomeView(),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'addArticleFloatingActionButton',
          onPressed: () {
            try {
              Navigator.pushNamed(context, ArticleAddPage.routeName);
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
          },
          backgroundColor: const Color(0xFF252525),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
