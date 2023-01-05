part of 'article_builder_bloc.dart';

abstract class ArticleBuilderState extends Equatable {
  const ArticleBuilderState();

  @override
  List<Object> get props => [];
}

class ArticleBuilderInitial extends ArticleBuilderState {}

class ArticleBuilderLoading extends ArticleBuilderState {}

class ArticleBuilderEditMode extends ArticleBuilderState {}

class ArticleBuilderPreviewMode extends ArticleBuilderState {}
