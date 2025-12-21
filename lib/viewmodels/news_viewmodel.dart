import 'package:flutter/material.dart';
import '../models/news.dart';
import '../services/news_service.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsService _service = NewsService();

  bool loading = false;
  List<News> news = [];

  Future<void> loadNews() async {
    try {
      loading = true;
      notifyListeners();

      news = await _service.fetchNews();
    } catch (e) {
      debugPrint('News load error: $e');
      news = [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
