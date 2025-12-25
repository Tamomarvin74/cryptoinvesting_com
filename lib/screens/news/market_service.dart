import 'dart:math';

class MarketService {
  Future<Map<String, double>> fetchMetals() async {
    // Simulated real-time change (replace later with live API)
    final rnd = Random();

    return {
      'XAU/USD': rnd.nextDouble() * 2,
      'XAG/USD': rnd.nextDouble() * 2,
      'XPT/USD': rnd.nextDouble() * 2,
      'XPD/USD': rnd.nextDouble() * 2,
    };
  }
}
