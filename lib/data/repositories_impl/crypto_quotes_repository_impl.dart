import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_cache_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/mappers/crypto_quote_mapper.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/quote_result.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/crypto_quotes_repository_interface.dart';

/// Repository implementation for fetching cryptocurrency quotes, utilizing both
/// a remote data source and a local cache for fallback.
class CryptoQuotesRepositoryImpl implements CryptoQuoteRepository {
  /// Creates an instance of [CryptoQuotesRepositoryImpl] with the given remote
  /// data source and local cache data source.
  const CryptoQuotesRepositoryImpl({
    required this.datasource,
    required this.cacheDatasource,
  });

  /// Remote data source for fetching cryptocurrency quotes from an API.
  final CryptoQuoteDatasource datasource;

  /// Local cache data source for storing and retrieving cryptocurrency quotes
  /// when the remote data source is unavailable or fails.
  final CryptoQuotesCacheDatasource cacheDatasource;

  @override
  Future<QuoteResult> getQuotes() async {
    try {
      final List<CryptoQuoteDTO> dtos = await datasource.getQuotes();
      await cacheDatasource.saveQuotes(dtos);
      return QuoteResult(
        dtos.map((CryptoQuoteDTO dto) => dto.toEntity()).toList(),
      );
    } on Object catch (e, st) {
      debugPrint('Remote failed, falling back to cache: $e');
      debugPrintStack(stackTrace: st);

      final List<CryptoQuoteDTO> cached = cacheDatasource.getQuotes();
      if (cached.isNotEmpty) {
        return QuoteResult(
          cached.map((CryptoQuoteDTO dto) => dto.toEntity()).toList(),
          fromCache: true,
        );
      }

      rethrow;
    }
  }

  @override
  Future<CryptoQuoteEntity> getQuote(final String symbol) async {
    final CryptoQuoteDTO dto = await datasource.getQuote(symbol);
    return dto.toEntity();
  }
}
