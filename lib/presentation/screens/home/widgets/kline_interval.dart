import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/home/widgets/kline_chart_widget.dart';

/// List of available kline intervals for the chart.
class IntervalSelector extends StatelessWidget {
  /// Creates an instance of [IntervalSelector] with the specified current
  /// interval and a callback function to handle interval selection.
  const IntervalSelector({
    required this.current,
    required this.onSelected,
    super.key,
  });

  /// The currently selected kline interval, which determines the time frame of
  /// data displayed in the kline chart (e.g., '15m', '1h', '4h', '1d').
  final String current;

  /// Callback function that is called when a new interval is selected by the
  /// user.
  final void Function(String) onSelected;

  @override
  Widget build(final BuildContext context) => Row(
    children: kKlineIntervals.map((final String interval) {
      final bool isSelected = interval == current;
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(interval),
          selected: isSelected,
          onSelected: (_) => onSelected(interval),
        ),
      );
    }).toList(),
  );
}
