import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../news/domain/entities/article.dart';
import '../repositories/bookmark_repository.dart';

class AddBookmark implements UseCase<void, AddBookmarkParams> {
  final BookmarkRepository repository;

  AddBookmark(this.repository);

  @override
  Future<Either<Failure, void>> call(AddBookmarkParams params) async {
    return await repository.addBookmark(params.article);
  }
}

class AddBookmarkParams extends Equatable {
  final Article article;

  const AddBookmarkParams({required this.article});

  @override
  List<Object> get props => [article];
}
