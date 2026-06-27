import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';

/// Wrapper that carries the list of quotes and the data source (network or
/// cache) through the layers of the application.
class QuoteResult {
  /// Creates an instance of [QuoteResult] with the given list of cryptocurrency
  /// quotes and an optional [fromCache] flag indicating whether the quotes were
  /// retrieved from cache (true) or from the remote API (false, default).
  const QuoteResult(this.quotes, {this.fromCache = false});

  /// List of cryptocurrency quotes retrieved from either the remote API or
  /// the cache.
  final List<CryptoQuoteEntity> quotes;

  /// Indicates whether the data was retrieved from the local cache (true) or
  /// from the remote API (false).
  final bool fromCache;
}
