import 'dart:math';
import 'package:flutter/material.dart';

class Market {
  final String name;
  final String symbol;
  final String time;
  double price;
  double change;
  double percent;

  Market({
    required this.name,
    required this.symbol,
    required this.time,
    required this.price,
    required this.change,
    required this.percent,
  });
}

class MarketViewModel extends ChangeNotifier {
  final Random _rnd = Random();

  List<Market> markets = [];

  void loadInitialMarkets() {
    markets = [
      // 🔥 CRYPTO (TOP)
      Market(
        name: 'Bitcoin',
        symbol: 'BTC/USD',
        time: 'Live',
        price: 88074.3,
        change: -208.3,
        percent: -0.24,
      ),
      Market(
        name: 'Ethereum',
        symbol: 'ETH/USD',
        time: 'Live',
        price: 2976.14,
        change: -7.84,
        percent: -0.26,
      ),
      Market(
        name: 'Binance Coin',
        symbol: 'BNB/USD',
        time: 'Live',
        price: 612.40,
        change: 4.30,
        percent: 0.71,
      ),
      Market(
        name: 'Solana',
        symbol: 'SOL/USD',
        time: 'Live',
        price: 188.12,
        change: 2.45,
        percent: 1.32,
      ),
      Market(
        name: 'XRP',
        symbol: 'XRP/USD',
        time: 'Live',
        price: 1.9273,
        change: 0.0231,
        percent: 1.22,
      ),
      Market(
        name: 'Cardano',
        symbol: 'ADA/USD',
        time: 'Live',
        price: 0.6124,
        change: -0.0112,
        percent: -1.80,
      ),
      Market(
        name: 'Dogecoin',
        symbol: 'DOGE/USD',
        time: 'Live',
        price: 0.0912,
        change: 0.0041,
        percent: 4.70,
      ),
      Market(
        name: 'Avalanche',
        symbol: 'AVAX/USD',
        time: 'Live',
        price: 41.33,
        change: -0.92,
        percent: -2.18,
      ),
      Market(
        name: 'Polkadot',
        symbol: 'DOT/USD',
        time: 'Live',
        price: 8.42,
        change: 0.31,
        percent: 3.82,
      ),
      Market(
        name: 'Chainlink',
        symbol: 'LINK/USD',
        time: 'Live',
        price: 14.27,
        change: -0.44,
        percent: -2.99,
      ),

      // 💱 FOREX (MAJOR PAIRS)
      Market(
        name: 'EUR / USD',
        symbol: 'EUR/USD',
        time: 'Live',
        price: 1.0942,
        change: 0.0018,
        percent: 0.16,
      ),
      Market(
        name: 'USD / JPY',
        symbol: 'USD/JPY',
        time: 'Live',
        price: 157.76,
        change: 2.20,
        percent: 1.41,
      ),
      Market(
        name: 'GBP / USD',
        symbol: 'GBP/USD',
        time: 'Live',
        price: 1.2631,
        change: -0.0043,
        percent: -0.34,
      ),
      Market(
        name: 'USD / CHF',
        symbol: 'USD/CHF',
        time: 'Live',
        price: 0.8841,
        change: 0.0021,
        percent: 0.24,
      ),
      Market(
        name: 'AUD / USD',
        symbol: 'AUD/USD',
        time: 'Live',
        price: 0.6612,
        change: -0.0019,
        percent: -0.29,
      ),
      Market(
        name: 'USD / CAD',
        symbol: 'USD/CAD',
        time: 'Live',
        price: 1.3562,
        change: 0.0038,
        percent: 0.28,
      ),
      Market(
        name: 'NZD / USD',
        symbol: 'NZD/USD',
        time: 'Live',
        price: 0.6128,
        change: -0.0025,
        percent: -0.41,
      ),

      // 🪙 COMMODITIES
      Market(
        name: 'Gold',
        symbol: 'XAU/USD',
        time: 'Live',
        price: 4387.30,
        change: 22.80,
        percent: 0.52,
      ),
      Market(
        name: 'Silver',
        symbol: 'XAG/USD',
        time: 'Live',
        price: 51.22,
        change: -0.84,
        percent: -1.61,
      ),
      Market(
        name: 'Crude Oil',
        symbol: 'WTI',
        time: 'Live',
        price: 78.41,
        change: 1.12,
        percent: 1.45,
      ),
      Market(
        name: 'Brent Oil',
        symbol: 'BRENT',
        time: 'Live',
        price: 82.17,
        change: 0.94,
        percent: 1.16,
      ),
      Market(
        name: 'Natural Gas',
        symbol: 'NG',
        time: 'Live',
        price: 2.71,
        change: -0.06,
        percent: -2.17,
      ),

      // 📈 STOCKS (US BIG TECH)
      Market(
        name: 'Apple',
        symbol: 'AAPL',
        time: 'Market',
        price: 197.42,
        change: 1.92,
        percent: 0.98,
      ),
      Market(
        name: 'Microsoft',
        symbol: 'MSFT',
        time: 'Market',
        price: 409.11,
        change: -3.42,
        percent: -0.83,
      ),
      Market(
        name: 'Amazon',
        symbol: 'AMZN',
        time: 'Market',
        price: 184.66,
        change: 2.31,
        percent: 1.27,
      ),
      Market(
        name: 'NVIDIA',
        symbol: 'NVDA',
        time: 'Market',
        price: 180.99,
        change: 6.85,
        percent: 3.93,
      ),
      Market(
        name: 'Tesla',
        symbol: 'TSLA',
        time: 'Market',
        price: 481.20,
        change: -2.17,
        percent: -0.45,
      ),
      Market(
        name: 'Meta',
        symbol: 'META',
        time: 'Market',
        price: 357.14,
        change: 4.91,
        percent: 1.39,
      ),
      Market(
        name: 'Google',
        symbol: 'GOOGL',
        time: 'Market',
        price: 152.88,
        change: -1.24,
        percent: -0.80,
      ),
    ];

    notifyListeners();
  }

  void simulateLiveUpdate() {
    for (var m in markets) {
      final delta = (_rnd.nextDouble() - 0.5) * 2;
      m.price += delta;
      m.change = delta;
      m.percent = (delta / m.price) * 100;
    }
    notifyListeners();
  }
}
