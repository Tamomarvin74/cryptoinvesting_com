import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// VIEWMODELS
import 'viewmodels/theme_viewmodel.dart';
import 'viewmodels/market_viewmodel.dart';
import 'viewmodels/chart_viewmodel.dart';

/// SCREENS
import 'screens/market/market_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        /// 🌗 THEME (GLOBAL)
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),

        /// 📊 MARKET DATA
        ChangeNotifierProvider(create: (_) => MarketViewModel()),

        /// 📈 CHART DATA
        ChangeNotifierProvider(create: (_) => ChartViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// ✅ THIS IS THE KEY LINE
      themeMode: themeVM.themeMode,

      /// 🌞 LIGHT THEME
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),

      /// 🌙 DARK THEME
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0B0E11),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B0E11),
          foregroundColor: Colors.white,
        ),
      ),

      /// 🏠 HOME
      home: const MarketScreen(),
    );
  }
}
