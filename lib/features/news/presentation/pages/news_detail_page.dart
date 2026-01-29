import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/article.dart';
import '../widgets/article_image.dart';
import 'package:intl/intl.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({
    super.key,
    required this.article,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy • HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // TODO: Implement bookmark functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (article.urlToImage != null)
              ArticleImage(
                imageUrl: article.urlToImage!,
                height: 250,
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    article.title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Source and Date
                  Row(
                    children: [
                      Chip(
                        label: Text(article.sourceName),
                        backgroundColor: theme.colorScheme.primaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        dateFormat.format(article.publishedAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Author
                  if (article.author != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'By ${article.author}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),

                  const Divider(),
                  const SizedBox(height: 16),

                  // Description
                  if (article.description != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        article.description!,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  // Content
                  if (article.content != null)
                    Text(
                      article.content!,
                      style: theme.textTheme.bodyLarge,
                    ),

                  const SizedBox(height: 24),

                  // Read More Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchUrl(article.url),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Read Full Article'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
