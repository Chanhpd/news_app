import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../bloc/bookmark_bloc.dart';
import '../bloc/bookmark_event.dart';
import '../bloc/bookmark_state.dart';
import '../../../news/presentation/widgets/article_card.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BookmarkBloc>()..add(LoadBookmarks()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarks'),
        ),
        body: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            if (state is BookmarkLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BookmarkError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
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
              );
            }

            if (state is BookmarkLoaded) {
              if (state.bookmarks.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No bookmarks yet'),
                      SizedBox(height: 8),
                      Text(
                        'Save articles to read them later',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.bookmarks.length,
                itemBuilder: (context, index) {
                  return ArticleCard(article: state.bookmarks[index]);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
