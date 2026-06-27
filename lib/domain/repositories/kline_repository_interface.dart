import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';

/// Repository interface for fetching kline (candlestick) data.
abstract interface class KlineRepository {
  /// Fetches a list of kline (candlestick) data for a given symbol
  /// and interval.
  Future<List<Kline>> getKlines({
    required final String symbol,
    required final String interval,
    final int limit,
  });
}
