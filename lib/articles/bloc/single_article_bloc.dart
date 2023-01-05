import 'package:articles_repository/articles_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'single_article_event.dart';
part 'single_article_state.dart';

class SingleArticleBloc extends Bloc<SingleArticleEvent, SingleArticleState> {
  SingleArticleBloc({required ArticlesRepository postsRepository})
      : _articlesRepository = postsRepository,
        super(SingleArticleLoadInitial()) {
    on<SingleArticleLoad>(_onSinglePostLoad);
    on<SingleArticleUpdate>(_onSinglePostUpdate);
  }

  final ArticlesRepository _articlesRepository;

  Future<void> _onSinglePostLoad(
    SingleArticleLoad event,
    Emitter<SingleArticleState> emit,
  ) async {
    emit(SingleArticleLoadInProgress());
    try {
      emit(SingleArticleLoadSuccess(event.article));
    } catch (e) {
      emit(SingleArticleLoadFailure(e.toString()));
    }
  }

  Future<void> _onSinglePostUpdate(
    SingleArticleUpdate event,
    Emitter<SingleArticleState> emit,
  ) async {
    emit(SingleArticleLoadInProgress());
    try {
      // await _postsRepository.updatePost(event.post);
      emit(SingleArticleLoadSuccess(event.article));
    } catch (e) {
      emit(SingleArticleLoadFailure(e.toString()));
    }
  }
}
