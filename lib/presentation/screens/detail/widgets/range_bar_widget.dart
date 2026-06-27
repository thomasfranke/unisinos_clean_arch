import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';

/// A widget that displays a horizontal range bar indicating the position of the
/// current price within the 24-hour low and high price range of a crypto quote.
class RangeBar extends StatelessWidget {
  /// Creates a new instance of [RangeBar].
  const RangeBar({required this.quote, super.key});

  /// The crypto quote containing the price and range information to display in
  /// the range bar.
  final CryptoQuoteEntity quote;

  @override
  Widget build(final BuildContext context) {
    final double range = quote.highPrice - quote.lowPrice;
    final double progress = range > 0
        ? ((quote.lastPrice - quote.lowPrice) / range).clamp(0.0, 1.0)
        : 0.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Range 24h',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.red.withAlpha(31),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              quote.lowPrice.toStringAsFixed(4),
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
            Text(
              quote.highPrice.toStringAsFixed(4),
              style: const TextStyle(color: Colors.green, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
