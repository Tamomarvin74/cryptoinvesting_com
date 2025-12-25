import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  static const String _apiKey = '5f310f22d0ad44429ecdba8debabb0d9';

  Future<List<NewsArticle>> fetchCryptoNews({String query = ''}) async {
    final q = query.isEmpty ? 'crypto' : query;

    final uri = Uri.parse(
      'https://newsapi.org/v2/everything'
      '?q=$q'
      '&language=en'
      '&sortBy=publishedAt'
      '&pageSize=20'
      '&apiKey=$_apiKey',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load news (${response.statusCode}): ${response.body}',
      );
    }

    final decoded = json.decode(response.body);
    final List articles = decoded['articles'] ?? [];

    return articles
        .map((e) => NewsArticle.fromJson(e))
        .where((a) => a.title.isNotEmpty)
        .toList();
  }
}
