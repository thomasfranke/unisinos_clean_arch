import 'package:flutter/material.dart';

/// A chip widget that displays the price change percentage of a crypto quote,
/// along with an arrow icon indicating the direction of the change
/// (up or down).
class TrendChip extends StatelessWidget {
  /// Creates a new instance of [TrendChip].
  const TrendChip({
    required this.isPositive,
    required this.changeColor,
    required this.changeSign,
    required this.priceChangePct,
    super.key,
  });

  /// Indicates whether the price change is positive (true) or negative (false).
  final bool isPositive;

  /// The color to use for the text and icon, typically green for
  /// positive changes
  final Color changeColor;

  /// A string to prefix the percentage change, usually '+' for positive changes
  final String changeSign;

  /// The percentage change in price, displayed as text in the chip.
  final double priceChangePct;

  @override
  Widget build(final BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: changeColor.withAlpha(31),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          isPositive ? Icons.arrow_upward : Icons.arrow_downward,
          color: changeColor,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '$changeSign${priceChangePct.toStringAsFixed(2)}%',
          style: TextStyle(
            color: changeColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
