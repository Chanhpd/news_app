import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../news/domain/entities/article.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, List<Article>>> getBookmarks();
  Future<Either<Failure, void>> addBookmark(Article article);
  Future<Either<Failure, void>> removeBookmark(String articleUrl);
  Future<Either<Failure, bool>> isBookmarked(String articleUrl);
}
