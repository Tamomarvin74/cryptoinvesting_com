class Candle {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;

  Candle({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  /// ✅ Binance kline → Candle
  factory Candle.fromList(List e) {
    return Candle(
      time: DateTime.fromMillisecondsSinceEpoch(e[0]),
      open: double.parse(e[1]),
      high: double.parse(e[2]),
      low: double.parse(e[3]),
      close: double.parse(e[4]),
    );
  }
}
