import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/mappers/crypto_quote_mapper.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/crypto_quote_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const Map<String, dynamic> tJson = <String, dynamic>{
    'symbol': 'BTCUSDT',
    'priceChange': '1000',
    'priceChangePercent': '2',
    'lastPrice': '50000',
    'highPrice': '51000',
    'lowPrice': '49000',
    'volume': '1000',
    'quoteVolume': '50000000',
  };

  group('CryptoQuoteDTOMapper.toEntity', () {
    test('converte DTO em entidade com valores corretos', () {
      final CryptoQuoteDTO dto = CryptoQuoteDTO.fromJson(tJson);
      final CryptoQuoteEntity entity = dto.toEntity();

      expect(entity.symbol, equals('BTCUSDT'));
      expect(entity.lastPrice, equals(50000.0));
      expect(entity.priceChange, equals(1000.0));
      expect(entity.priceChangePct, equals(2.0));
      expect(entity.highPrice, equals(51000.0));
      expect(entity.lowPrice, equals(49000.0));
      expect(entity.volume, equals(1000.0));
      expect(entity.quoteVolume, equals(50000000.0));
    });

    test('usa zeros como fallback para campos nulos ou inválidos', () {
      const CryptoQuoteDTO dto = CryptoQuoteDTO();
      final CryptoQuoteEntity entity = dto.toEntity();

      expect(entity.symbol, equals(''));
      expect(entity.lastPrice, equals(0.0));
      expect(entity.priceChange, equals(0.0));
    });
  });
}
