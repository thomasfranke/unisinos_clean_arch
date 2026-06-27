import 'package:flutter_clean_arch_riverpod/data/data_objects/kline_dto.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/kline_datasource.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/models/response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_api_client.dart';
import '../../mocks/mock_klines.dart';

void main() {
  late MockApiClientInterface mockApiClient;
  late KlineDatasource datasource;

  setUpAll(() {
    registerFallbackValue(kFallbackApiRoute);
  });

  setUp(() {
    mockApiClient = MockApiClientInterface();
    datasource = KlineDatasource(apiClient: mockApiClient);
  });

  ApiResponse<dynamic> responseWith(dynamic data) =>
      ApiResponse<dynamic>(data: data, statusCode: 200);

  group('KlineDatasource.getKlines', () {
    test('retorna lista de DTOs quando API responde com sucesso', () async {
      when(
        () => mockApiClient.request(
          apiRoute: any(named: 'apiRoute'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => responseWith(<dynamic>[tRawKlineList]),
      );

      final List<KlineDTO> result = await datasource.getKlines(
        symbol: 'BTCUSDT',
        interval: '1h',
      );

      expect(result, hasLength(1));
      expect(result.first.open, equals('50000'));
    });

    test('propaga exceção quando parsing falha', () async {
      when(
        () => mockApiClient.request(
          apiRoute: any(named: 'apiRoute'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => responseWith('resposta inválida'));

      expect(
        () => datasource.getKlines(symbol: 'BTCUSDT', interval: '1h'),
        throwsA(isA<TypeError>()),
      );
    });

    test('propaga exceção quando API lança erro', () async {
      when(
        () => mockApiClient.request(
          apiRoute: any(named: 'apiRoute'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(Exception('sem rede'));

      expect(
        () => datasource.getKlines(symbol: 'BTCUSDT', interval: '1h'),
        throwsException,
      );
    });
  });
}
