import 'dart:math';
import 'package:flutter/material.dart';
import '../models/candle.dart';

class ChartViewModel extends ChangeNotifier {
  bool loading = true;

  List<Candle> candles = [];

  // ===== PRICE HEADER =====
  double price = 0;
  double change = 0;

  // ===== STATS =====
  String prevClose = '-';
  String open = '-';
  String dayRange = '-';
  String yearRange = '-';
  String yearChange = '-';

  Future<void> loadChart(String symbol, String timeframe) async {
    loading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    candles = _mockCandles();

    price = candles.last.close;
    prevClose = candles.first.close.toStringAsFixed(2);
    open = candles.first.open.toStringAsFixed(2);

    final low = candles.map((e) => e.low).reduce(min).toStringAsFixed(2);
    final high = candles.map((e) => e.high).reduce(max).toStringAsFixed(2);

    dayRange = '$low - $high';
    yearRange = '2.62 - 5.49';
    yearChange = '20.87';

    change = ((price - candles.first.close) / candles.first.close) * 100;

    loading = false;
    notifyListeners();
  }

  List<Candle> _mockCandles() {
    final now = DateTime.now();
    final rand = Random();
    double lastClose = 3.9;

    return List.generate(40, (i) {
      final open = lastClose;
      final close = open + (rand.nextDouble() - 0.5) * 0.08;
      final high = max(open, close) + rand.nextDouble() * 0.05;
      final low = min(open, close) - rand.nextDouble() * 0.05;

      lastClose = close;

      return Candle(
        time: now.subtract(Duration(minutes: (40 - i) * 15)),
        open: open,
        high: high,
        low: low,
        close: close,
      );
    });
  }
}
