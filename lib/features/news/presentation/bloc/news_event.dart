import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTopHeadlines extends NewsEvent {
  final String? category;
  final String? country;
  final bool refresh;

  const LoadTopHeadlines({
    this.category,
    this.country = 'us',
    this.refresh = false,
  });

  @override
  List<Object?> get props => [category, country, refresh];
}

class LoadMoreTopHeadlines extends NewsEvent {
  final String? category;
  final String? country;

  const LoadMoreTopHeadlines({
    this.category,
    this.country = 'us',
  });

  @override
  List<Object?> get props => [category, country];
}

class SearchNewsEvent extends NewsEvent {
  final String query;
  final bool refresh;

  const SearchNewsEvent({
    required this.query,
    this.refresh = false,
  });

  @override
  List<Object> get props => [query, refresh];
}

class LoadMoreSearchResults extends NewsEvent {
  final String query;

  const LoadMoreSearchResults({required this.query});

  @override
  List<Object> get props => [query];
}
