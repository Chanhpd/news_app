import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class SearchNews implements UseCase<List<Article>, SearchNewsParams> {
  final NewsRepository repository;

  SearchNews(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(SearchNewsParams params) async {
    return await repository.searchNews(
      query: params.query,
      page: params.page,
    );
  }
}

class SearchNewsParams extends Equatable {
  final String query;
  final int page;

  const SearchNewsParams({
    required this.query,
    this.page = 1,
  });

  @override
  List<Object> get props => [query, page];
}
