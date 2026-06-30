import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/storage/storage_interface.dart';

const String _cacheKey = 'cache_crypto_quotes';

/// Local cache datasource for cryptocurrency quotes using [StorageInterface].
class CryptoQuotesLocalDatasource {
  /// Creates a [CryptoQuotesLocalDatasource] with the given [storage].
  const CryptoQuotesLocalDatasource({required this.storage});

  /// Storage interface used to persist and retrieve cached cryptocurrency
  /// quotes.
  final StorageInterface storage;

  /// Returns cached quotes, or an empty list if none exist.
  List<CryptoQuoteDTO> getQuotes() {
    try {
      final String? raw = storage.getString(key: _cacheKey);
      if (raw == null) {
        return <CryptoQuoteDTO>[];
      }
      return (jsonDecode(raw) as List<dynamic>)
          .map(
            (dynamic e) => CryptoQuoteDTO.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on Object catch (e, st) {
      debugPrint('Cache read error: $e');
      debugPrintStack(stackTrace: st);
      return <CryptoQuoteDTO>[];
    }
  }

  /// Persists quotes to local storage.
  Future<void> saveQuotes(final List<CryptoQuoteDTO> quotes) async {
    try {
      final String encoded = jsonEncode(
        quotes
            .map(
              (CryptoQuoteDTO dto) => <String, dynamic>{
                'symbol': dto.symbol,
                'priceChange': dto.priceChange,
                'priceChangePercent': dto.priceChangePercent,
                'lastPrice': dto.lastPrice,
                'highPrice': dto.highPrice,
                'lowPrice': dto.lowPrice,
                'volume': dto.volume,
                'quoteVolume': dto.quoteVolume,
              },
            )
            .toList(),
      );
      await storage.setString(key: _cacheKey, value: encoded);
    } on Object catch (e, st) {
      debugPrint('Cache write error: $e');
      debugPrintStack(stackTrace: st);
    }
  }
}
