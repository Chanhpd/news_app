import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/constants/news_categories.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';
import '../widgets/article_card.dart';
import '../widgets/category_chips.dart';

class NewsHomePage extends StatelessWidget {
  const NewsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NewsBloc>()..add(const LoadTopHeadlines()),
      child: const NewsHomeView(),
    );
  }
}

class NewsHomeView extends StatefulWidget {
  const NewsHomeView({super.key});

  @override
  State<NewsHomeView> createState() => _NewsHomeViewState();
}

class _NewsHomeViewState extends State<NewsHomeView> {
  final ScrollController _scrollController = ScrollController();
  NewsCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<NewsBloc>().add(
        LoadMoreTopHeadlines(category: _selectedCategory?.name),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onCategorySelected(NewsCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
    context.read<NewsBloc>().add(LoadTopHeadlines(category: category?.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => context.push('/bookmarks'),
          ),
        ],
      ),
      body: Column(
        children: [
          CategoryChips(
            selectedCategory: _selectedCategory,
            onCategorySelected: _onCategorySelected,
          ),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is NewsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(state.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<NewsBloc>().add(
                              LoadTopHeadlines(
                                category: _selectedCategory?.name,
                              ),
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is NewsLoaded || state is NewsLoadingMore) {
                  final articles = state is NewsLoaded
                      ? state.articles
                      : (state as NewsLoadingMore).currentArticles;

                  if (articles.isEmpty) {
                    return const Center(child: Text('No articles found'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<NewsBloc>().add(
                        LoadTopHeadlines(
                          category: _selectedCategory?.name,
                          refresh: true,
                        ),
                      );
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          articles.length + (state is NewsLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= articles.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return ArticleCard(article: articles[index]);
                      },
                    ),
                  );
                }

                return const Center(child: Text('Start browsing news'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
