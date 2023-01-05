import 'package:ala_mod/app/app.dart';
import 'package:ala_mod/articles/view/article_card_view.dart';
import 'package:ala_mod/articles/view/article_page.dart';
import 'package:ala_mod/homepage/bloc/post_bloc.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is ArticleLoadInitial) {
          context.read<ArticleBloc>().add(ArticleLoad());
        }
        if (state is ArticleLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ArticleLoadFailure) {
          if (state.code == 401) {
            context.select(
              (AppBloc bloc) => bloc.add(AuthenticationLogoutRequested()),
            );
          }
          return Center(child: Text(state.error));
        }
        if (state is ArticleLoadSuccess) {
          return _buildListView(state);
        }
        return const Center(child: Text('Something went wrong'));
      },
    );
  }
}

ListView _buildListView(ArticleLoadSuccess state) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: state.articles.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, ArticlePage.routeName,
            arguments: state.articles[index]),
        child: ArticleCardView(article: state.articles[index]),
      );
    },
  );
}

class SearchBarWithProfile extends StatelessWidget {
  const SearchBarWithProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.only(left: 12),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search for articles, users, categories',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              )),
        ),
        const SizedBox(width: 10),
        const ProfileWidget(),
      ],
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return Container(
          margin: const EdgeInsets.only(left: 10, right: 16),
          height: 46,
          width: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(state.user.avatar),
              fit: BoxFit.fill,
            ),
          ),
        );
      }
      return const SizedBox();
    });
  }
}
