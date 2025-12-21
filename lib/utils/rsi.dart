import '../models/candle.dart';

double calculateRSI(List<Candle> candles, int period) {
  if (candles.length < period + 1) return 0;

  double gain = 0;
  double loss = 0;

  for (int i = 1; i <= period; i++) {
    final diff = candles[i].close - candles[i - 1].close;
    if (diff >= 0) {
      gain += diff;
    } else {
      loss -= diff;
    }
  }

  if (loss == 0) return 100;

  final rs = gain / loss;
  return 100 - (100 / (1 + rs));
}
