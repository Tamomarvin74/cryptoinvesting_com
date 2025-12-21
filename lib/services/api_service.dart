import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/crypto.dart';
import '../models/candle.dart';

class ApiService {
  static const _marketUrl = 'https://api.binance.com/api/v3/ticker/24hr';

  /// ================= MARKET =================
  static Future<List<Crypto>> fetchMarket() async {
    final res = await http.get(Uri.parse(_marketUrl));
    final List data = jsonDecode(res.body);

    return data
        .where((e) => e['symbol'].endsWith('USDT'))
        .take(20)
        .map((e) => Crypto.fromJson(e))
        .toList();
  }

  /// ================= CANDLES =================
  static Future<List<Candle>> fetchCandles(
    String symbol,
    String interval,
  ) async {
    final url =
        'https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval&limit=100';

    final res = await http.get(Uri.parse(url));
    final List data = jsonDecode(res.body);

    return data.map((e) => Candle.fromList(e)).toList();
  }
}
