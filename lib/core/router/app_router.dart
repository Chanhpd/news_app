import 'package:go_router/go_router.dart';
import '../../features/news/presentation/pages/news_detail_page.dart';
import '../../features/news/presentation/pages/search_page.dart';
import '../../features/categories/presentation/pages/category_page.dart';
import '../../features/bookmarks/presentation/pages/bookmarks_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/news/domain/entities/article.dart';
import '../../core/constants/news_categories.dart';
import '../presentation/pages/main_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/category/:category',
      name: 'category',
      builder: (context, state) {
        final categoryName = state.pathParameters['category']!;
        final category = NewsCategory.values.firstWhere(
          (c) => c.name == categoryName,
          orElse: () => NewsCategory.general,
        );
        return CategoryPage(category: category);
      },
    ),
    GoRoute(
      path: '/article',
      name: 'article-detail',
      builder: (context, state) {
        final article = state.extra as Article;
        return NewsDetailPage(article: article);
      },
    ),
    GoRoute(
      path: '/bookmarks',
      name: 'bookmarks',
      builder: (context, state) => const BookmarksPage(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
