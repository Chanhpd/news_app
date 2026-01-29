import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/article.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  final SourceModel? source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  ArticleModel({
    this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  Article toEntity() {
    return Article(
      sourceId: source?.id,
      sourceName: source?.name ?? 'Unknown',
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: DateTime.parse(publishedAt),
      content: content,
    );
  }

  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      source: SourceModel(
        id: article.sourceId,
        name: article.sourceName,
      ),
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt.toIso8601String(),
      content: article.content,
    );
  }
}

@JsonSerializable()
class SourceModel {
  final String? id;
  final String name;

  SourceModel({
    this.id,
    required this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}

@JsonSerializable()
class NewsResponse {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
