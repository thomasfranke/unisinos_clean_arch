import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/quote_result.dart';

/// Repository interface for fetching cryptocurrency quotes.
abstract interface class CryptoQuoteRepository {
  /// Fetches a list of cryptocurrency quotes.
  Future<QuoteResult> getQuotes();

  /// Fetches a single cryptocurrency quote by its symbol.
  Future<CryptoQuoteEntity> getQuote(final String symbol);
}
