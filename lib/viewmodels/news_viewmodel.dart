import 'package:flutter/material.dart';
import '../models/news.dart';
import '../services/news_service.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsService _service = NewsService();

  List<News> news = [];
  bool loading = false;
  String? error;

  Future<void> loadNews() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      news = await _service.fetchNews();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
