/// Data Transfer Object (DTO) for cryptocurrency quotes, used for parsing
/// API responses.
class CryptoQuoteDTO {
  /// Creates an instance of [CryptoQuoteDTO] with the given parameters.
  const CryptoQuoteDTO({
    this.symbol,
    this.priceChange,
    this.priceChangePercent,
    this.weightedAvgPrice,
    this.prevClosePrice,
    this.lastPrice,
    this.lastQty,
    this.bidPrice,
    this.bidQty,
    this.askPrice,
    this.askQty,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.volume,
    this.quoteVolume,
    this.openTime,
    this.closeTime,
    this.firstId,
    this.lastId,
    this.count,
  });

  /// Factory constructor to create a [CryptoQuoteDTO] from a JSON map.
  factory CryptoQuoteDTO.fromJson(Map<String, dynamic> json) => CryptoQuoteDTO(
    symbol: json['symbol'] as String?,
    priceChange: json['priceChange'] as String?,
    priceChangePercent: json['priceChangePercent'] as String?,
    weightedAvgPrice: json['weightedAvgPrice'] as String?,
    prevClosePrice: json['prevClosePrice'] as String?,
    lastPrice: json['lastPrice'] as String?,
    lastQty: json['lastQty'] as String?,
    bidPrice: json['bidPrice'] as String?,
    bidQty: json['bidQty'] as String?,
    askPrice: json['askPrice'] as String?,
    askQty: json['askQty'] as String?,
    openPrice: json['openPrice'] as String?,
    highPrice: json['highPrice'] as String?,
    lowPrice: json['lowPrice'] as String?,
    volume: json['volume'] as String?,
    quoteVolume: json['quoteVolume'] as String?,
    openTime: json['openTime'] as int?,
    closeTime: json['closeTime'] as int?,
    firstId: json['firstId'] as int?,
    lastId: json['lastId'] as int?,
    count: json['count'] as int?,
  );

  /// Fields corresponding to the cryptocurrency quote data.
  final String? symbol;

  /// The price change over the last 24 hours.
  final String? priceChange;

  /// The percentage price change over the last 24 hours.
  final String? priceChangePercent;

  /// The weighted average price over the last 24 hours.
  final String? weightedAvgPrice;

  /// The previous closing price.
  final String? prevClosePrice;

  /// The last price of the cryptocurrency.
  final String? lastPrice;

  /// The quantity of the last trade.
  final String? lastQty;

  /// The current highest bid price.
  final String? bidPrice;

  /// The quantity of the current highest bid.
  final String? bidQty;

  /// The current lowest ask price.
  final String? askPrice;

  /// The quantity of the current lowest ask.
  final String? askQty;

  /// The opening price of the cryptocurrency.
  final String? openPrice;

  /// The highest price of the cryptocurrency in the last 24 hours.
  final String? highPrice;

  /// The lowest price of the cryptocurrency in the last 24 hours.
  final String? lowPrice;

  /// The total trading volume of the cryptocurrency in the last 24 hours.
  final String? volume;

  /// The total trading volume in quote currency in the last 24 hours.
  final String? quoteVolume;

  /// The timestamp of the opening time of the cryptocurrency.
  final int? openTime;

  /// The timestamp of the closing time of the cryptocurrency.
  final int? closeTime;

  /// The ID of the first trade in the last 24 hours.
  final int? firstId;

  /// The ID of the last trade in the last 24 hours.
  final int? lastId;

  /// The total number of trades in the last 24 hours.
  final int? count;
}
