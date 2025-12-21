import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/news.dart';

class NewsService {
  /// 🔑 PUT YOUR REAL API KEY HERE
  static const String _apiKey = 'c9b998f88882ceb143cc1047a24d91de1feef5d3';

  static const String _baseUrl = 'https://cryptopanic.com/api/v1/posts/';

  Future<List<News>> fetchNews() async {
    final uri = Uri.parse(
      '$_baseUrl?auth_token=$_apiKey&public=true&kind=news',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      final data = json.decode(response.body);

      if (data == null || data['results'] == null) {
        throw Exception('Invalid API response');
      }

      return (data['results'] as List).map((e) => News.fromJson(e)).toList();
    } catch (e) {
      // 🔥 NEVER CRASH THE APP
      throw Exception('Failed to load news: $e');
    }
  }
}
