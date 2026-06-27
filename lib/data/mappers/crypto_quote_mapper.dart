import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';

/// Extension to map [CryptoQuoteDTO] to domain entities.
extension CryptoQuoteDTOMapper on CryptoQuoteDTO {
  /// Converts this DTO to a [CryptoQuoteEntity] domain entity.
  CryptoQuoteEntity toEntity() => CryptoQuoteEntity(
    symbol: symbol ?? '',
    lastPrice: double.tryParse(lastPrice ?? '') ?? 0.0,
    priceChange: double.tryParse(priceChange ?? '') ?? 0.0,
    priceChangePct: double.tryParse(priceChangePercent ?? '') ?? 0.0,
    highPrice: double.tryParse(highPrice ?? '') ?? 0.0,
    lowPrice: double.tryParse(lowPrice ?? '') ?? 0.0,
    volume: double.tryParse(volume ?? '') ?? 0.0,
    quoteVolume: double.tryParse(quoteVolume ?? '') ?? 0.0,
  );
}
