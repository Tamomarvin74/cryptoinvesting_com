import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/market/market_screen.dart';
import 'viewmodels/market_viewmodel.dart';

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MarketViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cryptoinvesting.com',
        theme: ThemeData.dark(),
        home: const MarketScreen(),
      ),
    );
  }
}
