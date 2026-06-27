import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/core/l10n/generated/app_localizations.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/favorites/favorites_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/favorites/favorites_state.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/detail/widgets/detail_row_widget.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/detail/widgets/price_header_widget.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/detail/widgets/range_bar_widget.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/detail/widgets/section_card_widget.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/home/widgets/kline_chart_widget.dart';
import 'package:provider/provider.dart';

/// Detail screen for displaying comprehensive information about a specific
/// crypto quote, including price, percentage change, and volume details.
@RoutePage()
class CryptoQuoteDetailScreen extends StatelessWidget {
  /// Creates an instance of [CryptoQuoteDetailScreen].
  const CryptoQuoteDetailScreen({required this.quote, super.key});

  /// The crypto quote to display details for.
  final CryptoQuoteEntity quote;

  @override
  Widget build(final BuildContext context) {
    final bool isPositive = quote.priceChangePct >= 0;
    final Color changeColor = isPositive ? Colors.green : Colors.red;
    final String changeSign = isPositive ? '+' : '';

    final FavoritesState favoritesState = context
        .watch<FavoritesNotifier>()
        .state;
    final bool isFavorite = switch (favoritesState) {
      FavoritesStateSuccess(:final List<FavoriteEntity> favorites) =>
        favorites.any((final FavoriteEntity f) => f.symbol == quote.symbol),
      _ => false,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(quote.symbol),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_outline,
              color: isFavorite ? Colors.amber : null,
            ),
            onPressed: () =>
                context.read<FavoritesNotifier>().toggleFavorite(quote.symbol),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          PriceHeader(
            quote: quote,
            isPositive: isPositive,
            changeColor: changeColor,
            changeSign: changeSign,
          ),
          const SizedBox(height: 24),
          RangeBar(quote: quote),
          const SizedBox(height: 24),
          SectionCard(
            title: 'Histórico de Preço',
            children: <Widget>[KlineChart(symbol: quote.symbol)],
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: AppLocalizations.of(context).priceChange24h,
            children: <Widget>[
              DetailRow(
                label: AppLocalizations.of(context).absoluteChange,
                value: '$changeSign${quote.priceChange.toStringAsFixed(8)}',
                valueColor: changeColor,
              ),
              DetailRow(
                label: AppLocalizations.of(context).high24h,
                value: quote.highPrice.toStringAsFixed(8),
              ),
              DetailRow(
                label: AppLocalizations.of(context).low24h,
                value: quote.lowPrice.toStringAsFixed(8),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: AppLocalizations.of(context).baseVolume,
            children: <Widget>[
              DetailRow(
                label: AppLocalizations.of(context).baseVolume,
                value: quote.volume.toStringAsFixed(4),
              ),
              DetailRow(
                label: AppLocalizations.of(context).quoteVolume,
                value: quote.quoteVolume.toStringAsFixed(4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
