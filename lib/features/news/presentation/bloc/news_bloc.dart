import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/news_categories.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/search_news.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetTopHeadlines getTopHeadlines;
  final SearchNews searchNews;

  NewsBloc({
    required this.getTopHeadlines,
    required this.searchNews,
  }) : super(NewsInitial()) {
    on<LoadTopHeadlines>(_onLoadTopHeadlines);
    on<LoadMoreTopHeadlines>(_onLoadMoreTopHeadlines);
    on<SearchNewsEvent>(_onSearchNews);
    on<LoadMoreSearchResults>(_onLoadMoreSearchResults);
  }

  Future<void> _onLoadTopHeadlines(
    LoadTopHeadlines event,
    Emitter<NewsState> emit,
  ) async {
    if (!event.refresh) {
      emit(NewsLoading());
    }

    final category = event.category != null
        ? NewsCategory.values.firstWhere(
            (c) => c.name == event.category,
            orElse: () => NewsCategory.general,
          )
        : null;

    final result = await getTopHeadlines(
      TopHeadlinesParams(
        category: category,
        country: event.country,
        page: 1,
      ),
    );

    result.fold(
      (failure) {
        logger.e('Error loading headlines: ${failure.message}');
        emit(NewsError(failure.message));
      },
      (articles) {
        emit(NewsLoaded(
          articles: articles,
          hasMore: articles.isNotEmpty,
          currentPage: 1,
        ));
      },
    );
  }

  Future<void> _onLoadMoreTopHeadlines(
    LoadMoreTopHeadlines event,
    Emitter<NewsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! NewsLoaded || !currentState.hasMore) return;

    emit(NewsLoadingMore(currentState.articles));

    final nextPage = currentState.currentPage + 1;
    final category = event.category != null
        ? NewsCategory.values.firstWhere(
            (c) => c.name == event.category,
            orElse: () => NewsCategory.general,
          )
        : null;

    final result = await getTopHeadlines(
      TopHeadlinesParams(
        category: category,
        country: event.country,
        page: nextPage,
      ),
    );

    result.fold(
      (failure) {
        logger.e('Error loading more headlines: ${failure.message}');
        emit(currentState);
      },
      (newArticles) {
        final allArticles = [...currentState.articles, ...newArticles];
        emit(NewsLoaded(
          articles: allArticles,
          hasMore: newArticles.isNotEmpty,
          currentPage: nextPage,
        ));
      },
    );
  }

  Future<void> _onSearchNews(
    SearchNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    if (!event.refresh) {
      emit(NewsLoading());
    }

    final result = await searchNews(
      SearchNewsParams(query: event.query, page: 1),
    );

    result.fold(
      (failure) {
        logger.e('Error searching news: ${failure.message}');
        emit(NewsError(failure.message));
      },
      (articles) {
        emit(NewsLoaded(
          articles: articles,
          hasMore: articles.isNotEmpty,
          currentPage: 1,
        ));
      },
    );
  }

  Future<void> _onLoadMoreSearchResults(
    LoadMoreSearchResults event,
    Emitter<NewsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! NewsLoaded || !currentState.hasMore) return;

    emit(NewsLoadingMore(currentState.articles));

    final nextPage = currentState.currentPage + 1;
    final result = await searchNews(
      SearchNewsParams(query: event.query, page: nextPage),
    );

    result.fold(
      (failure) {
        logger.e('Error loading more search results: ${failure.message}');
        emit(currentState);
      },
      (newArticles) {
        final allArticles = [...currentState.articles, ...newArticles];
        emit(NewsLoaded(
          articles: allArticles,
          hasMore: newArticles.isNotEmpty,
          currentPage: nextPage,
        ));
      },
    );
  }
}
