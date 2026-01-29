import 'package:equatable/equatable.dart';
import '../../../news/domain/entities/article.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class LoadBookmarks extends BookmarkEvent {}

class AddBookmarkEvent extends BookmarkEvent {
  final Article article;

  const AddBookmarkEvent(this.article);

  @override
  List<Object> get props => [article];
}

class RemoveBookmarkEvent extends BookmarkEvent {
  final String articleUrl;

  const RemoveBookmarkEvent(this.articleUrl);

  @override
  List<Object> get props => [articleUrl];
}

class CheckBookmarkStatus extends BookmarkEvent {
  final String articleUrl;

  const CheckBookmarkStatus(this.articleUrl);

  @override
  List<Object> get props => [articleUrl];
}
