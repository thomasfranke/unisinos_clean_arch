import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/detail/widgets/trend_chip_widget.dart';

/// A widget that displays the price header information for a crypto quote,
/// including the symbol, last price, and a trend chip indicating the
/// percentage change.
class PriceHeader extends StatelessWidget {
  /// Creates a new instance of [PriceHeader].
  const PriceHeader({
    required this.quote,
    required this.isPositive,
    required this.changeColor,
    required this.changeSign,
    super.key,
  });

  /// The crypto quote containing the price and symbol information to display in
  /// the header.
  final CryptoQuoteEntity quote;

  /// Indicates whether the price change is positive (true) or negative (false).
  final bool isPositive;

  /// The color to use for the text and icon in the trend chip, typically green
  /// for positive changes and red for negative changes.
  final Color changeColor;

  /// A string to prefix the percentage change in the trend chip, usually '+'
  /// for positive changes and '' for negative changes.
  final String changeSign;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        quote.symbol,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: Colors.grey),
      ),
      const SizedBox(height: 4),
      Text(
        quote.lastPrice.toStringAsFixed(8),
        style: Theme.of(
          context,
        ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Row(
        children: <Widget>[
          TrendChip(
            isPositive: isPositive,
            changeColor: changeColor,
            changeSign: changeSign,
            priceChangePct: quote.priceChangePct,
          ),
        ],
      ),
    ],
  );
}
