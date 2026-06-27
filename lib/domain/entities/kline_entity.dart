/// Domain entity representing a single candlestick (kline) data point,
/// containing OHLC price data, volume, and trade count for a given time period.
class Kline {
  /// Constructs a [Kline] with the given parameters.
  const Kline({
    required this.openTime,
    required this.closeTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.numberOfTrades,
  });

  /// The opening time of the kline period.
  final DateTime openTime;

  /// The closing time of the kline period.
  final DateTime closeTime;

  /// The opening price of the kline period.
  final double open;

  /// The highest price during the kline period.
  final double high;

  /// The lowest price during the kline period.
  final double low;

  /// The closing price of the kline period.
  final double close;

  /// The total trading volume during the kline period.
  final double volume;

  /// The total number of trades during the kline period.
  final int numberOfTrades;
}
