class Crypto {
  final String symbol;
  final double price;
  final double change24h;

  Crypto({
    required this.symbol,
    required this.price,
    required this.change24h,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      symbol: json['symbol'] as String,
      price: double.parse(json['lastPrice']),
      change24h: double.parse(json['priceChangePercent']),
    );
  }
}
