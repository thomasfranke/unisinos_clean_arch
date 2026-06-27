import 'dart:convert';

import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_cache_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_crypto_quotes_datasource.dart';
import '../../mocks/mock_storage.dart';

void main() {
  late MockStorageInterface mockStorage;
  late CryptoQuotesCacheDatasource datasource;

  setUp(() {
    mockStorage = MockStorageInterface();
    datasource = CryptoQuotesCacheDatasource(storage: mockStorage);
  });

  group('CryptoQuotesCacheDatasource.getQuotes', () {
    test('retorna lista de DTOs quando cache contém dados válidos', () {
      final String encoded = jsonEncode(
        tDTOs
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
      when(
        () => mockStorage.getString(key: any(named: 'key')),
      ).thenReturn(encoded);

      final List<CryptoQuoteDTO> result = datasource.getQuotes();

      expect(result, hasLength(tDTOs.length));
      expect(result.first.symbol, equals('BTCUSDT'));
    });

    test('retorna lista vazia quando cache está ausente', () {
      when(
        () => mockStorage.getString(key: any(named: 'key')),
      ).thenReturn(null);

      final List<CryptoQuoteDTO> result = datasource.getQuotes();

      expect(result, isEmpty);
    });

    test('retorna lista vazia quando cache contém JSON inválido', () {
      when(
        () => mockStorage.getString(key: any(named: 'key')),
      ).thenReturn('json inválido {{{');

      final List<CryptoQuoteDTO> result = datasource.getQuotes();

      expect(result, isEmpty);
    });
  });

  group('CryptoQuotesCacheDatasource.saveQuotes', () {
    test('serializa e persiste quotes no storage', () async {
      when(
        () => mockStorage.setString(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await datasource.saveQuotes(tDTOs);

      verify(
        () => mockStorage.setString(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });

    test('não lança exceção quando storage falha ao salvar', () async {
      when(
        () => mockStorage.setString(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('erro de escrita'));

      await expectLater(datasource.saveQuotes(tDTOs), completes);
    });
  });
}
