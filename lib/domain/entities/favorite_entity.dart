/// Domain entity representing a favorite cryptocurrency, identified by its
/// symbol.
class FavoriteEntity {
  /// Constructs a [FavoriteEntity] with the given [symbol].
  const FavoriteEntity({required this.symbol});

  /// The symbol of the favorite cryptocurrency (e.g., 'BTCUSDT').
  final String symbol;
}
