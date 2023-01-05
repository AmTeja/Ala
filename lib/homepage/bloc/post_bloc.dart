import 'package:ala_mod/utils/secure_storage.dart';
import 'package:articles_repository/articles_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_repository/posts_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc(this._articlesRepository) : super(ArticleLoadInitial()) {
    on<ArticleLoad>(_onArticleLoad);
    on<ArticleLoadMore>(_onArticleLoadMore);
    on<ArticleAdd>(_onArticleAdd);
  }

  final ArticlesRepository _articlesRepository;

  Future<void> _onArticleLoad(
      ArticleLoad event, Emitter<ArticleState> emit) async {
    print("CALLED");
    emit(ArticleLoadInProgress());
    try {
      final articles = await _articlesRepository
          .getArticles(await SecureStorage.getAccessToken(), limit: 5);
      emit(ArticleLoadSuccess(articles));
    } on PostException catch (e) {
      emit(ArticleLoadFailure(e.message, e.code));
    }
  }

  Future<void> _onArticleLoadMore(
      ArticleLoadMore event, Emitter<ArticleState> emit) async {
    emit(ArticleLoadInProgress());
    try {
      final articles = await _articlesRepository.getArticles(
        await SecureStorage.getAccessToken(),
        page: event.page,
        limit: event.limit,
      );
      articles.addAll(event.previousArticles);
      print(articles);
      emit(ArticleLoadSuccess(articles));
    } on PostException catch (e) {
      emit(ArticleLoadFailure(e.message, e.code));
    }
  }

  Future<void> _onArticleAdd(
      ArticleAdd event, Emitter<ArticleState> emit) async {
    emit(ArticleAddSubmit(event.article));
    try {
      await _articlesRepository.addArticle(
        await SecureStorage.getAccessToken(),
        article: event.article,
      );
      emit(const ArticleAddSuccess());
    } on PostException catch (e) {
      emit(ArticleLoadFailure(e.message, e.code));
    }
  }
}
