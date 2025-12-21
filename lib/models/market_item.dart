class MarketItem {
  final String name;
  final String symbol;
  double price;
  double change;
  double percent;

  MarketItem({
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.percent,
  });
}
