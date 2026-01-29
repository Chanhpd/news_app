import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../network/network_info.dart';
import '../network/dio_client.dart';
import '../../features/news/data/datasources/news_local_datasource.dart';
import '../../features/news/data/datasources/news_remote_datasource.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/domain/usecases/get_top_headlines.dart';
import '../../features/news/domain/usecases/search_news.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';
import '../../features/bookmarks/data/datasources/bookmark_local_datasource.dart';
import '../../features/bookmarks/data/repositories/bookmark_repository_impl.dart';
import '../../features/bookmarks/domain/repositories/bookmark_repository.dart';
import '../../features/bookmarks/domain/usecases/get_bookmarks.dart';
import '../../features/bookmarks/domain/usecases/add_bookmark.dart';
import '../../features/bookmarks/domain/usecases/remove_bookmark.dart';
import '../../features/bookmarks/domain/usecases/is_bookmarked.dart';
import '../../features/bookmarks/presentation/bloc/bookmark_bloc.dart';
import '../../shared/cubit/app_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  
  // Core
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );
  
  final dioClient = DioClient();
  getIt.registerLazySingleton<Dio>(() => dioClient.dio);

  // Data sources
  getIt.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(getIt<Dio>()),
  );
  
  getIt.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(getIt<SharedPreferences>()),
  );
  
  getIt.registerLazySingleton<BookmarkLocalDataSource>(
    () => BookmarkLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  // Repositories
  getIt.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: getIt<NewsRemoteDataSource>(),
      localDataSource: getIt<NewsLocalDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  
  getIt.registerLazySingleton<BookmarkRepository>(
    () => BookmarkRepositoryImpl(
      localDataSource: getIt<BookmarkLocalDataSource>(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetTopHeadlines(getIt<NewsRepository>()));
  getIt.registerLazySingleton(() => SearchNews(getIt<NewsRepository>()));
  getIt.registerLazySingleton(() => GetBookmarks(getIt<BookmarkRepository>()));
  getIt.registerLazySingleton(() => AddBookmark(getIt<BookmarkRepository>()));
  getIt.registerLazySingleton(() => RemoveBookmark(getIt<BookmarkRepository>()));
  getIt.registerLazySingleton(() => IsBookmarked(getIt<BookmarkRepository>()));

  // Blocs
  getIt.registerFactory(
    () => NewsBloc(
      getTopHeadlines: getIt<GetTopHeadlines>(),
      searchNews: getIt<SearchNews>(),
    ),
  );
  
  getIt.registerFactory(
    () => BookmarkBloc(
      getBookmarks: getIt<GetBookmarks>(),
      addBookmark: getIt<AddBookmark>(),
      removeBookmark: getIt<RemoveBookmark>(),
      isBookmarked: getIt<IsBookmarked>(),
    ),
  );
  
  getIt.registerLazySingleton(
    () => AppCubit(getIt<SharedPreferences>()),
  );
}
