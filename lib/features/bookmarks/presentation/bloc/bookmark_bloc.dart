import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/usecases/get_bookmarks.dart';
import '../../domain/usecases/add_bookmark.dart';
import '../../domain/usecases/remove_bookmark.dart';
import '../../domain/usecases/is_bookmarked.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final GetBookmarks getBookmarks;
  final AddBookmark addBookmark;
  final RemoveBookmark removeBookmark;
  final IsBookmarked isBookmarked;

  BookmarkBloc({
    required this.getBookmarks,
    required this.addBookmark,
    required this.removeBookmark,
    required this.isBookmarked,
  }) : super(BookmarkInitial()) {
    on<LoadBookmarks>(_onLoadBookmarks);
    on<AddBookmarkEvent>(_onAddBookmark);
    on<RemoveBookmarkEvent>(_onRemoveBookmark);
    on<CheckBookmarkStatus>(_onCheckBookmarkStatus);
  }

  Future<void> _onLoadBookmarks(
    LoadBookmarks event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoading());

    final result = await getBookmarks(const NoParams());

    result.fold(
      (failure) {
        logger.e('Error loading bookmarks: ${failure.message}');
        emit(BookmarkError(failure.message));
      },
      (bookmarks) {
        emit(BookmarkLoaded(bookmarks));
      },
    );
  }

  Future<void> _onAddBookmark(
    AddBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    final result = await addBookmark(AddBookmarkParams(article: event.article));

    result.fold(
      (failure) {
        logger.e('Error adding bookmark: ${failure.message}');
        emit(BookmarkError(failure.message));
      },
      (_) {
        emit(const BookmarkActionSuccess('Article bookmarked'));
        add(LoadBookmarks());
      },
    );
  }

  Future<void> _onRemoveBookmark(
    RemoveBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    final result = await removeBookmark(
      RemoveBookmarkParams(articleUrl: event.articleUrl),
    );

    result.fold(
      (failure) {
        logger.e('Error removing bookmark: ${failure.message}');
        emit(BookmarkError(failure.message));
      },
      (_) {
        emit(const BookmarkActionSuccess('Bookmark removed'));
        add(LoadBookmarks());
      },
    );
  }

  Future<void> _onCheckBookmarkStatus(
    CheckBookmarkStatus event,
    Emitter<BookmarkState> emit,
  ) async {
    final result = await isBookmarked(
      IsBookmarkedParams(articleUrl: event.articleUrl),
    );

    result.fold(
      (failure) {
        logger.e('Error checking bookmark status: ${failure.message}');
        emit(const BookmarkStatusLoaded(false));
      },
      (isBookmarked) {
        emit(BookmarkStatusLoaded(isBookmarked));
      },
    );
  }
}
