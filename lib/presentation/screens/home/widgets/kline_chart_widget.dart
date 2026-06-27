import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/home/widgets/kline_chart_state.dart';

/// Widget for displaying a kline (candlestick) chart for a specific
/// cryptocurrency symbol, allowing users to switch between different time
/// intervals for the chart data.
const List<String> kKlineIntervals = <String>['15m', '1h', '4h', '1d'];

/// Widget for displaying a kline (candlestick) chart.
class KlineChart extends StatefulWidget {
  /// Creates an instance of [KlineChart] for the specified
  /// cryptocurrency symbol.
  const KlineChart({required this.symbol, super.key});

  /// The cryptocurrency symbol for which the kline (candlestick) chart will
  /// be displayed.
  final String symbol;

  @override
  State<KlineChart> createState() => KlineChartState();
}
