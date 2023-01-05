import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'article_builder_event.dart';
part 'article_builder_state.dart';

class ArticleBuilderBloc
    extends Bloc<ArticleBuilderEvent, ArticleBuilderState> {
  ArticleBuilderBloc() : super(ArticleBuilderInitial()) {
    on<ArticleBuilderCoverImageAdded>(_onCoverImageAdded);
    on<ArticleBuilderCoverImageRemoved>(_onCoverImageRemoved);
    on<ArticleBuilderCoverImageChanged>(_onCoverImageChanged);
    on<ArticleBuilderTitleChanged>(_onTitleChanged);
  }

  File? _coverImage;
  String? _title;

  void _onCoverImageAdded(
    ArticleBuilderCoverImageAdded event,
    Emitter<ArticleBuilderState> emit,
  ) {
    _coverImage = event.coverImage;
    emit(ArticleBuilderEditMode());
  }

  void _onCoverImageRemoved(
    ArticleBuilderCoverImageRemoved event,
    Emitter<ArticleBuilderState> emit,
  ) {
    _coverImage = null;
    emit(ArticleBuilderEditMode());
  }

  void _onCoverImageChanged(
    ArticleBuilderCoverImageChanged event,
    Emitter<ArticleBuilderState> emit,
  ) {
    _coverImage = event.coverImage;
    emit(ArticleBuilderEditMode());
  }

  void _onTitleChanged(
    ArticleBuilderTitleChanged event,
    Emitter<ArticleBuilderState> emit,
  ) {
    _title = event.title;
    emit(ArticleBuilderEditMode());
  }
}
