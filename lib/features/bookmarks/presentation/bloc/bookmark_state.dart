import 'package:equatable/equatable.dart';
import '../../../news/domain/entities/article.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<Article> bookmarks;

  const BookmarkLoaded(this.bookmarks);

  @override
  List<Object> get props => [bookmarks];
}

class BookmarkStatusLoaded extends BookmarkState {
  final bool isBookmarked;

  const BookmarkStatusLoaded(this.isBookmarked);

  @override
  List<Object> get props => [isBookmarked];
}

class BookmarkError extends BookmarkState {
  final String message;

  const BookmarkError(this.message);

  @override
  List<Object> get props => [message];
}

class BookmarkActionSuccess extends BookmarkState {
  final String message;

  const BookmarkActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}
