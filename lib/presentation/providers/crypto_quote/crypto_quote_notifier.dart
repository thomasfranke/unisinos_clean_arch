import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arch_riverpod/application/quotes/get_crypto_quotes_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/quote_result.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/crypto_quote/crypto_quote_state.dart';

/// Notifier for managing the state of cryptocurrency quotes.
class CryptoQuoteNotifier extends ChangeNotifier {
  /// Creates an instance of [CryptoQuoteNotifier].
  CryptoQuoteNotifier({required this.getQuotesUseCase}) {
    unawaited(fetchQuotes());
  }

  /// Use case for fetching cryptocurrency quotes.
  final GetCryptoQuotesUseCase getQuotesUseCase;

  CryptoQuoteState _state = const CryptoQuoteStateLoading();

  /// Current state of cryptocurrency quotes.
  CryptoQuoteState get state => _state;

  /// Fetches cryptocurrency quotes and updates the state accordingly.
  /// Sets [CryptoQuoteStateSuccess.fromCache] to true if data came from cache.
  Future<void> fetchQuotes() async {
    _state = const CryptoQuoteStateLoading();
    notifyListeners();
    try {
      final QuoteResult result = await getQuotesUseCase.call();
      _state = CryptoQuoteStateSuccess(
        result.quotes,
        fromCache: result.fromCache,
      );
    } on Object catch (e) {
      _state = CryptoQuoteStateFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
