import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/chart_viewmodel.dart';
import 'viewmodels/news_viewmodel.dart';
import 'viewmodels/market_viewmodel.dart';
import 'screens/market/market_screen.dart';

void main() {
  runApp(const CryptoInvestingApp());
}

class CryptoInvestingApp extends StatelessWidget {
  const CryptoInvestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// 📊 MARKET DATA
        ChangeNotifierProvider(create: (_) => MarketViewModel()),

        /// 📈 CHART DATA
        ChangeNotifierProvider(create: (_) => ChartViewModel()),

        /// 📰 NEWS DATA
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const MarketScreen(),
      ),
    );
  }
}
