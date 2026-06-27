import 'package:flutter_clean_arch_riverpod/domain/entities/kline_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/klines/kline_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/klines/kline_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_klines.dart';

void main() {
  late MockGetKlinesUseCase mockGetKlines;

  setUp(() {
    mockGetKlines = MockGetKlinesUseCase();
  });

  KlineNotifier buildNotifier({String symbol = 'BTCUSDT'}) => KlineNotifier(
    getKlinesUseCase: mockGetKlines,
    symbol: symbol,
  );

  group('KlineState', () {
    test('KlineStateInitial pode ser instanciada', () {
      expect(const KlineStateInitial(), isA<KlineStateInitial>());
    });
  });

  group('KlineNotifier.loadKlines', () {
    test('inicia em loading e transiciona para success', () async {
      when(
        () => mockGetKlines.call(
          symbol: any(named: 'symbol'),
          interval: any(named: 'interval'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => tKlines);

      final KlineNotifier notifier = buildNotifier();

      expect(notifier.state, isA<KlineStateLoading>());

      await Future<void>.delayed(Duration.zero);

      expect(notifier.state, isA<KlineStateSuccess>());
      final KlineStateSuccess success = notifier.state as KlineStateSuccess;
      expect(success.klines, equals(tKlines));
    });

    test('transiciona para failure quando use case lança exceção', () async {
      when(
        () => mockGetKlines.call(
          symbol: any(named: 'symbol'),
          interval: any(named: 'interval'),
          limit: any(named: 'limit'),
        ),
      ).thenThrow(Exception('sem rede'));

      final KlineNotifier notifier = buildNotifier();

      await Future<void>.delayed(Duration.zero);

      expect(notifier.state, isA<KlineStateFailure>());
    });

    test('currentInterval inicia como 1h', () async {
      when(
        () => mockGetKlines.call(
          symbol: any(named: 'symbol'),
          interval: any(named: 'interval'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => tKlines);

      final KlineNotifier notifier = buildNotifier();

      expect(notifier.currentInterval, equals('1h'));
    });
  });

  group('KlineNotifier.switchInterval', () {
    test('atualiza interval e recarrega klines', () async {
      when(
        () => mockGetKlines.call(
          symbol: any(named: 'symbol'),
          interval: any(named: 'interval'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => tKlines);

      final KlineNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.switchInterval(symbol: 'BTCUSDT', interval: '4h');

      expect(notifier.currentInterval, equals('4h'));
      expect(notifier.state, isA<KlineStateSuccess>());
      verify(
        () => mockGetKlines.call(
          symbol: any(named: 'symbol'),
          interval: any(named: 'interval'),
          limit: any(named: 'limit'),
        ),
      ).called(2);
    });

    test('atualiza para failure ao trocar interval com erro', () async {
      when(
        () => mockGetKlines.call(
          symbol: any(named: 'symbol'),
          interval: '1h',
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => tKlines);
      when(
        () => mockGetKlines.call(
          symbol: any(named: 'symbol'),
          interval: '4h',
          limit: any(named: 'limit'),
        ),
      ).thenThrow(Exception('erro'));

      final KlineNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.switchInterval(symbol: 'BTCUSDT', interval: '4h');

      expect(notifier.state, isA<KlineStateFailure>());
    });
  });

  group('KlineNotifier — lista vazia', () {
    test('transiciona para success com lista vazia', () async {
      when(
        () => mockGetKlines.call(
          symbol: any(named: 'symbol'),
          interval: any(named: 'interval'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => <Kline>[]);

      final KlineNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      final KlineStateSuccess success = notifier.state as KlineStateSuccess;
      expect(success.klines, isEmpty);
    });
  });
}
