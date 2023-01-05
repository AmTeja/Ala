part of 'article_builder_bloc.dart';

abstract class ArticleBuilderEvent extends Equatable {
  const ArticleBuilderEvent();

  @override
  List<Object> get props => [];
}

class ArticleBuilderCoverImageAdded extends ArticleBuilderEvent {
  const ArticleBuilderCoverImageAdded({required this.coverImage});

  final File coverImage;

  @override
  List<Object> get props => [coverImage];
}

class ArticleBuilderCoverImageChanged extends ArticleBuilderEvent {
  const ArticleBuilderCoverImageChanged({required this.coverImage});

  final File coverImage;

  @override
  List<Object> get props => [coverImage];
}

class ArticleBuilderCoverImageRemoved extends ArticleBuilderEvent {}

class ArticleBuilderTitleChanged extends ArticleBuilderEvent {
  const ArticleBuilderTitleChanged({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}
