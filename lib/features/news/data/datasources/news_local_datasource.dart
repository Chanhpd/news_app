import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/article_model.dart';

abstract class NewsLocalDataSource {
  Future<List<ArticleModel>> getCachedNews(String key);
  Future<void> cacheNews(String key, List<ArticleModel> articles);
  Future<void> clearCache();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final SharedPreferences sharedPreferences;
  
  static const String cachedNewsPrefix = 'CACHED_NEWS_';

  NewsLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ArticleModel>> getCachedNews(String key) async {
    try {
      final cacheKey = cachedNewsPrefix + key;
      final jsonString = sharedPreferences.getString(cacheKey);
      
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw CacheException('No cached data found');
      }
    } catch (e) {
      logger.e('Error getting cached news');
      throw CacheException('Failed to get cached news');
    }
  }

  @override
  Future<void> cacheNews(String key, List<ArticleModel> articles) async {
    try {
      final cacheKey = cachedNewsPrefix + key;
      final jsonList = articles.map((article) => article.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(cacheKey, jsonString);
      logger.d('Cached ${articles.length} articles with key: $cacheKey');
    } catch (e) {
      logger.e('Error caching news');
      throw CacheException('Failed to cache news');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final keys = sharedPreferences.getKeys();
      for (final key in keys) {
        if (key.startsWith(cachedNewsPrefix)) {
          await sharedPreferences.remove(key);
        }
      }
      logger.d('Cache cleared');
    } catch (e) {
      logger.e('Error clearing cache');
      throw CacheException('Failed to clear cache');
    }
  }
}
