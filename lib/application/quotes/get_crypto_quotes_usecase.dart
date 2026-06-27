import 'package:flutter_clean_arch_riverpod/domain/entities/quote_result.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/crypto_quotes_repository_interface.dart';

/// Use case for fetching the list of cryptocurrency quotes.
class GetCryptoQuotesUseCase {
  /// Creates an instance of [GetCryptoQuotesUseCase] with the
  /// given [repository].
  const GetCryptoQuotesUseCase({required this.repository});

  /// Repository for fetching cryptocurrency quotes.
  final CryptoQuoteRepository repository;

  /// Fetches the list of cryptocurrency quotes.
  Future<QuoteResult> call() => repository.getQuotes();
}
