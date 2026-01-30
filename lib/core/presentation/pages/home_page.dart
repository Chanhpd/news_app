import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection.dart';
import '../../../features/news/presentation/bloc/news_bloc.dart';
import '../../../features/news/presentation/bloc/news_event.dart';
import '../../../features/news/presentation/bloc/news_state.dart';
import '../../../features/bookmarks/presentation/bloc/bookmark_bloc.dart';
import '../../../features/bookmarks/presentation/bloc/bookmark_event.dart';
import '../../../features/bookmarks/presentation/bloc/bookmark_state.dart';
import '../../../features/news/presentation/widgets/article_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<NewsBloc>()..add(const LoadTopHeadlines()),
        ),
        BlocProvider(
          create: (_) => getIt<BookmarkBloc>()..add(LoadBookmarks()),
        ),
      ],
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.push('/search');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NewsBloc>().add(const LoadTopHeadlines());
          context.read<BookmarkBloc>().add(LoadBookmarks());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hot News Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hot News',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to News tab (index 1)
                        // This will be handled by the MainPage
                      },
                      child: const Text('See All'),
                    ),
                  ],
                ),
              ),
              const _HotNewsSection(),

              const SizedBox(height: 24),

              // Bookmarks Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Bookmarks',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/bookmarks');
                      },
                      child: const Text('See All'),
                    ),
                  ],
                ),
              ),
              const _BookmarksSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HotNewsSection extends StatelessWidget {
  const _HotNewsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is NewsError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NewsBloc>().add(const LoadTopHeadlines());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is NewsLoaded) {
          final articles = state.articles.take(5).toList();

          if (articles.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('No hot news available')),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: articles.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final article = articles[index];
              return GestureDetector(
                onTap: () {
                  context.push('/article', extra: article);
                },
                child: ArticleCard(article: article),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _BookmarksSection extends StatelessWidget {
  const _BookmarksSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is BookmarkError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BookmarkBloc>().add(LoadBookmarks());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is BookmarkLoaded) {
          if (state.bookmarks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No bookmarks yet',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the bookmark icon on any article to save it',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            );
          }

          final bookmarks = state.bookmarks.take(3).toList();

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: bookmarks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final article = bookmarks[index];
              return GestureDetector(
                onTap: () {
                  context.push('/article', extra: article);
                },
                child: ArticleCard(article: article),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
