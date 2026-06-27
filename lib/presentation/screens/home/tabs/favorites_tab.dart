import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/crypto_quote/crypto_quote_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/favorites/favorites_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/favorites/favorites_state.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/home/widgets/quote_list.dart';
import 'package:provider/provider.dart';

/// Tab widget for displaying the user's favorite cryptocurrencies.
class FavoritesTab extends StatelessWidget {
  /// Creates an instance of [FavoritesTab] with the required list of
  /// cryptocurrency quotes.
  const FavoritesTab({required this.quotes, super.key});

  /// List of cryptocurrency quotes to be displayed in the favorites tab.
  final List<CryptoQuoteEntity> quotes;

  @override
  Widget build(final BuildContext context) {
    final FavoritesState favoritesState = context
        .watch<FavoritesNotifier>()
        .state;

    return switch (favoritesState) {
      FavoritesStateInitial() || FavoritesStateLoading() => const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      FavoritesStateFailure(:final String message) => Center(
        child: Text(message),
      ),
      FavoritesStateSuccess(:final List<FavoriteEntity> favorites) =>
        _buildList(context, favorites),
    };
  }

  Widget _buildList(
    final BuildContext context,
    final List<FavoriteEntity> favorites,
  ) {
    final List<CryptoQuoteEntity> favoriteQuotes = quotes
        .where(
          (final CryptoQuoteEntity q) =>
              favorites.any((final FavoriteEntity f) => f.symbol == q.symbol),
        )
        .toList();

    if (favoriteQuotes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.star_outline, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('Nenhum favorito ainda', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return QuoteList(
      quotes: favoriteQuotes,
      onRefresh: () => context.read<CryptoQuoteNotifier>().fetchQuotes(),
    );
  }
}
