/// Data Transfer Object for a single kline (candlestick) returned by the
/// Binance API. The response is a raw list, so no fromJson annotation is
/// used — fields are parsed by position.
class KlineDTO {
  /// Creates a [KlineDTO] with the given parameters.
  const KlineDTO({
    required this.openTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.closeTime,
    required this.numberOfTrades,
  });

  /// Parses a [KlineDTO] from a raw list returned by the Binance API.
  ///
  /// Binance returns klines as positional arrays, not JSON objects:
  /// [openTime, open, high, low, close, volume, closeTime, quoteVolume,
  ///  numberOfTrades, takerBuyBase, takerBuyQuote, ignore]
  factory KlineDTO.fromList(final List<dynamic> list) => KlineDTO(
    openTime: list[0] as int,
    open: list[1] as String,
    high: list[2] as String,
    low: list[3] as String,
    close: list[4] as String,
    volume: list[5] as String,
    closeTime: list[6] as int,
    numberOfTrades: list[8] as int,
  );

  /// The open time of the kline in milliseconds since epoch.
  final int openTime;

  /// The open price of the kline.
  final String open;

  /// The high price of the kline.
  final String high;

  /// The low price of the kline.
  final String low;

  /// The close price of the kline.
  final String close;

  /// The volume of the kline.
  final String volume;

  /// The close time of the kline in milliseconds since epoch.
  final int closeTime;

  /// The number of trades in the kline.
  final int numberOfTrades;
}
