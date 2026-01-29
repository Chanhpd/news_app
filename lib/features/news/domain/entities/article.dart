import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String? sourceId;
  final String sourceName;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  const Article({
    this.sourceId,
    required this.sourceName,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props => [
        sourceId,
        sourceName,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
