import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../../../news/data/models/article_model.dart';

abstract class BookmarkLocalDataSource {
  Future<List<ArticleModel>> getBookmarks();
  Future<void> addBookmark(ArticleModel article);
  Future<void> removeBookmark(String articleUrl);
  Future<bool> isBookmarked(String articleUrl);
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String bookmarksKey = 'BOOKMARKS';

  BookmarkLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ArticleModel>> getBookmarks() async {
    try {
      final jsonString = sharedPreferences.getString(bookmarksKey);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      logger.e('Error getting bookmarks');
      throw CacheException('Failed to get bookmarks');
    }
  }

  @override
  Future<void> addBookmark(ArticleModel article) async {
    try {
      final bookmarks = await getBookmarks();
      
      // Check if already bookmarked
      if (bookmarks.any((a) => a.url == article.url)) {
        return;
      }
      
      bookmarks.add(article);
      final jsonList = bookmarks.map((a) => a.toJson()).toList();
      await sharedPreferences.setString(bookmarksKey, json.encode(jsonList));
      logger.d('Bookmark added: ${article.title}');
    } catch (e) {
      logger.e('Error adding bookmark');
      throw CacheException('Failed to add bookmark');
    }
  }

  @override
  Future<void> removeBookmark(String articleUrl) async {
    try {
      final bookmarks = await getBookmarks();
      bookmarks.removeWhere((article) => article.url == articleUrl);
      final jsonList = bookmarks.map((a) => a.toJson()).toList();
      await sharedPreferences.setString(bookmarksKey, json.encode(jsonList));
      logger.d('Bookmark removed');
    } catch (e) {
      logger.e('Error removing bookmark');
      throw CacheException('Failed to remove bookmark');
    }
  }

  @override
  Future<bool> isBookmarked(String articleUrl) async {
    try {
      final bookmarks = await getBookmarks();
      return bookmarks.any((article) => article.url == articleUrl);
    } catch (e) {
      logger.e('Error checking bookmark status');
      return false;
    }
  }
}
