import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/bookmark_repository.dart';

class IsBookmarked implements UseCase<bool, IsBookmarkedParams> {
  final BookmarkRepository repository;

  IsBookmarked(this.repository);

  @override
  Future<Either<Failure, bool>> call(IsBookmarkedParams params) async {
    return await repository.isBookmarked(params.articleUrl);
  }
}

class IsBookmarkedParams extends Equatable {
  final String articleUrl;

  const IsBookmarkedParams({required this.articleUrl});

  @override
  List<Object> get props => [articleUrl];
}
