import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';

/// Base class for representing the state of cryptocurrency quotes.
sealed class CryptoQuoteState {
  const CryptoQuoteState();
}

/// State representing the initial state of cryptocurrency quotes.
class CryptoQuoteStateInitial extends CryptoQuoteState {
  /// Creates an instance of [CryptoQuoteStateInitial].
  const CryptoQuoteStateInitial();
}

/// State representing the loading state of cryptocurrency quotes.
class CryptoQuoteStateLoading extends CryptoQuoteState {
  /// Creates an instance of [CryptoQuoteStateLoading].
  const CryptoQuoteStateLoading();
}

/// State representing the successful retrieval of cryptocurrency quotes.
class CryptoQuoteStateSuccess extends CryptoQuoteState {
  /// Creates an instance of [CryptoQuoteStateSuccess].
  const CryptoQuoteStateSuccess(this.quotes, {this.fromCache = false});

  /// List of cryptocurrency quotes that were successfully retrieved.
  final List<CryptoQuoteEntity> quotes;

  /// Indicates whether the quotes were retrieved from cache (true) or from the
  /// remote API (false).
  final bool fromCache;
}

/// State representing the failure to retrieve cryptocurrency quotes.
class CryptoQuoteStateFailure extends CryptoQuoteState {
  /// Creates an instance of [CryptoQuoteStateFailure].
  const CryptoQuoteStateFailure(this.message);

  /// Error message describing the failure to retrieve cryptocurrency quotes.
  final String message;
}
