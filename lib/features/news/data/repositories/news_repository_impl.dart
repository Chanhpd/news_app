import 'package:dartz/dartz.dart';
import '../../../../core/constants/news_categories.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_local_datasource.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines({
    NewsCategory? category,
    String? country,
    int page = 1,
  }) async {
    final cacheKey = 'top_headlines_${category?.name ?? 'all'}_${country ?? 'us'}_$page';
    
    if (await networkInfo.isConnected) {
      try {
        final articles = await remoteDataSource.getTopHeadlines(
          category: category,
          country: country,
          page: page,
        );
        
        // Cache the results
        await localDataSource.cacheNews(cacheKey, articles);
        
        return Right(articles.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        logger.e('ServerException in getTopHeadlines');
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        logger.e('NetworkException in getTopHeadlines');
        return Left(NetworkFailure(e.message));
      } catch (e) {
        logger.e('Unexpected error in getTopHeadlines');
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    } else {
      // Try to get cached data when offline
      try {
        final cachedArticles = await localDataSource.getCachedNews(cacheKey);
        return Right(cachedArticles.map((model) => model.toEntity()).toList());
      } on CacheException {
        return const Left(NetworkFailure('No internet connection and no cached data available'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Article>>> searchNews({
    required String query,
    int page = 1,
  }) async {
    final cacheKey = 'search_${query}_$page';
    
    if (await networkInfo.isConnected) {
      try {
        final articles = await remoteDataSource.searchNews(
          query: query,
          page: page,
        );
        
        // Cache the results
        await localDataSource.cacheNews(cacheKey, articles);
        
        return Right(articles.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        logger.e('ServerException in searchNews');
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        logger.e('NetworkException in searchNews');
        return Left(NetworkFailure(e.message));
      } catch (e) {
        logger.e('Unexpected error in searchNews');
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    } else {
      // Try to get cached data when offline
      try {
        final cachedArticles = await localDataSource.getCachedNews(cacheKey);
        return Right(cachedArticles.map((model) => model.toEntity()).toList());
      } on CacheException {
        return const Left(NetworkFailure('No internet connection and no cached data available'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getNewsByCategory({
    required NewsCategory category,
    int page = 1,
  }) async {
    return getTopHeadlines(category: category, page: page);
  }
}
