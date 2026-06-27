/// Domain entity representing a cryptocurrency quote, used within the
/// application to encapsulate the relevant data for a cryptocurrency pair.
class CryptoQuoteEntity {
  /// Constructs a [CryptoQuoteEntity] with the given parameters.
  const CryptoQuoteEntity({
    required this.symbol,
    required this.lastPrice,
    required this.priceChange,
    required this.priceChangePct,
    required this.highPrice,
    required this.lowPrice,
    required this.volume,
    required this.quoteVolume,
  });

  /// The symbol of the cryptocurrency pair (e.g., 'BTCUSDT').
  final String symbol;

  /// The last traded price of the cryptocurrency pair.
  final double lastPrice;

  /// The absolute price change over the last 24 hours.
  final double priceChange;

  /// The percentage price change over the last 24 hours.
  final double priceChangePct;

  /// The highest price of the cryptocurrency pair over the last 24 hours.
  final double highPrice;

  /// The lowest price of the cryptocurrency pair over the last 24 hours.
  final double lowPrice;

  /// The total trading volume of the cryptocurrency pair over
  /// the last 24 hours.
  final double volume;

  /// The total quote volume (price * volume) of the cryptocurrency
  /// pair over the last 24 hours.
  final double quoteVolume;
}
