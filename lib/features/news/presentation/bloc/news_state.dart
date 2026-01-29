import 'package:equatable/equatable.dart';
import '../../domain/entities/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoadingMore extends NewsState {
  final List<Article> currentArticles;

  const NewsLoadingMore(this.currentArticles);

  @override
  List<Object> get props => [currentArticles];
}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final bool hasMore;
  final int currentPage;

  const NewsLoaded({
    required this.articles,
    this.hasMore = true,
    this.currentPage = 1,
  });

  NewsLoaded copyWith({
    List<Article>? articles,
    bool? hasMore,
    int? currentPage,
  }) {
    return NewsLoaded(
      articles: articles ?? this.articles,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [articles, hasMore, currentPage];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}
