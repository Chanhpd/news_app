import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../news/domain/entities/article.dart';
import '../repositories/bookmark_repository.dart';

class GetBookmarks implements UseCase<List<Article>, NoParams> {
  final BookmarkRepository repository;

  GetBookmarks(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await repository.getBookmarks();
  }
}
