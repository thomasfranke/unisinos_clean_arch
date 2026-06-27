import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const Map<String, dynamic> tJson = <String, dynamic>{
    'symbol': 'BTCUSDT',
    'priceChange': '1000',
    'priceChangePercent': '2',
    'weightedAvgPrice': '50200',
    'prevClosePrice': '49000',
    'lastPrice': '50000',
    'lastQty': '0.1',
    'bidPrice': '50000',
    'bidQty': '1.0',
    'askPrice': '50001',
    'askQty': '1.0',
    'openPrice': '49000',
    'highPrice': '51000',
    'lowPrice': '49000',
    'volume': '1000',
    'quoteVolume': '50000000',
    'openTime': 1704067200000,
    'closeTime': 1704070800000,
    'firstId': 1,
    'lastId': 100,
    'count': 100,
  };

  group('CryptoQuoteDTO.fromJson', () {
    test('parseia todos os campos corretamente', () {
      final CryptoQuoteDTO dto = CryptoQuoteDTO.fromJson(tJson);

      expect(dto.symbol, equals('BTCUSDT'));
      expect(dto.priceChange, equals('1000'));
      expect(dto.priceChangePercent, equals('2'));
      expect(dto.weightedAvgPrice, equals('50200'));
      expect(dto.prevClosePrice, equals('49000'));
      expect(dto.lastPrice, equals('50000'));
      expect(dto.lastQty, equals('0.1'));
      expect(dto.bidPrice, equals('50000'));
      expect(dto.bidQty, equals('1.0'));
      expect(dto.askPrice, equals('50001'));
      expect(dto.askQty, equals('1.0'));
      expect(dto.openPrice, equals('49000'));
      expect(dto.highPrice, equals('51000'));
      expect(dto.lowPrice, equals('49000'));
      expect(dto.volume, equals('1000'));
      expect(dto.quoteVolume, equals('50000000'));
      expect(dto.openTime, equals(1704067200000));
      expect(dto.closeTime, equals(1704070800000));
      expect(dto.firstId, equals(1));
      expect(dto.lastId, equals(100));
      expect(dto.count, equals(100));
    });

    test('aceita campos nulos quando ausentes no JSON', () {
      final CryptoQuoteDTO dto = CryptoQuoteDTO.fromJson(
        const <String, dynamic>{},
      );

      expect(dto.symbol, isNull);
      expect(dto.lastPrice, isNull);
      expect(dto.openTime, isNull);
    });
  });
}
