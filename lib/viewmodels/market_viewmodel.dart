import 'dart:async';
import 'package:flutter/material.dart';
import '../models/crypto.dart';
import '../services/api_service.dart';

class MarketViewModel extends ChangeNotifier {
  List<Crypto> market = [];
  bool isLoading = false;
  Timer? _timer;

  MarketViewModel() {
    fetchMarket();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      fetchMarket();
    });
  }

  Future<void> fetchMarket() async {
    try {
      isLoading = true;
      notifyListeners();

      market = await ApiService.fetchMarket();
    } catch (_) {}

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
