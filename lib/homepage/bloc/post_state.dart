part of 'post_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleLoadInitial extends ArticleState {}

class ArticleLoadInProgress extends ArticleState {}

class ArticleLoadSuccess extends ArticleState {
  const ArticleLoadSuccess(this.articles);

  final List<Article> articles;

  @override
  List<Object> get props => [articles];
}

class ArticleLoadFailure extends ArticleState {
  const ArticleLoadFailure(this.error, this.code);

  final String error;
  final int code;
  @override
  List<Object> get props => [error, code];
}

class ArticleAddSubmit extends ArticleState {
  const ArticleAddSubmit(this.article);

  final Article article;
  @override
  List<Object> get props => [article];
}

class ArticleAddSuccess extends ArticleState {
  const ArticleAddSuccess();
}
