part of 'single_article_bloc.dart';

abstract class SingleArticleState extends Equatable {
  const SingleArticleState();

  @override
  List<Object> get props => [];
}

class SingleArticleLoadInitial extends SingleArticleState {}

class SingleArticleLoadInProgress extends SingleArticleState {}

class SingleArticleLoadFailure extends SingleArticleState {
  const SingleArticleLoadFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class SingleArticleLoadSuccess extends SingleArticleState {
  const SingleArticleLoadSuccess(this.article);

  final Article article;

  @override
  List<Object> get props => [article];
}
