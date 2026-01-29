import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/constants/news_categories.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines implements UseCase<List<Article>, TopHeadlinesParams> {
  final NewsRepository repository;

  GetTopHeadlines(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(TopHeadlinesParams params) async {
    return await repository.getTopHeadlines(
      category: params.category,
      country: params.country,
      page: params.page,
    );
  }
}

class TopHeadlinesParams extends Equatable {
  final NewsCategory? category;
  final String? country;
  final int page;

  const TopHeadlinesParams({
    this.category,
    this.country = 'us',
    this.page = 1,
  });

  @override
  List<Object?> get props => [category, country, page];
}
