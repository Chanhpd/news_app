import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/news_categories.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({
    NewsCategory? category,
    String? country,
    int page = 1,
  });

  Future<List<ArticleModel>> searchNews({
    required String query,
    int page = 1,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ArticleModel>> getTopHeadlines({
    NewsCategory? category,
    String? country,
    int page = 1,
  }) async {
    try {
      final response = await dio.get(
        '/top-headlines',
        queryParameters: {
          'apiKey': AppConstants.newsApiKey,
          'country': country ?? 'us',
          if (category != null) 'category': category.apiValue,
          'page': page,
          'pageSize': AppConstants.pageSize,
        },
      );

      if (response.statusCode == 200) {
        final newsResponse = NewsResponse.fromJson(response.data);
        return newsResponse.articles;
      } else {
        throw ServerException('Failed to load news');
      }
    } on DioException catch (e) {
      logger.e('DioException in getTopHeadlines');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.response?.statusCode == 401) {
        throw ServerException('Invalid API key');
      } else if (e.response?.statusCode == 429) {
        throw ServerException('Rate limit exceeded');
      } else {
        throw ServerException('Server error: ${e.message}');
      }
    } catch (e) {
      logger.e('Error in getTopHeadlines');
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<List<ArticleModel>> searchNews({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await dio.get(
        '/everything',
        queryParameters: {
          'apiKey': AppConstants.newsApiKey,
          'q': query,
          'page': page,
          'pageSize': AppConstants.pageSize,
          'sortBy': 'publishedAt',
        },
      );

      if (response.statusCode == 200) {
        final newsResponse = NewsResponse.fromJson(response.data);
        return newsResponse.articles;
      } else {
        throw ServerException('Failed to search news');
      }
    } on DioException catch (e) {
      logger.e('DioException in searchNews');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.response?.statusCode == 401) {
        throw ServerException('Invalid API key');
      } else if (e.response?.statusCode == 429) {
        throw ServerException('Rate limit exceeded');
      } else {
        throw ServerException('Server error: ${e.message}');
      }
    } catch (e) {
      logger.e('Error in searchNews');
      throw ServerException('Unexpected error occurred');
    }
  }
}
