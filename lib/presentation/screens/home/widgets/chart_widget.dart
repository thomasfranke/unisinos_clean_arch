import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:intl/intl.dart';

/// Widget for displaying a kline (candlestick) chart for a specific
/// cryptocurrency symbol, allowing users to switch between different time
/// intervals for the chart data.
class Chart extends StatelessWidget {
  /// Creates an instance of [Chart] with the specified list of klines to be
  /// displayed in the chart.
  const Chart({required this.klines, super.key});

  /// List of kline (candlestick) data points to be displayed in the chart,
  /// where each [Kline] represents a single candlestick.
  final List<Kline> klines;

  @override
  Widget build(final BuildContext context) {
    if (klines.isEmpty) {
      return const Center(
        child: Text('Sem dados', style: TextStyle(color: Colors.grey)),
      );
    }

    final List<FlSpot> spots = klines
        .asMap()
        .entries
        .map(
          (final MapEntry<int, Kline> e) =>
              FlSpot(e.key.toDouble(), e.value.close),
        )
        .toList();

    final double minY = klines
        .map((final Kline k) => k.low)
        .reduce((final double a, final double b) => a < b ? a : b);
    final double maxY = klines
        .map((final Kline k) => k.high)
        .reduce((final double a, final double b) => a > b ? a : b);

    final bool isPositive = klines.last.close >= klines.first.close;
    final Color lineColor = isPositive ? Colors.green : Colors.red;

    return LineChart(
      LineChartData(
        minY: minY * 0.999,
        maxY: maxY * 1.001,
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: Colors.grey.withAlpha(31), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              getTitlesWidget: (final double value, final TitleMeta meta) =>
                  Text(
                    value.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (klines.length / 4).ceilToDouble(),
              getTitlesWidget: (final double value, final TitleMeta meta) {
                final int index = value.toInt();
                if (index < 0 || index >= klines.length) {
                  return const SizedBox.shrink();
                }
                return Text(
                  DateFormat('HH:mm').format(klines[index].closeTime),
                  style: const TextStyle(fontSize: 9, color: Colors.grey),
                );
              },
            ),
          ),
        ),
        lineBarsData: <LineChartBarData>[
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: lineColor,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: lineColor.withAlpha(31),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (final List<LineBarSpot> spots) =>
                spots.map((final LineBarSpot spot) {
                  final Kline kline = klines[spot.x.toInt()];
                  return LineTooltipItem(
                    '${kline.close.toStringAsFixed(4)}\n',
                    TextStyle(
                      color: lineColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: DateFormat('dd/MM HH:mm').format(kline.closeTime),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
