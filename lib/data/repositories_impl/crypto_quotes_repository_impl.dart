import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_local_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_remote_datasource.dart';
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
    required this.remoteDatasource,
    required this.localDatasource,
  });

  /// Remote data source for fetching cryptocurrency quotes from an API.
  final CryptoQuotesRemoteDatasource remoteDatasource;

  /// Local cache data source for storing and retrieving cryptocurrency quotes
  /// when the remote data source is unavailable or fails.
  final CryptoQuotesLocalDatasource localDatasource;

  @override
  Future<QuoteResult> getQuotes() async {
    try {
      final List<CryptoQuoteDTO> dtos = await remoteDatasource.getQuotes();
      await localDatasource.saveQuotes(dtos);
      return QuoteResult(
        dtos.map((CryptoQuoteDTO dto) => dto.toEntity()).toList(),
      );
    } on Object catch (e, st) {
      debugPrint('Remote failed, falling back to cache: $e');
      debugPrintStack(stackTrace: st);

      final List<CryptoQuoteDTO> cached = localDatasource.getQuotes();
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
    final CryptoQuoteDTO dto = await remoteDatasource.getQuote(symbol);
    return dto.toEntity();
  }
}
