import 'package:flutter/material.dart';

class PriceChangeText extends StatelessWidget {
  final double value;

  const PriceChangeText(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final isPositive = value >= 0;

    return Text(
      '${value.toStringAsFixed(2)}%',
      style: TextStyle(
        color: isPositive ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
