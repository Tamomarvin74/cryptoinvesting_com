import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ✅ VIEWMODELS (plural — matches your folder)
import '../../viewmodels/market_viewmodel.dart';
import '../../viewmodels/chart_viewmodel.dart';

/// ✅ SCREENS
import '../chart/chart_screen.dart';
import '../news/news_screen.dart';
import '../ideas/ideas_screen.dart';
import '../watchlist/watchlist_screen.dart';
import '../more/more_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MarketViewModel>().loadInitialMarkets();
      _startLiveSimulation();
    });
  }

  void _startLiveSimulation() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      context.read<MarketViewModel>().simulateLiveUpdate();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MarketViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),

      /// 🔝 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text(
          'Markets',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      /// 📊 MARKET LIST
      body: ListView.builder(
        itemCount: vm.markets.length,
        itemBuilder: (context, index) {
          final m = vm.markets[index];
          final isGreen = m.change >= 0;

          return InkWell(
            onTap: () {
              context.read<ChartViewModel>().loadChart(m.symbol, '1D');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChartScreen(symbol: m.symbol),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF1E222D))),
              ),
              child: Row(
                children: [
                  /// LEFT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${m.time} | ${m.symbol}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// RIGHT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        m.price.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${isGreen ? '+' : ''}${m.change.toStringAsFixed(2)} '
                        '(${isGreen ? '+' : ''}${m.percent.toStringAsFixed(2)}%)',
                        style: TextStyle(
                          color: isGreen ? Colors.green : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      /// 🔻 BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF0B0E11),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (i) {
          setState(() => _currentIndex = i);

          switch (i) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewsScreen()),
              );
              break;

            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IdeasScreen()),
              );
              break;

            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WatchlistScreen()),
              );
              break;

            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MoreScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Markets',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Ideas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
      ),
    );
  }
}
