import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class PriceSocket {
  static WebSocketChannel connect(String symbol) {
    return WebSocketChannel.connect(
      Uri.parse(
        'wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}usdt@trade',
      ),
    );
  }

  static double parsePrice(dynamic message) {
    final data = jsonDecode(message);
    return double.parse(data['p']);
  }
}
