part of 'post_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class ArticleLoad extends ArticleEvent {}

class ArticleLoadMore extends ArticleEvent {
  const ArticleLoadMore(
    this.previousArticles, {
    required this.page,
    required this.limit,
  });

  final int page;
  final int limit;
  final List<Article> previousArticles;

  @override
  List<Object> get props => [page, limit, previousArticles];
}

class ArticleAdd extends ArticleEvent {
  const ArticleAdd(this.article);

  final Article article;

  @override
  List<Object> get props => [article];
}
