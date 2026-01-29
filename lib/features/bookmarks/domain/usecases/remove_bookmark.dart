import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/bookmark_repository.dart';

class RemoveBookmark implements UseCase<void, RemoveBookmarkParams> {
  final BookmarkRepository repository;

  RemoveBookmark(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveBookmarkParams params) async {
    return await repository.removeBookmark(params.articleUrl);
  }
}

class RemoveBookmarkParams extends Equatable {
  final String articleUrl;

  const RemoveBookmarkParams({required this.articleUrl});

  @override
  List<Object> get props => [articleUrl];
}
