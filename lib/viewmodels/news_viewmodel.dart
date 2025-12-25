import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsService _service = NewsService();

  List<NewsArticle> news = [];
  bool loading = false;
  String? error;

  Future<void> loadNews() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      news = await _service.fetchCryptoNews(); // ✅ CORRECT METHOD
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
