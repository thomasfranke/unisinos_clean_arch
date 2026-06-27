import 'package:flutter_clean_arch_riverpod/data/repositories_impl/kline_repository_impl.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_klines.dart';

void main() {
  late MockKlineDatasource mockDatasource;
  late KlineRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockKlineDatasource();
    repository = KlineRepositoryImpl(datasource: mockDatasource);
  });

  group('KlineRepositoryImpl.getKlines', () {
    test('converte DTOs em entidades e repassa parâmetros corretamente',
        () async {
      when(
        () => mockDatasource.getKlines(
          symbol: 'BTCUSDT',
          interval: '1h',
        ),
      ).thenAnswer((_) async => tKlineDTOs);

      final List<Kline> result = await repository.getKlines(
        symbol: 'BTCUSDT',
        interval: '1h',
      );

      expect(result, hasLength(1));
      expect(result.first.open, equals(50000.0));
      expect(result.first.numberOfTrades, equals(500));
    });

    test('propaga exceção quando datasource lança erro', () async {
      when(
        () => mockDatasource.getKlines(
          symbol: any(named: 'symbol'),
          interval: any(named: 'interval'),
          limit: any(named: 'limit'),
        ),
      ).thenThrow(Exception('sem rede'));

      expect(
        () => repository.getKlines(symbol: 'BTCUSDT', interval: '1h'),
        throwsException,
      );
    });
  });
}
