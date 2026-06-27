import 'package:flutter_clean_arch_riverpod/application/quotes/get_klines_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_klines.dart';

void main() {
  late MockKlineRepository mockRepository;
  late GetKlinesUseCase useCase;

  setUp(() {
    mockRepository = MockKlineRepository();
    useCase = GetKlinesUseCase(repository: mockRepository);
  });

  group('GetKlinesUseCase', () {
    test('retorna klines do repositório com parâmetros corretos', () async {
      when(
        () => mockRepository.getKlines(
          symbol: 'BTCUSDT',
          interval: '1h',
          limit: 24,
        ),
      ).thenAnswer((_) async => tKlines);

      final List<Kline> result = await useCase.call(
        symbol: 'BTCUSDT',
        interval: '1h',
      );

      expect(result, equals(tKlines));
      verify(
        () => mockRepository.getKlines(
          symbol: 'BTCUSDT',
          interval: '1h',
          limit: 24,
        ),
      ).called(1);
    });

    test('repassa limit personalizado ao repositório', () async {
      when(
        () => mockRepository.getKlines(
          symbol: 'ETHUSDT',
          interval: '4h',
          limit: 48,
        ),
      ).thenAnswer((_) async => tKlines);

      final List<Kline> result = await useCase.call(
        symbol: 'ETHUSDT',
        interval: '4h',
        limit: 48,
      );

      expect(result, equals(tKlines));
    });

    test('propaga exceção quando repositório lança erro', () async {
      when(
        () => mockRepository.getKlines(
          symbol: any(named: 'symbol'),
          interval: any(named: 'interval'),
          limit: any(named: 'limit'),
        ),
      ).thenThrow(Exception('sem rede'));

      expect(
        () => useCase.call(symbol: 'BTCUSDT', interval: '1h'),
        throwsException,
      );
    });
  });
}
