import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/news_categories.dart';
import '../../../../core/di/injection.dart';
import '../../../news/presentation/bloc/news_bloc.dart';
import '../../../news/presentation/bloc/news_event.dart';
import '../../../news/presentation/bloc/news_state.dart';
import '../../../news/presentation/widgets/article_card.dart';

class CategoryPage extends StatefulWidget {
  final NewsCategory category;

  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();

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
        LoadMoreTopHeadlines(category: widget.category.name),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<NewsBloc>()
            ..add(LoadTopHeadlines(category: widget.category.name)),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.category.displayName)),
        body: BlocBuilder<NewsBloc, NewsState>(
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
                          LoadTopHeadlines(category: widget.category.name),
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
                      category: widget.category.name,
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

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
