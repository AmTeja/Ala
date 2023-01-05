part of 'single_article_bloc.dart';

abstract class SingleArticleEvent extends Equatable {
  const SingleArticleEvent();

  @override
  List<Object> get props => [];
}

class SingleArticleLoad extends SingleArticleEvent {
  const SingleArticleLoad(this.article);

  final Article article;

  @override
  List<Object> get props => [article];
}

class SingleArticleUpdate extends SingleArticleEvent {
  const SingleArticleUpdate(this.article);

  final Article article;

  @override
  List<Object> get props => [article];
}
