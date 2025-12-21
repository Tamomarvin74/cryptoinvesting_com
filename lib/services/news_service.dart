import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsService {
  static const String _baseUrl = 'https://cryptopanic.com/api/v1/posts/';

  static const String _apiKey =
      'c9b998f88882ceb143cc1047a24d91de1feef5d3'; // 🔴 PUT YOUR REAL KEY HERE

  /// ✅ THIS METHOD WAS MISSING
  Future<List<News>> fetchNews() async {
    final uri = Uri.parse('$_baseUrl?auth_token=$_apiKey&public=true');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load news');
    }

    final decoded = jsonDecode(response.body);
    final List results = decoded['results'];

    return results.map((e) => News.fromJson(e)).toList();
  }
}
