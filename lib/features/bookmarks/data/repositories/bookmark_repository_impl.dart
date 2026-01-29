import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../../news/domain/entities/article.dart';
import '../../../news/data/models/article_model.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../datasources/bookmark_local_datasource.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDataSource localDataSource;

  BookmarkRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Article>>> getBookmarks() async {
    try {
      final bookmarks = await localDataSource.getBookmarks();
      return Right(bookmarks.map((model) => model.toEntity()).toList());
    } on CacheException catch (e) {
      logger.e('CacheException in getBookmarks');
      return Left(CacheFailure(e.message));
    } catch (e) {
      logger.e('Unexpected error in getBookmarks');
      return const Left(CacheFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> addBookmark(Article article) async {
    try {
      final articleModel = ArticleModel.fromEntity(article);
      await localDataSource.addBookmark(articleModel);
      return const Right(null);
    } on CacheException catch (e) {
      logger.e('CacheException in addBookmark');
      return Left(CacheFailure(e.message));
    } catch (e) {
      logger.e('Unexpected error in addBookmark');
      return const Left(CacheFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> removeBookmark(String articleUrl) async {
    try {
      await localDataSource.removeBookmark(articleUrl);
      return const Right(null);
    } on CacheException catch (e) {
      logger.e('CacheException in removeBookmark');
      return Left(CacheFailure(e.message));
    } catch (e) {
      logger.e('Unexpected error in removeBookmark');
      return const Left(CacheFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> isBookmarked(String articleUrl) async {
    try {
      final isBookmarked = await localDataSource.isBookmarked(articleUrl);
      return Right(isBookmarked);
    } catch (e) {
      logger.e('Error checking bookmark status');
      return const Right(false);
    }
  }
}
