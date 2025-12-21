import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/candle.dart';
import '../../viewmodels/chart_viewmodel.dart';

class ChartScreen extends StatelessWidget {
  final String symbol;

  const ChartScreen({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChartViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        title: Text(symbol),
        centerTitle: false,
      ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PriceHeader(vm),
                _Tabs(),
                Expanded(child: _Chart(vm)),
                _Timeframes(symbol),
                _Stats(vm),
              ],
            ),
    );
  }
}

class _PriceHeader extends StatelessWidget {
  final ChartViewModel vm;
  const _PriceHeader(this.vm);

  @override
  Widget build(BuildContext context) {
    final green = vm.change >= 0;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vm.price.toStringAsFixed(3),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '${vm.change >= 0 ? '+' : ''}${vm.change.toStringAsFixed(2)}%',
            style: TextStyle(
              color: green ? Colors.green : Colors.red,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: const [
          Text(
            'Overview',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 16),
          Text('Technical', style: TextStyle(color: Colors.grey)),
          SizedBox(width: 16),
          Text('News', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final ChartViewModel vm;
  const _Chart(this.vm);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: const Color(0xFF0B0E11),
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(isVisible: false),
      primaryYAxis: NumericAxis(
        opposedPosition: true,
        labelStyle: const TextStyle(color: Colors.grey),
      ),
      series: <CandleSeries<Candle, DateTime>>[
        CandleSeries<Candle, DateTime>(
          dataSource: vm.candles,
          xValueMapper: (c, _) => c.time,
          openValueMapper: (c, _) => c.open,
          highValueMapper: (c, _) => c.high,
          lowValueMapper: (c, _) => c.low,
          closeValueMapper: (c, _) => c.close,
          bullColor: Colors.green,
          bearColor: Colors.red,
        ),
      ],
    );
  }
}

class _Timeframes extends StatelessWidget {
  final String symbol;
  const _Timeframes(this.symbol);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ChartViewModel>();
    final frames = ['1D', '1W', '1M', '1Y', '5Y'];

    return SizedBox(
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: frames
            .map(
              (f) => TextButton(
                onPressed: () => vm.loadChart(symbol, f),
                child: Text(f, style: const TextStyle(color: Colors.white)),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  final ChartViewModel vm;
  const _Stats(this.vm);

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _row('Previous Close', vm.prevClose),
          _row('Open', vm.open),
          _row('Day Range', vm.dayRange),
          _row('52W Range', vm.yearRange),
          _row('1Y Change', '${vm.yearChange}%'),
        ],
      ),
    );
  }
}
