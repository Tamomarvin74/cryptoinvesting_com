import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/candle.dart';

class ChartApi {
  static Future<List<Candle>> fetchCandles(
    String symbol,
    String interval,
  ) async {
    final url =
        'https://api.binance.com/api/v3/klines?symbol=${symbol}USDT&interval=$interval&limit=200';

    final res = await http.get(Uri.parse(url));
    final data = jsonDecode(res.body) as List;

    return data.map((e) => Candle.fromList(e)).toList();
  }
}
