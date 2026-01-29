import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../../../../core/constants/news_categories.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getTopHeadlines({
    NewsCategory? category,
    String? country,
    int page = 1,
  });

  Future<Either<Failure, List<Article>>> searchNews({
    required String query,
    int page = 1,
  });

  Future<Either<Failure, List<Article>>> getNewsByCategory({
    required NewsCategory category,
    int page = 1,
  });
}
