import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/market_viewmodel.dart';
import '../../viewmodels/chart_viewmodel.dart';
import '../../screens/chart/chart_screen.dart';
import '../../widgets/price_change_text.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MarketViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Markets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: vm.fetchMarket,
          ),
        ],
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.market.length,
              itemBuilder: (context, index) {
                final crypto = vm.market[index];

                return ListTile(
                  title: Text(crypto.symbol),
                  subtitle: Text(
                    '\$${crypto.price.toStringAsFixed(2)}',
                  ),
                  trailing: PriceChangeText(crypto.change24h),

                  // ✅ OPEN CHART SCREEN
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                          create: (_) =>
                              ChartViewModel()..loadChart(crypto.symbol, '1h'),
                          child: ChartScreen(
                            symbol: crypto.symbol,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
