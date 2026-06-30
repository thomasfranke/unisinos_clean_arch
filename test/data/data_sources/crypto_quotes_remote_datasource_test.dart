import 'package:flutter_clean_arch_riverpod/data/data_objects/crypto_quote_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_remote_datasource.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_api_client.dart';

void main() {
  late MockApiClientInterface mockApiClient;
  late CryptoQuotesRemoteDatasource datasource;

  setUpAll(() {
    registerFallbackValue(kFallbackApiRoute);
  });

  setUp(() {
    mockApiClient = MockApiClientInterface();
    datasource = CryptoQuotesRemoteDatasource(apiClient: mockApiClient);
  });

  ApiResponse<dynamic> responseWith(dynamic data) =>
      ApiResponse<dynamic>(data: data, statusCode: 200);

  group('CryptoQuoteDatasource.getQuotes', () {
    final List<dynamic> tRawList = <dynamic>[
      <String, dynamic>{
        'symbol': 'BTCUSDT',
        'priceChange': '1000',
        'priceChangePercent': '2',
        'lastPrice': '50000',
        'highPrice': '51000',
        'lowPrice': '49000',
        'volume': '1000',
        'quoteVolume': '50000000',
      },
    ];

    test('retorna lista de DTOs quando API responde com sucesso', () async {
      when(
        () => mockApiClient.request(apiRoute: any(named: 'apiRoute')),
      ).thenAnswer((_) async => responseWith(tRawList));

      final List<CryptoQuoteDTO> result = await datasource.getQuotes();

      expect(result, hasLength(1));
      expect(result.first.symbol, equals('BTCUSDT'));
    });

    test('propaga exceção quando parsing falha', () async {
      when(
        () => mockApiClient.request(apiRoute: any(named: 'apiRoute')),
      ).thenAnswer((_) async => responseWith('resposta inválida'));

      expect(() => datasource.getQuotes(), throwsA(isA<TypeError>()));
    });

    test('propaga exceção quando API lança erro', () async {
      when(
        () => mockApiClient.request(apiRoute: any(named: 'apiRoute')),
      ).thenThrow(Exception('sem rede'));

      expect(() => datasource.getQuotes(), throwsException);
    });
  });

  group('CryptoQuoteDatasource.getQuote', () {
    const Map<String, dynamic> tRawQuote = <String, dynamic>{
      'symbol': 'BTCUSDT',
      'lastPrice': '50000',
      'priceChange': '1000',
      'priceChangePercent': '2',
      'highPrice': '51000',
      'lowPrice': '49000',
      'volume': '1000',
      'quoteVolume': '50000000',
    };

    test('retorna DTO para símbolo específico', () async {
      when(
        () => mockApiClient.request(
          apiRoute: any(named: 'apiRoute'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => responseWith(tRawQuote));

      final CryptoQuoteDTO result = await datasource.getQuote('BTCUSDT');

      expect(result.symbol, equals('BTCUSDT'));
      expect(result.lastPrice, equals('50000'));
    });

    test('propaga exceção quando parsing falha', () async {
      when(
        () => mockApiClient.request(
          apiRoute: any(named: 'apiRoute'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => responseWith('resposta inválida'));

      expect(() => datasource.getQuote('BTCUSDT'), throwsA(isA<TypeError>()));
    });
  });
}
